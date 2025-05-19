--QUESTION 1: HIGH VALUE CUSTOMERS WITH MULTIPLE PRODUCTS.
----Find customers who have at least one funded savings plan AND one funded investment plan
SHOW TABLES
SELECT
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    COUNT(DISTINCT CASE
                     WHEN p.is_regular_savings = 1
                     THEN p.id
                   END) AS savings_count,
	COUNT(DISTINCT CASE
                     WHEN p.is_a_fund = 1
                     THEN p.id
                   END) AS investment_count, -- sum of all deposits for all of the customer’s plans
                   ROUND(SUM(sa.confirmed_amount) / 100, 2)     AS total_deposits
FROM users_customuser AS u
JOIN plans_plan AS p ON p.owner_id = u.id
JOIN savings_savingsaccount AS sa ON sa.plan_id  = p.id
AND sa.confirmed_amount > 0  -- only funded deposits
GROUP BY u.id, name
HAVING  savings_count >= 1  -- at least one savings plan
AND  investment_count >= 1  -- at least one investment plan
ORDER BY total_deposits DESC;








