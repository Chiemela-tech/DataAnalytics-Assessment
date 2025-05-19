-- 1. High-Value Customers with Multiple Products
-- Scenario: The business wants to identify customers who have both a savings and an investment plan (cross-selling opportunity).
-- Task: Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.

SELECT
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    COUNT(DISTINCT s.id) AS savings_count,
    COUNT(DISTINCT p.id) AS investment_count,
    SUM(s.confirmed_amount) / 100 AS total_deposits
FROM users_customuser u
LEFT JOIN savings_savingsaccount s ON u.id = s.owner_id AND s.is_regular_savings = 1
LEFT JOIN plans_plan p ON u.id = p.owner_id AND p.is_a_fund = 1
WHERE s.confirmed_amount IS NOT NULL AND p.id IS NOT NULL
GROUP BY u.id, u.first_name, u.last_name
HAVING savings_count >= 1 AND investment_count >= 1
ORDER BY total_deposits DESC;