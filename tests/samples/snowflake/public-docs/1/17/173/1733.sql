select id, string1,
       regexp_substr(string1, 'the\\W+\\w+') as "SUBSTRING",
       regexp_instr(string1, 'the\\W+\\w+') as "POSITION"
    from demo2
    order by id;