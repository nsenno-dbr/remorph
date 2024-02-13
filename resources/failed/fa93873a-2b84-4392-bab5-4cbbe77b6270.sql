WITH customer_orders AS (
  SELECT
    c.custkey,
    o.orderkey,
    o.orderdate,
    o.totalprice
  FROM
    customer c
    JOIN orders o ON c.custkey = o.custkey
)
SELECT
  c.custkey,
  c.orderkeys,
  c.orderdates,
  c.totalprices
FROM
  (
    SELECT
      custkey,
      ARRAY_AGG(orderkey) WITHIN GROUP (ORDER BY orderdate DESC) AS orderkeys,
      ARRAY_AGG(orderdate) WITHIN GROUP (ORDER BY orderdate DESC) AS orderdates,
      ARRAY_AGG(totalprice) WITHIN GROUP (ORDER BY orderdate DESC) AS totalprices
    FROM
      customer_orders
    GROUP BY
      custkey
  ) c;