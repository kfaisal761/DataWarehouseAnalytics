-- 4. Which category contribute most to the overall sales


WITH category_sales AS
        (
        SELECT
            p.category,
            SUM(f.sales_amount) AS total_sales
        FROM
            gold.fact_sales f
        LEFT JOIN gold.dim_products p ON f.product_key = p.product_key
        GROUP BY
            p.category
        )

SELECT
    category,
    total_sales,
    SUM(total_sales) OVER() AS overall_sales,
    CONCAT(ROUND(total_sales / SUM(total_sales) OVER() * 100, 2), '%') AS percentage_of_overall_sales
FROM
    category_sales
ORDER BY
    total_sales DESC;