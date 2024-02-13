WITH
  customer_orders AS (
    SELECT
      c.c_custkey,
      o.o_orderkey,
      o.o_orderdate,
      o.o_totalprice
    FROM
      customer c
      JOIN orders o ON c.c_custkey = o.o_custkey
  ),
  customer_order_totals AS (
    SELECT
      c.c_custkey,
      SUM(o.o_totalprice) AS total_price
    FROM
      customer c
      JOIN orders o ON c.c_custkey = o.o_custkey
    GROUP BY
      c.c_custkey
  )
SELECT
  c.c_custkey,
  ARRAY_AGG(o.o_orderkey ORDER BY o.o_orderdate) AS order_keys_sorted_by_date,
  cot.total_price
FROM
  customer c
  JOIN orders o ON c.c_custkey = o.o_custkey
  JOIN customer_order_totals cot ON c.c_custkey = cot.c_custkey
GROUP BY
  c.c_custkey,
  cot.total_price;