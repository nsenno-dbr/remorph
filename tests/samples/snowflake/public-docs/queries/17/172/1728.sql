-- see https://docs.snowflake.com/en/sql-reference/functions/generator

SELECT seq4(), uniform(1, 10, RANDOM(12)) 
  FROM TABLE(GENERATOR()) v 
  ORDER BY 1;