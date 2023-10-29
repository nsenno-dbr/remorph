-- see https://docs.snowflake.com/en/sql-reference/functions/date_trunc

SELECT TO_DATE('2015-05-08T23:39:20.123-07:00') AS "DATE1",
       DATE_TRUNC('YEAR', "DATE1") AS "TRUNCATED TO YEAR",
       DATE_TRUNC('MONTH', "DATE1") AS "TRUNCATED TO MONTH",
       DATE_TRUNC('DAY', "DATE1") AS "TRUNCATED TO DAY";