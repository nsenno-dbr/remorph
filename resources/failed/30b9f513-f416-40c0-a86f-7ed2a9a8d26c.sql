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
  customer_order_items AS (
    SELECT
      co.custkey,
      co.name,
      co.orderkey,
      oi.partkey,
      oi.quantity
    FROM
      customer_orders co
      JOIN lineitem li ON co.orderkey = li.orderkey
      JOIN orderitem oi ON li.orderkey = oi.orderkey
  )
SELECT
  custkey,
  name,
  ARRAY_AGG(partkey) WITHIN GROUP (ORDER BY quantity DESC) AS sorted_partkeys
FROM
  customer_order_items
GROUP BY
  custkey,
  name;