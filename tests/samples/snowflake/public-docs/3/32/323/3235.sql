tableColumnAction ::=
  {
     ADD [ COLUMN ] [ IF NOT EXISTS ] <col_name> <col_type>
        [
           {
              DEFAULT <expr>
              | { AUTOINCREMENT | IDENTITY }
                 /* AUTOINCREMENT (or IDENTITY) is supported only for           */
                 /* columns with numeric data types (NUMBER, INT, FLOAT, etc.). */
                 /* Also, if the table is not empty (i.e. if the table contains */
                 /* any rows), only DEFAULT can be altered.                     */
                 [
                    {
                       ( <start_num> , <step_num> )
                       | START <num> INCREMENT <num>
                    }
                 ]
                 [  { ORDER | NOORDER } ]
           }
        ]
        [ inlineConstraint ]
        [ [ WITH ] MASKING POLICY <policy_name> [ USING ( <col1_name> , cond_col_1 , ... ) ] ]
        [ [ WITH ] TAG ( <tag_name> = '<tag_value>' [ , <tag_name> = '<tag_value>' , ... ] ) ]
   | RENAME COLUMN <col_name> TO <new_col_name>

   | ALTER | MODIFY [ ( ]
                            [ COLUMN ] <col1_name> DROP DEFAULT
                          , [ COLUMN ] <col1_name> SET DEFAULT <seq_name>.NEXTVAL
                          , [ COLUMN ] <col1_name> { [ SET ] NOT NULL | DROP NOT NULL }
                          , [ COLUMN ] <col1_name> [ [ SET DATA ] TYPE ] <type>
                          , [ COLUMN ] <col1_name> COMMENT '<string>'
                          , [ COLUMN ] <col1_name> UNSET COMMENT
                        [ , [ COLUMN ] <col2_name> ... ]
                        [ , ... ]
                    [ ) ]

   | ALTER | MODIFY COLUMN <col1_name> SET MASKING POLICY <policy_name> [ USING ( <col1_name> , cond_col_1 , ... ) ]
                                                                        [ FORCE ]

   | ALTER MODIFY COLUMN <col1_name> UNSET MASKING POLICY

   | ALTER | MODIFY
                      [ COLUMN ] <col1_name> SET TAG <tag_name> = '<tag_value>' [ , <tag_name> = '<tag_value>' ... ]
                    , [ COLUMN ] <col2_name> SET TAG <tag_name> = '<tag_value>' [ , <tag_name> = '<tag_value>' ... ]
                    ...

   | ALTER | MODIFY
                      COLUMN <col1_name> UNSET TAG <tag_name> [ , <tag_name> ... ]
                    , COLUMN <col2_name> UNSET TAG <tag_name> [ , <tag_name> ... ]
                    ...

   | DROP [ COLUMN ] [ IF EXISTS ] <col1_name> [, <col2_name> ... ]
  }

  inlineConstraint ::=
    [ NOT NULL ]
    [ CONSTRAINT <constraint_name> ]
    { UNIQUE | PRIMARY KEY | { [ FOREIGN KEY ] REFERENCES <ref_table_name> [ ( <ref_col_name> ) ] } }
    [ <constraint_properties> ]