SELECT l_orderkey, 
       ARRAY_AGG(l_partkey ORDER BY l_shipdate) WITHIN GROUP (ORDER BY l_quantity DESC) AS aggregated_array
FROM lineitem
GROUP BY l_orderkey