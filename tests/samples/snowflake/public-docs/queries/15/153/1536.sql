-- see https://docs.snowflake.com/en/sql-reference/account-usage/class_instances

SELECT a.TABLE_NAME,
       b.NAME AS instance_name,
       b.CLASS_NAME
  FROM SNOWFLAKE.ACCOUNT_USAGE.TABLES a
  JOIN SNOWFLAKE.ACCOUNT_USAGE.CLASS_INSTANCES b
  ON a.INSTANCE_ID = b.ID
  WHERE b.DELETED IS NULL;