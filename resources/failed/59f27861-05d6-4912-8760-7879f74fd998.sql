WITH
  customer_orders AS (
    SELECT
      c.c_custkey,
      o.o_orderkey,
      o.o_totalprice
    FROM
      customer AS c
      JOIN orders AS o ON c.c_custkey = o.o_custkey
  ),
  customer_total_orders AS (
    SELECT
      c.c_custkey,
      ARRAY_AGG(o.o_orderkey ORDER BY o.o_totalprice DESC) WITHIN GROUP (ORDER BY o.o_totalprice DESC) AS order_keys
    FROM
      customer_orders AS co
      JOIN customer AS c ON co.c_custkey = c.c_custkey
    GROUP BY
      c.c_custkey
  )
SELECT
  cto.c_custkey,
  cto.order_keys
FROM
  customer_total_orders AS cto
ORDER BY
  cto.c_custkey