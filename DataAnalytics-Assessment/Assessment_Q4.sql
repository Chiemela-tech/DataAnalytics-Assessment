-- 4. Customer Lifetime Value (CLV) Estimation
-- Scenario: Marketing wants to estimate CLV based on account tenure and transaction volume (simplified model).
-- Task: For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
-- Account tenure (months since signup)
-- Total transactions
-- Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
-- Order by estimated CLV from highest to lowest


WITH customer_metrics AS (  
    SELECT  
        u.id as customer_id,  
        u.name,  
        CAST(  
            (JULIANDAY(DATE('now')) - JULIANDAY(MIN(u.date_joined))) / 30.0  
            AS INTEGER  
        ) as tenure_months,  
        COUNT(s.id) as total_transactions,  
        AVG(s.confirmed_amount / 100.0) as avg_transaction_amount  
    FROM  
        users_customuser u  
        JOIN plans_plan p ON u.id = p.owner_id  
        JOIN savings_savingsaccount s ON p.id = s.plan_id  
    WHERE  
        s.confirmed_amount > 0  
    GROUP BY  
        u.id, u.name  
)  
SELECT  
    customer_id,  
    name,  
    tenure_months,  
    total_transactions,  
    ROUND(  
        (total_transactions::FLOAT / tenure_months) * 12 *  
        (avg_transaction_amount * 0.001),  
        2  
    ) as estimated_clv  
FROM  
    customer_metrics  
ORDER BY  
    estimated_clv DESC;  

