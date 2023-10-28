QUERY_HISTORY(
      [ END_TIME_RANGE_START => <constant_expr> ]
      [, END_TIME_RANGE_END => <constant_expr> ]
      [, RESULT_LIMIT => <num> ] )

QUERY_HISTORY_BY_SESSION(
      [ SESSION_ID => <constant_expr> ]
      [, END_TIME_RANGE_START => <constant_expr> ]
      [, END_TIME_RANGE_END => <constant_expr> ]
      [, RESULT_LIMIT => <num> ] )

QUERY_HISTORY_BY_USER(
      [ USER_NAME => '<string>' ]
      [, END_TIME_RANGE_START => <constant_expr> ]
      [, END_TIME_RANGE_END => <constant_expr> ]
      [, RESULT_LIMIT => <num> ] )

QUERY_HISTORY_BY_WAREHOUSE(
      [ WAREHOUSE_NAME => '<string>' ]
      [, END_TIME_RANGE_START => <constant_expr> ]
      [, END_TIME_RANGE_END => <constant_expr> ]
      [, RESULT_LIMIT => <num> ] )