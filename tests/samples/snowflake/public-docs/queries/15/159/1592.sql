-- see https://docs.snowflake.com/en/sql-reference/functions/chr

SELECT column1, CHR(column1)
FROM (VALUES(83), (33), (169), (8364), (0), (null));