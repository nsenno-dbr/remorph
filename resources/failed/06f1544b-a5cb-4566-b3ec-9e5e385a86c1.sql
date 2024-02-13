SELECT 
  l_orderkey,
  ARRAY_AGG(DISTINCT l_partkey) WITHIN GROUP (ORDER BY l_quantity DESC) AS partkeys
FROM 
  lineitem
GROUP BY 
  l_orderkey;