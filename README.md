DataAnalytics-Assessment

This repository contains my solutions to a SQL proficiency assessment designed to evaluate practical skills in data querying, business logic, and analytics using relational databases. The focus is on data manipulation, aggregation, joins, and performance.

- SQL (MySQL)
- Relational Database Schema
- Business Logic and Reporting

 Repository Structure

DataAnalytics-Assessment
├── Assessment_Q1.sql
├── Assessment_Q2.sql
├── Assessment_Q3.sql
├── Assessment_Q4.sql
└── README.md

 Question Explanations

Question 1 – High-Value Customers with Multiple Products

The Objective:  
Is to identify customers who have at 
-Least one funded savings plan
-One funded investment plan,
-And Rank them by total deposits.

The Approach used:  
- plans-plan table with flags (is-regular-savings, is-a-fund) to filter plan types.
- Joined with savings-savingsaccount to fetch confirmed deposits.
- Aggregated counts of distinct savings/investment plans per customer.
- Summed confirmed deposits and filtered customers with both product types.


Question 2 – Transaction Frequency Analysis

The Objective:
Segment customers by how often they transact monthly into: High, Medium, or Low Frequency groups.

The Approach used:  
- Transaction records in savings-savingsaccount with transaction-date.
- Calculated each customer's total transactions and the number of active months.
- Derived average transactions per month and categorized accordingly.
- Grouped by category to get customer counts and average monthly activity.


Question 3 – Account Inactivity Alert

The Objective: 
Identify active accounts (savings or investment) with no transactions in the last 365 days.

The Approach used:  
- Joined plans-plan with savings-savingsaccount on plan-id.
- Calculated the most recent transaction-date for each plan.
- Used DATEDIFF to compute inactivity duration.
- Filtered results where inactivity exceeds 365 days.


Question 4 – Customer Lifetime Value (CLV) Estimation
The Objective:
Estimate customer CLV using transaction volume, profit rate, and account tenure.

The Approach used: 
- For each customer, calculated tenure in months since date-joined.
- Counted total transactions and summed total value.
- Applied a simplified CLV formula:
  
  CLV = (total_transactions / tenure) × 12 × 0.1% of total value
 
- Results were ordered by estimated CLV descending.


Challenges Encountered

- Some column names (like transaction-date, date-joined) required schema exploration using DESCRIBE and SHOW COLUMNS.
- Ensured accurate currency conversions by converting kobo to Naira.
- Optimized joins to avoid long query runtimes and MySQL connection drops.


 Notes

- All queries are written in clean, readable, and optimized SQL.
- Every query includes proper use of CTEs, aggregation, and filtering logic.
- No database dumps included, only query logic.


Author

Abigail Emmanuel  
📧 abigailemmanuel6772@gmail.com  
📱 09027682296

Thank you for reviewing.