-- see https://docs.snowflake.com/en/sql-reference/operators-logical

SELECT x AS "AND", x AND False AS "FALSE", x AND True AS "TRUE", x AND NULL AS "NULL"
  FROM logical2;