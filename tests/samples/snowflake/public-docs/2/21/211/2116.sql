SELECT COUNT(i), COUNT(DISTINCT i), APPROX_COUNT_DISTINCT(i), HLL(i)
  FROM sequence_demo;