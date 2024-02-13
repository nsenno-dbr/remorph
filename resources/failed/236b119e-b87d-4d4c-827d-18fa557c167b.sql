WITH customer_orders AS (
  SELECT
    c.custkey,
    c.name,
    o.orderkey,
    o.orderdate,
    o.totalprice
  FROM
    customer AS c
  JOIN
    orders AS o
    ON c.custkey = o.custkey
)
SELECT
  custkey,
  name,
  ARRAY_AGG(orderkey ORDER BY orderdate) WITHIN GROUP (ORDER BY totalprice DESC) AS ordered_orders
FROM
  customer_orders
GROUP BY
  custkey,
  name