-- see https://docs.snowflake.com/en/sql-reference/snowflake-scripting/begin

EXECUTE IMMEDIATE $$
BEGIN
    CREATE TABLE parent (ID INTEGER);
    CREATE TABLE child (ID INTEGER, parent_ID INTEGER);
    RETURN 'Completed';
END;
$$
;