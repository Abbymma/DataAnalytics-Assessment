---QUESTION : 4     CUSTOMERS LIFETIME VALUE (CLV)
---To Find For each customer, Tenure in months, Total number of transactions

WITH txn_summary AS (
    SELECT 
        u.id AS customer_id,
        CONCAT(u.first_name, ' ', u.last_name) AS name,
        TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,
        COUNT(sa.id) AS total_transactions,
        SUM(sa.confirmed_amount) AS total_value_in_kobo
    FROM users_customuser u
    JOIN savings_savingsaccount sa ON sa.owner_id = u.id
    GROUP BY u.id, name, u.date_joined
),
clv_calc AS (
    SELECT 
        customer_id,
        name,
        tenure_months,
        total_transactions,
        ROUND((total_value_in_kobo * 0.001 / tenure_months) * 12 / 100, 2) AS estimated_clv
    FROM txn_summary
    WHERE tenure_months > 0
)
SELECT *
FROM clv_calc
ORDER BY estimated_clv DESC;