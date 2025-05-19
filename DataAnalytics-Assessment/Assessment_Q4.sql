-- 4. Customer Lifetime Value (CLV) Estimation
-- Scenario: Marketing wants to estimate CLV based on account tenure and transaction volume (simplified model).
-- Task: For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
-- Account tenure (months since signup)
-- Total transactions
-- Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
-- Order by estimated CLV from highest to lowest


WITH customer_txns AS (
    SELECT
        owner_id,
        COUNT(*) AS total_transactions,
        SUM(confirmed_amount) AS total_value
    FROM savings_savingsaccount
    GROUP BY owner_id
),
tenure_calc AS (
    SELECT
        id AS customer_id,
        CONCAT(first_name, ' ', last_name) AS name,
        TIMESTAMPDIFF(MONTH, date_joined, CURDATE()) AS tenure_months
    FROM users_customuser
),
clv_calc AS (
    SELECT
        t.customer_id,
        t.name,
        t.tenure_months,
        COALESCE(c.total_transactions, 0) AS total_transactions,
        ROUND(
            (COALESCE(c.total_transactions, 0) / NULLIF(t.tenure_months, 0)) * 12 * 
            ((COALESCE(c.total_value, 0) / COALESCE(c.total_transactions, 1)) * 0.001) / 100, 2
        ) AS estimated_clv
    FROM tenure_calc t
    LEFT JOIN customer_txns c ON t.customer_id = c.owner_id
)
SELECT *
FROM clv_calc
ORDER BY estimated_clv DESC;

