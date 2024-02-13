WITH agg_query AS (
    SELECT
        l_orderkey,
        ARRAY_AGG(l_quantity ORDER BY l_partkey) AS quantities
    FROM
        lineitem
    GROUP BY
        l_orderkey
)
SELECT
    l_orderkey,
    quantities
FROM
    agg_query;