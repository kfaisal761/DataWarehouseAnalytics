/*-- Helps measuring the success and compare the performance

3. Analyse the yearly performance of products by 
comparing each product's sales to both  its average sales performance 
and the previous year's sales
*/

WITH yearly_product_sales AS 
(
SELECT
    TO_CHAR(f.order_date, 'YYYY') AS order_year,
    p.product_name AS product_name,    
    SUM(f.sales_amount) AS current_sales
FROM
    gold.fact_sales f
LEFT JOIN gold.dim_products p ON f.product_key = p.product_key
WHERE
    f.order_date IS NOT NULL
GROUP BY
    TO_CHAR(f.order_date, 'YYYY'),
    p.product_name
)

SELECT
    order_year,
    product_name,
    current_sales,
    ROUND(AVG(current_sales) OVER (PARTITION BY product_name),0) AS avg_sales,
    current_sales - ROUND(AVG(current_sales) OVER (PARTITION BY product_name),0) AS diff_avg,
    CASE
        WHEN current_sales - ROUND(AVG(current_sales) OVER (PARTITION BY product_name),0) > 0 THEN 'Above Average'
        WHEN current_sales - ROUND(AVG(current_sales) OVER (PARTITION BY product_name),0) < 0 THEN 'Below Average'
        ELSE 'Average'
    END AS avg_change,
    LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS py_sales,
    current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_py,
    CASE
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
        ELSE 'No change'
    END AS py_change --- Year over year (YoY) analysis
FROM yearly_product_sales
ORDER BY
    product_name,
    order_year
