SELECT o.orderkey, ARRAY_AGG(l.partkey) WITHIN GROUP (ORDER BY l.quantity DESC) AS partkeys
FROM orders o
JOIN lineitem l ON o.orderkey = l.orderkey
GROUP BY o.orderkey
ORDER BY o.orderkey;