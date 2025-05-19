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