--QUESTION:2  TRANSACTION FREQUENCY ANALYSIS.
---TO Categorize customers based on how often they transact per month, using savings transactions as the basis.

SHOW COLUMNS FROM savings_savingsaccount;
WITH txn_summary AS (
    SELECT 
        sa.owner_id,
        COUNT(*) AS total_transactions,
        TIMESTAMPDIFF(MONTH, MIN(sa.transaction_date), MAX(sa.transaction_date)) + 1 AS active_months
    FROM savings_savingsaccount sa
    GROUP BY sa.owner_id
),
txn_classified AS (
    SELECT 
        ts.owner_id,
        ROUND(ts.total_transactions / ts.active_months, 1) AS avg_txn_per_month,
        CASE 
            WHEN ts.total_transactions / ts.active_months >= 10 THEN 'High Frequency'
            WHEN ts.total_transactions / ts.active_months BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM txn_summary ts
)
SELECT 
    frequency_category,
    COUNT(owner_id) AS customer_count,
    ROUND(AVG(avg_txn_per_month), 1) AS avg_transactions_per_month
FROM txn_classified
GROUP BY frequency_category
ORDER BY FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');


---QUESTION:3 Inactive Accounts FOR OVER 1 YEAR
---To Identify active plans (savings or investments) that have no deposit transactions in the past 365 days.

WITH last_txn AS (
    SELECT 
        sa.plan_id,
        MAX(sa.transaction_date) AS last_transaction_date
    FROM savings_savingsaccount sa
    GROUP BY sa.plan_id
)
SELECT 
    p.id AS plan_id,
    p.owner_id,
    CASE 
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
        ELSE 'Other'
    END AS type,
    l.last_transaction_date,
    DATEDIFF(CURDATE(), l.last_transaction_date) AS inactivity_days
FROM plans_plan p
JOIN last_txn l ON p.id = l.plan_id
WHERE DATEDIFF(CURDATE(), l.last_transaction_date) > 365
ORDER BY inactivity_days DESC;