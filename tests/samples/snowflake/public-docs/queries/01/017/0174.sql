-- see https://docs.snowflake.com/en/sql-reference/sql/alter-table

ALTER TABLE t1 ADD SEARCH OPTIMIZATION ON EQUALITY(c1), EQUALITY(c2, c3);