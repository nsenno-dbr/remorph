WITH customer_revenue AS (
  SELECT
    c.c_custkey,
    c.c_name,
    sum(l.l_extendedprice * (1 - l.l_discount)) AS revenue
  FROM
    customer c
    JOIN orders o ON c.c_custkey = o.o_custkey
    JOIN lineitem l ON o.o_orderkey = l.l_orderkey
  WHERE
    o.o_orderdate >= '1995-01-01'
    AND o.o_orderdate < '1996-01-01'
  GROUP BY
    c.c_custkey,
    c.c_name
),
top_customers AS (
  SELECT
    c.c_custkey,
    c.c_name,
    revenue,
    ARRAY_AGG(revenue ORDER BY revenue DESC) WITHIN GROUP (ORDER BY revenue DESC) AS revenue_array
  FROM
    customer_revenue c
  GROUP BY
    c.c_custkey,
    c.c_name,
    revenue
)
SELECT
  c.c_custkey,
  c.c_name,
  c.revenue,
  c.revenue_array
FROM
  top_customers c
LIMIT
  10;