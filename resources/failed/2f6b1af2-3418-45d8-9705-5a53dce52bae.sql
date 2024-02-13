SELECT s.name, ARRAY_AGG(l.quantity) WITHIN GROUP (ORDER BY l.discount DESC) AS quantities
FROM lineitem l
JOIN supplier s ON l.supplierkey = s.supplierkey
GROUP BY s.name;