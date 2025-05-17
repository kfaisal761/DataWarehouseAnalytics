/*
Group customers into three segments based on their spending behaviors
- VIP: at least 12 months of history and spending more than 5,000
- Regular: at least 12 months of history but spending 5,000 or less
- New: lifespan less than 12 months
And find total number of customers in each group
*/

WITH customer_spending AS
(
SELECT
    c.customer_key,
    SUM(f.sales_amount) AS total_spending,
    MIN(f.order_date) AS first_order,
    MAX(f.order_date) AS last_order,
    (
        (EXTRACT(YEAR FROM MAX(order_date)) * 12 + EXTRACT(MONTH FROM MAX(order_date))) -
        (EXTRACT(YEAR FROM MIN(order_date)) * 12 + EXTRACT(MONTH FROM MIN(order_date)))
    ) AS lifespan_months   
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c ON f.customer_key = c.customer_key
GROUP BY
    c.customer_key
)


SELECT
    customer_segment,
    COUNT(customer_key) AS total_customers
FROM 
(
SELECT
    customer_key,
    total_spending,
    lifespan_months,
    CASE
        WHEN lifespan_months >= 12 AND total_spending > 5000 THEN 'VIP'
        WHEN lifespan_months >=12 AND total_spending <= 5000 THEN 'Regular'
        ELSE 'New'
    END AS customer_segment
FROM
    customer_spending) t

GROUP BY
    customer_segment
ORDER BY
    total_customers DESC