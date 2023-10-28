-- create a basic table
CREATE OR REPLACE TABLE temp (i number);

-- populate it with some rows
INSERT INTO temp SELECT seq8() FROM table(generator(rowcount=>20)) v;

-- verify that the rows exist
SELECT COUNT (*) FROM temp;

----------+
 count(*) |
----------+
 20       |
----------+

-- truncate the table
TRUNCATE TABLE IF EXISTS temp;

-- verify that the table is now empty
SELECT COUNT (*) FROM temp;

----------+
 count(*) |
----------+
 0        |
----------+