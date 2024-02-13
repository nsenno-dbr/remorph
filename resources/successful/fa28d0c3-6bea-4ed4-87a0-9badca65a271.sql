SELECT 
  l_orderkey,
  ARRAY_AGG(l_quantity) WITHIN GROUP (ORDER BY l_partkey) AS quantities
FROM 
  lineitem
GROUP BY 
  l_orderkey