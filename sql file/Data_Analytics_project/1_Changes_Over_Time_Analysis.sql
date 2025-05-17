-- 1_Changes_Over_Time_Analysis

SELECT 
    TO_CHAR(order_date,'YYYY-MM') AS order_year_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE
    order_date IS NOT NULL
GROUP BY
    TO_CHAR(order_date,'YYYY-MM')
ORDER BY
    TO_CHAR(order_date,'YYYY-MM')
-- Helps in strategic decision making
-- Helps in seasonality analysis