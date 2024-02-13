WITH
  customer_orders AS (
    SELECT
      c.custkey,
      c.name,
      o.orderkey,
      o.orderdate
    FROM
      customer c
      JOIN orders o ON c.custkey = o.custkey
  ),
  aggregated_orders AS (
    SELECT
      custkey,
      name,
      ARRAY_AGG(orderkey ORDER BY orderdate) WITHIN GROUP (ORDER BY orderkey) AS orderkeys
    FROM
      customer_orders
    GROUP BY
      custkey,
      name
  )
SELECT
  custkey,
  name,
  orderkeys
FROM
  aggregated_orders