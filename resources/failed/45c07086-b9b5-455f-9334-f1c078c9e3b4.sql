WITH orders AS (
  SELECT *
  FROM tpch.sf_orders
)
SELECT o.orderkey, ARRAY_AGG(l.linenumber ORDER BY l.quantity DESC) AS line_numbers
FROM orders o
JOIN tpch.sf_lineitem l ON o.orderkey = l.orderkey
GROUP BY o.orderkey