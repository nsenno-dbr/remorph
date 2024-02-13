SELECT 
  l_orderkey,
  ARRAY_AGG(l_shipdate) WITHIN GROUP (ORDER BY l_quantity DESC) AS shipdates
FROM 
  lineitem
GROUP BY 
  l_orderkey;