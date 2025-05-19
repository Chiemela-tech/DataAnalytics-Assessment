-- 2. Transaction Frequency Analysis
-- Scenario: The finance team wants to analyze how often customers transact to segment them (e.g., frequent vs. occasional users).
-- Task: Calculate the average number of transactions per customer per month and categorize them:
-- "High Frequency" (≥10 transactions/month)
-- "Medium Frequency" (3-9 transactions/month)
-- "Low Frequency" (≤2 transactions/month)


WITH monthly_txns AS (
    SELECT
        owner_id,
        DATE_FORMAT(created_at, '%Y-%m') AS txn_month,
        COUNT(*) AS monthly_txn_count
    FROM savings_savingsaccount
    GROUP BY owner_id, txn_month
),
customer_avg AS (
    SELECT
        owner_id,
        AVG(monthly_txn_count) AS avg_txns_per_month
    FROM monthly_txns
    GROUP BY owner_id
),
categorized AS (
    SELECT
        CASE
            WHEN avg_txns_per_month >= 10 THEN 'High Frequency'
            WHEN avg_txns_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        avg_txns_per_month
    FROM customer_avg
)
SELECT
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_txns_per_month), 1) AS avg_transactions_per_month
FROM categorized
GROUP BY frequency_category;