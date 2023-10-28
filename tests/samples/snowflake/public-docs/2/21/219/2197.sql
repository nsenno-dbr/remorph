SELECT
  exchange,
  symbol,
  NTILE(4) OVER (PARTITION BY exchange ORDER BY shares) AS ntile_4
FROM trades
ORDER BY exchange, NTILE_4;