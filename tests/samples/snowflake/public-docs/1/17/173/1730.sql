select id, string1,
       regexp_substr(string1, 'nevermore\\d', 1, 3) AS "SUBSTRING", 
       regexp_instr( string1, 'nevermore\\d', 1, 3, 0) AS "START_POSITION",
       regexp_instr( string1, 'nevermore\\d', 1, 3, 1) AS "AFTER_POSITION"
    from demo1
    order by id;