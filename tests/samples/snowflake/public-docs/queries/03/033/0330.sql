-- see https://docs.snowflake.com/en/sql-reference/functions/like_any

CREATE OR REPLACE TABLE like_example(subject varchar(20));
INSERT INTO like_example VALUES
    ('John  Dddoe'),
    ('Joe   Doe'),
    ('John_down'),
    ('Joe down'),
    ('Tom   Doe'),
    ('Tim down'),
    (null);