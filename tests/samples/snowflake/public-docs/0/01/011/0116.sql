select *
   from (
         select *
            from t1 join t2
               on t1.a = t2.c
        ) sample (1);