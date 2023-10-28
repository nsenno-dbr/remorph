extTableColumnAction ::=
  {
     ADD [ COLUMN ] [ IF NOT EXISTS ] <col_name> <col_type> AS ( <expr> )

   | RENAME COLUMN <col_name> TO <new_col_name>

   | DROP [ COLUMN ] [ IF EXISTS ] <col1_name> [, <col2_name> ... ]
  }