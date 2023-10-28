outoflineFK :=
  [ CONSTRAINT <constraint_name> ]
  FOREIGN KEY ( <col_name> [ , <col_name> , ... ] )
  REFERENCES <ref_table_name> [ ( <ref_col_name> [ , <ref_col_name> , ... ] ) ]
  [ MATCH { FULL | SIMPLE | PARTIAL } ]
  [ ON [ UPDATE { CASCADE | SET NULL | SET DEFAULT | RESTRICT | NO ACTION } ]
       [ DELETE { CASCADE | SET NULL | SET DEFAULT | RESTRICT | NO ACTION } ] ]
  [ [ NOT ] ENFORCED ]
  [ [ NOT ] DEFERRABLE ]
  [ INITIALLY { DEFERRED | IMMEDIATE } ]
  [ ENABLE | DISABLE ]
  [ VALIDATE | NOVALIDATE ]
  [ RELY | NORELY ]