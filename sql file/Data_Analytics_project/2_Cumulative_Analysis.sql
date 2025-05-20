-- 2_Cumulative_Analysis 
--"How business is performing overtime"
-- Step 1: calculate the sales per year with month
-- Step 2: and the running total of sales over time

SELECT 
    order_year_with_month,
    total_sales,
    SUM(total_sales) OVER (ORDER BY order_year_with_month) AS running_total,
    ROUND(AVG(avg_price) OVER (PARTITION BY order_year_with_month ORDER BY order_year_with_month),2) AS moving_avg_price
FROM 
(
        SELECT
            TO_CHAR(order_date, 'YYYY-MM') AS order_year_with_month,
            SUM(sales_amount) AS total_sales,
            AVG(price) AS avg_price
        FROM
            gold.fact_sales
        WHERE
            order_date IS NOT NULL
        GROUP BY
            order_year_with_month
) t
-- cumulative values give the progress over the time span
