SELECT o.orderkey, ARRAY_AGG(l.quantity) WITHIN GROUP (ORDER BY l.partkey) AS quantities
FROM orders o
JOIN lineitem l ON o.orderkey = l.orderkey
GROUP BY o.orderkey;