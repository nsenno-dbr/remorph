SELECT 
    l_orderkey,
    ARRAY_AGG(l_quantity ORDER BY l_partkey) AS sorted_quantities
FROM 
    lineitem
GROUP BY 
    l_orderkey;