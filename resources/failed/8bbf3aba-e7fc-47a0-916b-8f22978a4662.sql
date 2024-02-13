WITH
  region_revenue AS (
    SELECT
      r.regionkey,
      SUM(l.extendedprice * l.discount) AS revenue
    FROM
      lineitem l
      JOIN orders o ON l.orderkey = o.orderkey
      JOIN customer c ON o.custkey = c.custkey
      JOIN nation n ON c.nationkey = n.nationkey
      JOIN region r ON n.regionkey = r.regionkey
    WHERE
      o.orderdate >= '1995-01-01'
      AND o.orderdate < '1996-01-01'
    GROUP BY
      r.regionkey
  ),
  region_customers AS (
    SELECT
      r.regionkey,
      COUNT(DISTINCT c.custkey) AS customers
    FROM
      customer c
      JOIN nation n ON c.nationkey = n.nationkey
      JOIN region r ON n.regionkey = r.regionkey
    GROUP BY
      r.regionkey
  ),
  region_avg_revenue AS (
    SELECT
      r.regionkey,
      AVG(revenue) AS avg_revenue
    FROM
      region_revenue r
    GROUP BY
      r.regionkey
  )
SELECT
  r.regionkey,
  ARRAY_AGG(DISTINCT c.custkey) WITHIN GROUP (ORDER BY r.avg_revenue DESC) AS customers
FROM
  customer c
  JOIN nation n ON c.nationkey = n.nationkey
  JOIN region r ON n.regionkey = r.regionkey
  JOIN region_avg_revenue avg ON r.regionkey = avg.regionkey
GROUP BY
  r.regionkey;