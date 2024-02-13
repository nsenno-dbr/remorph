WITH sales AS (
  SELECT
    o.orderkey,
    l.partkey,
    l.quantity,
    l.extendedprice
  FROM
    orders o
    JOIN lineitem l ON o.orderkey = l.orderkey
),
agg AS (
  SELECT
    partkey,
    ARRAY_AGG(quantity ORDER BY extendedprice DESC) WITHIN GROUP (ORDER BY quantity DESC) AS quantities
  FROM
    sales
  GROUP BY
    partkey
)
SELECT
  partkey,
  quantities
FROM
  agg