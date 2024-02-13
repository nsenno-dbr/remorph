SELECT o.orderkey, ARRAY_AGG(l.linenumber ORDER BY l.quantity) WITHIN GROUP (ORDER BY l.partkey) AS line_numbers
FROM orders o
JOIN lineitem l on o.orderkey = l.orderkey
GROUP BY o.orderkey