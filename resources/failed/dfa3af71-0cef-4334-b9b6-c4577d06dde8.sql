WITH
    lineitem_agg AS (
        SELECT
            orderkey,
            ARRAY_AGG(linenumber ORDER BY quantity DESC) WITHIN GROUP (ORDER BY extendedprice DESC) AS linenumber_agg
        FROM
            lineitem
        GROUP BY
            orderkey
    )
SELECT
    orderkey,
    linenumber_agg
FROM
    lineitem_agg;