import re
import shutil
from pathlib import Path
from unittest.mock import create_autospec, patch

import pytest
from databricks.connect import DatabricksSession
from databricks.sdk.core import Config

from databricks.labs.remorph.config import MorphConfig
from databricks.labs.remorph.helpers.file_utils import make_dir
from databricks.labs.remorph.helpers.validate import Validate
from databricks.labs.remorph.transpiler.execute import morph


def safe_remove_dir(dir_path: Path):
    if dir_path.exists():
        shutil.rmtree(dir_path)


def safe_remove_file(file_path: Path):
    if file_path.exists():
        file_path.unlink()


def write_data_to_file(path: Path, content: str):
    with path.open("w") as writable:
        writable.write(content)


@pytest.fixture
def initial_setup(tmp_path: Path):
    input_dir = tmp_path / "remorph_transpile"
    query_1_sql_file = input_dir / "query1.sql"
    query_2_sql_file = input_dir / "query2.sql"
    query_3_sql_file = input_dir / "query3.sql"
    stream_1_sql_file = input_dir / "stream1.sql"
    call_center_ddl_file = input_dir / "call_center.ddl"
    file_text = input_dir / "file.txt"
    safe_remove_dir(input_dir)
    make_dir(input_dir)

    query_1_sql = """select  i_manufact, sum(ss_ext_sales_price) ext_price from date_dim, store_sales where
    d_date_sk = ss_sold_date_sk and substr(ca_zip,1,5) <> substr(s_zip,1,5) group by i_manufact order by i_manufact
    limit 100 ;"""

    call_center_ddl = """create table call_center
        (
            cc_call_center_sk         int                           ,
            cc_call_center_id         varchar(16)
        )

         CLUSTER BY(cc_call_center_sk)
         """

    query_2_sql = """select wswscs.d_week_seq d_week_seq1,sun_sales sun_sales1,mon_sales mon_sales1 from wswscs,
    date_dim where date_dim.d_week_seq = wswscs.d_week_seq and d_year = 2001"""

    query_3_sql = """with wscs as
     (select sold_date_sk
            ,sales_price
      from (select ws_sold_date_sk sold_date_sk
                  ,ws_ext_sales_price sales_price
            from web_sales
            union all
            select cs_sold_date_sk sold_date_sk
                  ,cs_ext_sales_price sales_price
            from catalog_sales)),
     wswscs as
     (select d_week_seq,
            sum(case when (d_day_name='Sunday') then sales_price else null end) sun_sales,
            sum(case when (d_day_name='Monday') then sales_price else null end) mon_sales,
            sum(case when (d_day_name='Tuesday') then sales_price else  null end) tue_sales,
            sum(case when (d_day_name='Wednesday') then sales_price else null end) wed_sales,
            sum(case when (d_day_name='Thursday') then sales_price else null end) thu_sales,
            sum(case when (d_day_name='Friday') then sales_price else null end) fri_sales,
            sum(case when (d_day_name='Saturday') then sales_price else null end) sat_sales
     from wscs
         ,date_dim
     where d_date_sk = sold_date_sk
     group by d_week_seq)
     select d_week_seq1
           ,round(sun_sales1/sun_sales2,2)
           ,round(mon_sales1/mon_sales2,2)
           ,round(tue_sales1/tue_sales2,2)
           ,round(wed_sales1/wed_sales2,2)
           ,round(thu_sales1/thu_sales2,2)
           ,round(fri_sales1/fri_sales2,2)
           ,round(sat_sales1/sat_sales2,2)
     from
     (select wswscs.d_week_seq d_week_seq1
            ,sun_sales sun_sales1
            ,mon_sales mon_sales1
            ,tue_sales tue_sales1
            ,wed_sales wed_sales1
            ,thu_sales thu_sales1
            ,fri_sales fri_sales1
            ,sat_sales sat_sales1
      from wswscs,date_dim
      where date_dim.d_week_seq = wswscs.d_week_seq and
            d_year = 2001) y,
     (select wswscs.d_week_seq d_week_seq2
            ,sun_sales sun_sales2
            ,mon_sales mon_sales2
            ,tue_sales tue_sales2
            ,wed_sales wed_sales2
            ,thu_sales thu_sales2
            ,fri_sales fri_sales2
            ,sat_sales sat_sales2
      from wswscs
          ,date_dim
      where date_dim.d_week_seq = wswscs.d_week_seq2 and
            d_year = 2001+1) z
     where d_week_seq1=d_week_seq2-53
     order by d_week_seq1;
     """

    stream_1_sql = """CREATE STREAM unsupported_stream AS SELECT * FROM some_table;"""

    write_data_to_file(query_1_sql_file, query_1_sql)
    write_data_to_file(call_center_ddl_file, call_center_ddl)
    write_data_to_file(query_2_sql_file, query_2_sql)
    write_data_to_file(query_3_sql_file, query_3_sql)
    write_data_to_file(stream_1_sql_file, stream_1_sql)
    write_data_to_file(file_text, "This is a test file")

    return input_dir


def test_with_dir_skip_validation(initial_setup):
    input_dir = initial_setup
    config = MorphConfig(
        input_sql=str(input_dir),
        output_folder="None",
        sdk_config=None,
        source="snowflake",
        skip_validation=True,
    )

    # call morph
    status = morph(config)
    # assert the status
    assert status is not None, "Status returned by morph function is None"
    assert isinstance(status, list), "Status returned by morph function is not a list"
    assert len(status) > 0, "Status returned by morph function is an empty list"
    for stat in status:
        assert stat["total_files_processed"] == 6, "total_files_processed does not match expected value"
        assert stat["total_queries_processed"] == 4, "total_queries_processed does not match expected value"
        assert (
            stat["no_of_sql_failed_while_parsing"] == 0
        ), "no_of_sql_failed_while_parsing does not match expected value"
        assert (
            stat["no_of_sql_failed_while_validating"] == 1
        ), "no_of_sql_failed_while_validating does not match expected value"
        assert stat["error_log_file"], "error_log_file is None or empty"
        assert Path(stat["error_log_file"]).name.startswith("err_") and Path(stat["error_log_file"]).name.endswith(
            ".lst"
        ), "error_log_file does not match expected pattern 'err_*.lst'"

    expected_file_name = f"{input_dir}/query3.sql"
    expected_exception = f"Unsupported operation found in file {input_dir}/query3.sql."
    pattern = r"ValidationError\(file_name='(?P<file_name>[^']+)', exception='(?P<exception>[^']+)'\)"

    with open(Path(status[0]["error_log_file"])) as file:
        for line in file:
            # Skip empty lines
            if line.strip() == "":
                continue

            match = re.match(pattern, line)

            if match:
                # Extract information using group names from the pattern
                error_info = match.groupdict()
                # Perform assertions
                assert error_info["file_name"] == expected_file_name, "File name does not match the expected value"
                assert expected_exception in error_info["exception"], "Exception does not match the expected value"
            else:
                print("No match found.")
    # cleanup
    safe_remove_dir(input_dir)
    safe_remove_file(Path(status[0]["error_log_file"]))


def test_with_dir_with_output_folder_skip_validation(initial_setup):
    input_dir = initial_setup
    config = MorphConfig(
        input_sql=str(input_dir),
        output_folder=str(input_dir / "output_transpiled"),
        sdk_config=None,
        source="snowflake",
        skip_validation=True,
    )

    status = morph(config)
    # assert the status
    assert status is not None, "Status returned by morph function is None"
    assert isinstance(status, list), "Status returned by morph function is not a list"
    assert len(status) > 0, "Status returned by morph function is an empty list"
    for stat in status:
        assert stat["total_files_processed"] == 6, "total_files_processed does not match expected value"
        assert stat["total_queries_processed"] == 4, "total_queries_processed does not match expected value"
        assert (
            stat["no_of_sql_failed_while_parsing"] == 0
        ), "no_of_sql_failed_while_parsing does not match expected value"
        assert (
            stat["no_of_sql_failed_while_validating"] == 1
        ), "no_of_sql_failed_while_validating does not match expected value"
        assert stat["error_log_file"], "error_log_file is None or empty"
        assert Path(stat["error_log_file"]).name.startswith("err_") and Path(stat["error_log_file"]).name.endswith(
            ".lst"
        ), "error_log_file does not match expected pattern 'err_*.lst'"

    expected_file_name = f"{input_dir}/query3.sql"
    expected_exception = f"Unsupported operation found in file {input_dir}/query3.sql."
    pattern = r"ValidationError\(file_name='(?P<file_name>[^']+)', exception='(?P<exception>[^']+)'\)"

    with open(Path(status[0]["error_log_file"])) as file:
        for line in file:
            # Skip empty lines
            if line.strip() == "":
                continue

            match = re.match(pattern, line)

            if match:
                # Extract information using group names from the pattern
                error_info = match.groupdict()
                # Perform assertions
                assert error_info["file_name"] == expected_file_name, "File name does not match the expected value"
                assert expected_exception in error_info["exception"], "Exception does not match the expected value"
            else:
                print("No match found.")

    # cleanup
    safe_remove_dir(input_dir)
    safe_remove_file(Path(status[0]["error_log_file"]))


def test_with_file(initial_setup):
    input_dir = initial_setup
    sdk_config = create_autospec(Config)
    spark = create_autospec(DatabricksSession)
    config = MorphConfig(
        input_sql=str(input_dir / "query1.sql"),
        output_folder="None",
        sdk_config=sdk_config,
        source="snowflake",
        skip_validation=False,
    )
    mock_validate = create_autospec(Validate)
    mock_validate.spark = spark
    mock_validate.validate_format_result.return_value = (""" Mock validated query """, "Mock validation error")

    with patch("databricks.labs.remorph.transpiler.execute.Validate", return_value=mock_validate):
        status = morph(config)

    # assert the status
    assert status is not None, "Status returned by morph function is None"
    assert isinstance(status, list), "Status returned by morph function is not a list"
    assert len(status) > 0, "Status returned by morph function is an empty list"
    for stat in status:
        assert stat["total_files_processed"] == 1, "total_files_processed does not match expected value"
        assert stat["total_queries_processed"] == 1, "total_queries_processed does not match expected value"
        assert (
            stat["no_of_sql_failed_while_parsing"] == 0
        ), "no_of_sql_failed_while_parsing does not match expected value"
        assert (
            stat["no_of_sql_failed_while_validating"] == 1
        ), "no_of_sql_failed_while_validating does not match expected value"
        assert Path(stat["error_log_file"]).name.startswith("err_") and Path(stat["error_log_file"]).name.endswith(
            ".lst"
        ), "error_log_file does not match expected pattern 'err_*.lst'"

    expected_content = f"""
ValidationError(file_name='{input_dir}/query1.sql', exception='Mock validation error')
    """.strip()

    with open(Path(status[0]["error_log_file"])) as file:
        content = file.read().strip()
        assert content == expected_content, "File content does not match the expected content"
    # cleanup
    safe_remove_dir(input_dir)
    safe_remove_file(Path(status[0]["error_log_file"]))


def test_with_file_with_output_folder_skip_validation(initial_setup):
    input_dir = initial_setup
    config = MorphConfig(
        input_sql=str(input_dir / "query1.sql"),
        output_folder=str(input_dir / "output_transpiled"),
        sdk_config=None,
        source="snowflake",
        skip_validation=True,
    )

    status = morph(config)

    # assert the status
    assert status is not None, "Status returned by morph function is None"
    assert isinstance(status, list), "Status returned by morph function is not a list"
    assert len(status) > 0, "Status returned by morph function is an empty list"
    for stat in status:
        assert stat["total_files_processed"] == 1, "total_files_processed does not match expected value"
        assert stat["total_queries_processed"] == 1, "total_queries_processed does not match expected value"
        assert (
            stat["no_of_sql_failed_while_parsing"] == 0
        ), "no_of_sql_failed_while_parsing does not match expected value"
        assert (
            stat["no_of_sql_failed_while_validating"] == 0
        ), "no_of_sql_failed_while_validating does not match expected value"
        assert stat["error_log_file"] == "None", "error_log_file does not match expected value"
    # cleanup
    safe_remove_dir(input_dir)


def test_with_not_a_sql_file_skip_validation(initial_setup):
    input_dir = initial_setup
    config = MorphConfig(
        input_sql=str(input_dir / "file.txt"),
        output_folder="None",
        sdk_config=None,
        source="snowflake",
        skip_validation=True,
    )

    status = morph(config)

    # assert the status
    assert status is not None, "Status returned by morph function is None"
    assert isinstance(status, list), "Status returned by morph function is not a list"
    assert len(status) > 0, "Status returned by morph function is an empty list"
    for stat in status:
        assert stat["total_files_processed"] == 0, "total_files_processed does not match expected value"
        assert stat["total_queries_processed"] == 0, "total_queries_processed does not match expected value"
        assert (
            stat["no_of_sql_failed_while_parsing"] == 0
        ), "no_of_sql_failed_while_parsing does not match expected value"
        assert (
            stat["no_of_sql_failed_while_validating"] == 0
        ), "no_of_sql_failed_while_validating does not match expected value"
        assert stat["error_log_file"] == "None", "error_log_file does not match expected value"
    # cleanup
    safe_remove_dir(input_dir)


def test_with_not_existing_file_skip_validation(initial_setup):
    input_dir = initial_setup
    config = MorphConfig(
        input_sql=str(input_dir / "file_not_exist.txt"),
        output_folder="None",
        sdk_config=None,
        source="snowflake",
        skip_validation=True,
    )
    with pytest.raises(FileNotFoundError):
        morph(config)

    # cleanup
    safe_remove_dir(input_dir)
