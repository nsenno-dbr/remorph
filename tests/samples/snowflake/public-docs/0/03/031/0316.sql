SELECT '2019-02-28T01:23:45.678'::TIMESTAMP_NTZ AS "TIMESTAMP 1",
       '2019-02-28T12:34:56.789'::TIMESTAMP_NTZ AS "TIMESTAMP 2",
       TIME_SLICE("TIMESTAMP 1", 8, 'HOUR') AS "SLICE FOR TIMESTAMP 1",
       TIME_SLICE("TIMESTAMP 2", 8, 'HOUR') AS "SLICE FOR TIMESTAMP 2";