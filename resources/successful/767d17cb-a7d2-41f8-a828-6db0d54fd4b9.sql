SELECT
  c.c_name,
  ARRAY_AGG(o.o_orderpriority) WITHIN GROUP (ORDER BY o.o_orderdate DESC) AS order_priorities
FROM
  customer AS c
JOIN
  orders AS o ON c.c_custkey = o.o_custkey
GROUP BY
  c.c_name;