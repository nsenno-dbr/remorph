SELECT 
    o_orderpriority,
    ARRAY_AGG(o_orderkey) WITHIN GROUP (ORDER BY o_totalprice DESC) AS order_keys
FROM 
    orders
GROUP BY 
    o_orderpriority;