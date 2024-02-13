SELECT 
  l_orderkey,
  ARRAY_AGG(l_partkey) WITHIN GROUP (ORDER BY l_shipdate DESC) AS partkeys
FROM 
  lineitem
GROUP BY 
  l_orderkey;