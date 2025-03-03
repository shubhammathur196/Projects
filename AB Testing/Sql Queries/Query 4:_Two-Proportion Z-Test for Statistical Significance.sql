--This query computes the necessary values for a two-proportion z-test:

--  It calculates conversion statistics for each group.
--  Computes a pooled conversion rate.
--  Calculates the standard error and z‑score for the difference in conversion rates.


WITH conversion_stats AS (
  SELECT
    g."group" AS group_name,
    COUNT(DISTINCT u.id) AS total_users,
    COUNT(DISTINCT CASE WHEN a.uid IS NOT NULL THEN u.id END) AS converters
  FROM users u
  JOIN groups g ON u.id = g.uid
  LEFT JOIN activity a ON u.id = a.uid AND a.device IN ('A', 'I')
  GROUP BY g."group"
),
pooled AS (
  SELECT
    SUM(total_users) AS total_users_all,
    SUM(converters) AS total_converters_all,
    SUM(converters)::float / SUM(total_users) AS pooled_rate
  FROM conversion_stats
),
group_stats AS (
  SELECT
    MAX(CASE WHEN group_name = 'A' THEN total_users END) AS total_A,
    MAX(CASE WHEN group_name = 'A' THEN converters END) AS conv_A,
    MAX(CASE WHEN group_name = 'B' THEN total_users END) AS total_B,
    MAX(CASE WHEN group_name = 'B' THEN converters END) AS conv_B
  FROM conversion_stats
)
SELECT
  total_A,
  conv_A,
  total_B,
  conv_B,
  conv_A::float/total_A AS p_A,
  conv_B::float/total_B AS p_B,
  pooled_rate,
  SQRT(
    pooled_rate * (1 - pooled_rate) * (1.0/total_A + 1.0/total_B)
  ) AS standard_error,
  ((conv_B::float/total_B) - (conv_A::float/total_A)) / SQRT(
    pooled_rate * (1 - pooled_rate) * (1.0/total_A + 1.0/total_B)
  ) AS z_score
FROM group_stats, pooled;
