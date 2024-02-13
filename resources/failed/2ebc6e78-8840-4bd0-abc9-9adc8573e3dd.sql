SELECT s.name, ARRAY_AGG(l.quantity ORDER BY l.partkey) AS quantities
FROM lineitem l
JOIN supplier s ON l.suppkey = s.suppkey
GROUP BY s.name;