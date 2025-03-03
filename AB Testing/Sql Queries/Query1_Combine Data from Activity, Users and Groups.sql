-- This query joins the activity, users, and groups tables to create a consolidated dataset for mobile users (devices 'A' for Android and 'I' for iOS).

SELECT a.*, u.*, g."group"
FROM activity a
JOIN users u ON u.id = a.uid
JOIN groups g ON u.id = g.uid
WHERE a.device IN ('A', 'I');
