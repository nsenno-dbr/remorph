SELECT
  c.c_name,
  ARRAY_AGG(o.o_orderdate) WITHIN GROUP (ORDER BY o.o_totalprice DESC) AS order_dates
FROM
  customer c
  JOIN orders o ON c.c_custkey = o.o_custkey
GROUP BY
  c.c_name
ORDER BY
  c.c_name;