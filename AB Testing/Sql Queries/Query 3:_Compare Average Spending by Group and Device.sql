--This query compares the average spending for users, segmented by device type and test group.

SELECT
    a.device,
    g."group" AS test_group,
    AVG(a.spent) AS average_amount_spent
FROM activity a
JOIN users u ON u.id = a.uid
JOIN groups g ON u.id = g.uid
WHERE a.device IN ('A', 'I')
GROUP BY a.device, g."group"
ORDER BY a.device, g."group";
