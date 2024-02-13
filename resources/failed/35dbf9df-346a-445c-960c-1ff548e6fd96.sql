SELECT o.orderkey, ARRAY_AGG(l.linenumber ORDER BY l.quantity DESC) WITHIN GROUP (ORDER BY l.partkey) AS linenumber_array
FROM orders o
JOIN lineitem l ON o.orderkey = l.orderkey
GROUP BY o.orderkey;