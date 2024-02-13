SELECT 
    l_orderkey,
    ARRAY_AGG(l_partkey) WITHIN GROUP (ORDER BY l_quantity DESC) AS aggregated_array
FROM 
    lineitem
GROUP BY 
    l_orderkey