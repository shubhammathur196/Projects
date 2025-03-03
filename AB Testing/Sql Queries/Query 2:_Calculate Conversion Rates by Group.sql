--This query calculates the conversion rate for each test group by counting the total users and the users with at least one purchase. 
--A LEFT JOIN is used to ensure non-converters are included


SELECT
    g."group" AS group_name,
    COUNT(DISTINCT u.id) AS total_users,
    COUNT(DISTINCT CASE WHEN a.uid IS NOT NULL THEN u.id END) AS users_with_purchase,
    1.0 * COUNT(DISTINCT CASE WHEN a.uid IS NOT NULL THEN u.id END)
         / COUNT(DISTINCT u.id) AS conversion_rate
FROM users u
JOIN groups g ON u.id = g.uid
LEFT JOIN activity a ON u.id = a.uid AND a.device IN ('A', 'I')
GROUP BY g."group";
