import logging
import os
import webbrowser
from datetime import timedelta
from pathlib import Path

from databricks.labs.blueprint.installation import Installation
from databricks.labs.blueprint.installer import InstallState
from databricks.labs.blueprint.tui import Prompts
from databricks.labs.blueprint.wheels import ProductInfo
from databricks.sdk import WorkspaceClient
from databricks.sdk.errors import NotFound

from databricks.labs.remorph.cli import raise_validation_exception
from databricks.labs.remorph.config import MorphConfig

DEBUG_NOTEBOOK = """# Databricks notebook source
# MAGIC %md
# MAGIC # Debug companion for Remorph installation (see [README]({readme_link}))
# MAGIC
# MAGIC Production runs are supposed to be triggered through the following jobs: {job_links}
# MAGIC
# MAGIC **This notebook is overwritten with each Remorph update/(re)install.**

# COMMAND ----------

# MAGIC %pip install /Workspace{remote_wheel}
dbutils.library.restartPython()

# COMMAND ----------

import logging
from pathlib import Path
from databricks.labs.blueprint.logger import install_logger
from databricks.labs.remorph.__about__ import __version__
from databricks.labs.remorph.config import WorkspaceConfig
from databricks.sdk import WorkspaceClient

install_logger()
logging.getLogger("databricks").setLevel("DEBUG")

cfg = WorkspaceConfig.from_file(Path("/Workspace{config_file}"))
ws = WorkspaceClient()

print(__version__)
"""

logger = logging.getLogger(__name__)

PRODUCT_INFO = ProductInfo(__file__)


class WorkspaceInstaller:
    def __init__(self, prompts: Prompts, installation: Installation, ws: WorkspaceClient):
        if "DATABRICKS_RUNTIME_VERSION" in os.environ:
            msg = "WorkspaceInstaller is not supposed to be executed in Databricks Runtime"
            raise SystemExit(msg)
        self._ws = ws
        self._installation = installation
        self._prompts = prompts

    def run(self):
        logger.info(f"Installing Remorph v{PRODUCT_INFO.version()}")
        config = self.configure()
        workspace_installation = WorkspaceInstallation(
            config,
            self._installation,
            self._ws,
            self._prompts,
            verify_timeout=timedelta(minutes=2),
        )
        workspace_installation.run()

    def configure(self) -> MorphConfig:
        try:
            return self._installation.load(MorphConfig)
        except NotFound as err:
            logger.debug(f"Cannot find previous installation: {err}")
        logger.info("Please answer a couple of questions to configure Remorph")

        source_prompt = self._prompts.choice("Select a source", ["snowflake", "tsql"])
        source = source_prompt.lower()

        input_sql = self._prompts.question("Enter input_sql path")

        if not os.path.exists(input_sql) or input_sql in (None, ""):
            raise_validation_exception(f"Error: Invalid value for '--input_sql': Path '{input_sql}' does not exist.")

        output_folder = self._prompts.question("Enter output_folder path", default="")

        if output_folder == "":
            output_folder = None

        skip_validation_str = self._prompts.choice_from_dict(
            "Do you want to Skip Validation", {"Yes": "true", "No": "false"}
        )
        skip_validation = skip_validation_str == "true"  # convert to bool

        catalog_name = self._prompts.question("Enter catalog_name")

        schema_name = self._prompts.question("Enter schema_name")

        config = MorphConfig(
            source=source,
            input_sql=input_sql,
            output_folder=output_folder,
            skip_validation=skip_validation,
            catalog_name=catalog_name,
            schema_name=schema_name,
            sdk_config=self._ws.config,
        )

        ws_file_url = self._installation.save(config)
        if self._prompts.confirm("Open config file in the browser and continue installing?"):
            webbrowser.open(ws_file_url)
        return config


class WorkspaceInstallation:
    def __init__(
        self,
        config: MorphConfig,
        installation: Installation,
        ws: WorkspaceClient,
        prompts: Prompts,
        verify_timeout: timedelta,
    ):
        self._config = config
        self._installation = installation
        self._ws = ws
        self._prompts = prompts
        self._verify_timeout = verify_timeout
        self._state = InstallState.from_installation(installation)
        self._this_file = Path(__file__)

    @classmethod
    def current(cls, ws: WorkspaceClient):
        installation = Installation.current(ws, PRODUCT_INFO.product_name())
        config = installation.load(MorphConfig)
        prompts = Prompts()
        timeout = timedelta(minutes=2)
        return WorkspaceInstallation(config, installation, ws, prompts, timeout)

    @property
    def config(self):
        return self._config

    @property
    def folder(self):
        return self._installation.install_folder()

    def run(self):
        logger.info(f"Installing Remorph v{PRODUCT_INFO.version()}")
        self._create_debug()
        logger.info("Installation completed successfully! Please refer to the  for the next steps.")

    def config_file_link(self):
        return self._installation.workspace_link("config.yml")

    @property
    def _config_file(self):
        return f"{self._installation.install_folder()}/config.yml"

    def _name(self, name: str) -> str:
        prefix = os.path.basename(self._installation.install_folder()).removeprefix(".")
        return f"[{prefix.upper()}] {name}"

    def _create_debug(self, remote_wheel: str):
        readme_link = self._installation.workspace_link("README")
        job_links = ", ".join(
            f"[{self._name(step_name)}]({self._ws.config.host}#job/{job_id})"
            for step_name, job_id in self._state.jobs.items()
        )
        content = DEBUG_NOTEBOOK.format(
            remote_wheel=remote_wheel, readme_link=readme_link, job_links=job_links, config_file=self._config_file
        ).encode("utf8")
        self._installation.upload("DEBUG.py", content)

    def uninstall(self):
        if self._prompts and not self._prompts.confirm(
            "Do you want to uninstall remorph from the workspace too, this would remove remorph project folder"
        ):
            return
        # TODO: this is incorrect, fetch the remote version (that appeared only in Feb 2024)
        logger.info(f"Deleting Remorph v{PRODUCT_INFO.version()} from {self._ws.config.host}")
        try:
            self._installation.files()
        except NotFound:
            logger.error(f"Check if {self._installation.install_folder()} is present")
            return
        self._installation.remove()
        logger.info("UnInstalling Remorph complete")