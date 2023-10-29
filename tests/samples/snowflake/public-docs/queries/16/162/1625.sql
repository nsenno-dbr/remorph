-- see https://docs.snowflake.com/en/sql-reference/constructs/connect-by

SELECT employee_ID, manager_ID, title
  FROM employees
    START WITH title = 'President'
    CONNECT BY
      manager_ID = PRIOR employee_id
  ORDER BY employee_ID;