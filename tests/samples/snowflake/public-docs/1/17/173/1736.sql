select id, string1,
       regexp_substr(string1, 'the\\W+(\\w+)', 1, 2,    'e') as "SUBSTRING",
       regexp_instr( string1, 'the\\W+(\\w+)', 1, 2, 0, 'e') as "POSITION"
    from demo2
    order by id;