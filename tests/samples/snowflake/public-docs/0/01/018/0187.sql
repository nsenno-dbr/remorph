select w, w2, w || w2 as escape_sequence, w2
    from wildcards
    where regexp_like(w2, w || w2);