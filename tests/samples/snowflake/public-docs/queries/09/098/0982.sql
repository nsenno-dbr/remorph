-- see https://docs.snowflake.com/en/sql-reference/functions/array_except

SELECT ARRAY_EXCEPT(['A', NULL, NULL], [NULL, 'B', NULL]);