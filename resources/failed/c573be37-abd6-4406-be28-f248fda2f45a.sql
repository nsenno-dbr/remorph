SELECT 
    o.orderkey,
    ARRAY_AGG(l.linenumber ORDER BY l.quantity DESC) WITHIN GROUP (ORDER BY l.partkey) AS sorted_linenumber
FROM 
    orders o
JOIN 
    lineitem l ON o.orderkey = l.orderkey
GROUP BY 
    o.orderkey