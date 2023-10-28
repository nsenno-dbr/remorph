SELECT query_id, query_text, start_time, session_id, execution_status, total_elapsed_time,
       compilation_time, execution_time, transaction_blocked_time
  FROM snowflake.account_usage.query_history
  WHERE start_time >= dateadd('hours', -24, current_timestamp())
  AND transaction_blocked_time > 0
  ORDER BY transaction_blocked_time DESC;