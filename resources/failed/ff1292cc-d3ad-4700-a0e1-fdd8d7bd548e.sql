SELECT 
  l.orderkey, 
  ARRAY_AGG(l.quantity) WITHIN GROUP (ORDER BY l.linenumber DESC) AS quantities
FROM 
  lineitem l
GROUP BY 
  l.orderkey