SELECT START_TIME, END_TIME, REPLICATION_GROUP_NAME, CREDITS_USED, BYTES_TRANSFERRED
  FROM TABLE(information_schema.replication_group_usage_history(
    date_range_start => dateadd('day', -7, current_date()),
    replication_group_name => 'myrg'
));