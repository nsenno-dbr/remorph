SELECT
  c.c_custkey,
  ARRAY_AGG(o.o_orderkey) WITHIN GROUP (ORDER BY o.o_orderdate DESC) AS order_keys
FROM
  customer c
  JOIN orders o ON c.c_custkey = o.o_custkey
GROUP BY
  c.c_custkey