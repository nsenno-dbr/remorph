-- see https://docs.snowflake.com/en/sql-reference/functions-analytic

select p, o, i AS i_col,
    MIN(i) OVER (PARTITION BY p ORDER BY o ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING) min_i_3P_1P,
    MIN(i) OVER (PARTITION BY p ORDER BY o ROWS BETWEEN 1 FOLLOWING AND 3 FOLLOWING) min_i_1F_3F,
    MIN(i) OVER (PARTITION BY p ORDER BY o ROWS BETWEEN 1 PRECEDING AND 3 FOLLOWING) min_i_1P_3F,
    s,
    MIN(s) OVER (PARTITION BY p ORDER BY o ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING) min_s_3P_1P,
    MIN(s) OVER (PARTITION BY p ORDER BY o ROWS BETWEEN 1 FOLLOWING AND 3 FOLLOWING) min_s_1F_3F,
    MIN(s) OVER (PARTITION BY p ORDER BY o ROWS BETWEEN 1 PRECEDING AND 3 FOLLOWING) min_s_1P_3F
  FROM example_sliding
  ORDER BY p, o;