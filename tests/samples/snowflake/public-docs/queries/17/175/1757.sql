-- see https://docs.snowflake.com/en/sql-reference/functions/like

SELECT subject
    FROM like_ex
    WHERE subject NOT LIKE ''
    ORDER BY subject;