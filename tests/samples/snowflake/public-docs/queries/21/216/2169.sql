-- see https://docs.snowflake.com/en/sql-reference/functions/is_timestamp

select * from vardttm where is_timestamp_ntz(v)
    order by 1;