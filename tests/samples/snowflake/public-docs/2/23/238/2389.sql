SELECT 
       int_col,
       AVG(int_col) OVER(PARTITION BY int_col) 
    FROM avg_example
    ORDER BY int_col;