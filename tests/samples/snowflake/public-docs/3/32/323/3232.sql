ALTER TABLE [ IF EXISTS ] <name> RENAME TO <new_table_name>

ALTER TABLE [ IF EXISTS ] <name> SWAP WITH <target_table_name>

ALTER TABLE [ IF EXISTS ] <name> { clusteringAction | tableColumnAction | constraintAction  }

ALTER TABLE [ IF EXISTS ] <name> extTableColumnAction

ALTER TABLE [ IF EXISTS ] <name> searchOptimizationAction

ALTER TABLE [ IF EXISTS ] <name> SET
  [ STAGE_FILE_FORMAT = ( { FORMAT_NAME = '<file_format_name>' | TYPE = { CSV | JSON | AVRO | ORC | PARQUET | XML } [ formatTypeOptions ] } ) ]
  [ STAGE_COPY_OPTIONS = ( copyOptions ) ]
  [ DATA_RETENTION_TIME_IN_DAYS = <integer> ]
  [ MAX_DATA_EXTENSION_TIME_IN_DAYS = <integer> ]
  [ CHANGE_TRACKING = { TRUE | FALSE  } ]
  [ DEFAULT_DDL_COLLATION = '<collation_specification>' ]
  [ ENABLE_SCHEMA_EVOLUTION = { TRUE | FALSE } ]
  [ COMMENT = '<string_literal>' ]

ALTER TABLE [ IF EXISTS ] <name> SET TAG <tag_name> = '<tag_value>' [ , <tag_name> = '<tag_value>' ... ]

ALTER TABLE [ IF EXISTS ] <name> UNSET TAG <tag_name> [ , <tag_name> ... ]

ALTER TABLE [ IF EXISTS ] <name> UNSET {
                                       DATA_RETENTION_TIME_IN_DAYS         |
                                       MAX_DATA_EXTENSION_TIME_IN_DAYS     |
                                       CHANGE_TRACKING                     |
                                       DEFAULT_DDL_COLLATION               |
                                       ENABLE_SCHEMA_EVOLUTION             |
                                       COMMENT                             |
                                       }
                                       [ , ... ]
ALTER TABLE [ IF EXISTS ] <name>
  ADD ROW ACCESS POLICY <policy_name> ON (<col_name> [ , ... ])

ALTER TABLE [ IF EXISTS ] <name>
  DROP ROW ACCESS POLICY <policy_name>

ALTER TABLE [ IF EXISTS ] <name>
  DROP ROW ACCESS POLICY <policy_name>,
  ADD ROW ACCESS POLICY <policy_name> ON (<col_name> [ , ... ])

ALTER TABLE [ IF EXISTS ] <name> DROP ALL ROW ACCESS POLICIES