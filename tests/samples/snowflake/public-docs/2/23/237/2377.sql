SELECT province, o_col, 
      CONDITIONAL_TRUE_EVENT(o_col) 
        OVER (PARTITION BY province ORDER BY o_col) 
          AS true_event
    FROM table1
    ORDER BY province, o_col
    ;