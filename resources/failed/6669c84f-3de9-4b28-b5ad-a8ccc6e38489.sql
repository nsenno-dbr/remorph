WITH
    lineitem_agg AS (
        SELECT 
            orderkey,
            ARRAY_AGG(linenumber ORDER BY quantity DESC) WITHIN GROUP (ORDER BY shipdate) AS line_numbers
        FROM 
            lineitem
        GROUP BY 
            orderkey
    )
SELECT 
    orderkey,
    line_numbers
FROM 
    lineitem_agg
LIMIT 10;