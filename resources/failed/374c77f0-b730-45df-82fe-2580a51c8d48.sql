WITH revenue AS (
  SELECT
    c.c_name,
    ARRAY_AGG(o_totalprice ORDER BY o_orderdate) AS revenue
  FROM
    customer c
    JOIN orders o ON c.c_custkey = o.o_custkey
  GROUP BY
    c.c_name
)
SELECT
  c_name,
  revenue
FROM
  revenue;