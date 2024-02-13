SELECT
  c_custkey,
  ARRAY_AGG(o_orderkey ORDER BY o_totalprice DESC) WITHIN GROUP (ORDER BY o_orderdate DESC) AS order_keys
FROM
  customer c
JOIN
  orders o ON c.c_custkey = o.o_custkey
GROUP BY
  c_custkey