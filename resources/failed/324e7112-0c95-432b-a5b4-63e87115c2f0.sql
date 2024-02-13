WITH customer_orders AS (
  SELECT
    c.c_custkey,
    o.o_orderkey,
    o.o_totalprice
  FROM
    customer c
  JOIN
    orders o
  ON
    c.c_custkey = o.o_custkey
)
SELECT
  c.c_custkey,
  ARRAY_AGG(o.o_orderkey) WITHIN GROUP (ORDER BY o.o_totalprice DESC) AS order_keys
FROM
  customer_orders c
GROUP BY
  c.c_custkey