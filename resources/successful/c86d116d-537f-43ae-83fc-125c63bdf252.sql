SELECT s.s_name, ARRAY_AGG(l.l_quantity) WITHIN GROUP (ORDER BY l.l_shipdate) AS quantities
FROM lineitem l
JOIN supplier s ON l.l_suppkey = s.s_suppkey
GROUP BY s.s_name;