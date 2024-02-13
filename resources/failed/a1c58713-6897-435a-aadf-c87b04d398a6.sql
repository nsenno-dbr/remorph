WITH aggregated_orders AS (
  SELECT o.orderkey, o.custkey, ARRAY_AGG(l.linenumber ORDER BY l.quantity DESC) AS line_numbers
  FROM orders o
  JOIN lineitem l ON o.orderkey = l.orderkey
  GROUP BY o.orderkey, o.custkey
)
SELECT orderkey, custkey, line_numbers
FROM aggregated_orders;