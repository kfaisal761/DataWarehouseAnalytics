/*
                                          Customer Report
                                        
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:

    1. Gathers essential fields such as names, ages, and transaction details.
    2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
        - total orders
        - total sales
        - total quantity purchased
        - total products
        - lifespan (in months)
    4. Calculates valuable KPIs:
        - recency (months since last order)
        - average order value (AVO)
        - average monthly spend (AMS)
*/

CREATE VIEW gold.report_customers AS
WITH base_query AS 
    (
    SELECT
        f.order_number,
        f.product_key,
        f.order_date,
        f.sales_amount,
        f.quantity,
        c.customer_key,
        c.customer_number,
        CONCAT(first_name, ' ', last_name) AS customer_name,
        EXTRACT(YEAR FROM AGE(CURRENT_DATE,c.birthdate)) AS age
    FROM
        gold.fact_sales f
    LEFT JOIN gold.dim_customers c ON f.customer_key = c.customer_key
    WHERE 
        order_date IS NOT NULL
    ),

customer_aggregations AS
    (
    SELECT
        customer_key,
        customer_number,
        customer_name,
        age,
        COUNT(DISTINCT order_number) AS total_orders,
        SUM(sales_amount) AS total_sales,
        SUM(quantity) AS total_quantity,
        COUNT(DISTINCT product_key) AS total_products,
        MAX(order_date) AS last_order_date,
        (
            (EXTRACT(YEAR FROM MAX(order_date)) * 12 + EXTRACT(MONTH FROM MAX(order_date))) -
            (EXTRACT(YEAR FROM MIN(order_date)) * 12 + EXTRACT(MONTH FROM MIN(order_date)))
        ) AS lifespan_months
    FROM 
        base_query
    GROUP BY
        customer_key,
        customer_number,
        customer_name,
        age
    )

SELECT
    customer_key,
    customer_number,
    customer_name,
    age,
    CASE
        WHEN age < 20 THEN 'Under 20'
        WHEN age BETWEEN 20 and 29 THEN '20 - 29'
        WHEN age BETWEEN 30 AND 39 THEN '30 - 39'
        WHEN age BETWEEN 40 AND 49 THEN '40 - 49'
        ELSE '50 and above'
    END AS age_group,
    CASE
        WHEN lifespan_months >= 12 AND total_sales > 5000 THEN 'VIP'
        WHEN lifespan_months >=12 AND total_sales <= 5000 THEN 'Regular'
        ELSE 'New'
    END AS customer_segment,
    last_order_date,
    (
        EXTRACT(YEAR FROM AGE(CURRENT_DATE, last_order_date)) * 12 +
        EXTRACT(MONTH FROM AGE(CURRENT_DATE, last_order_date))
    )   AS recency,
    total_orders,
    total_sales,
    total_quantity,
    total_products,
    lifespan_months,
    CASE 
        WHEN total_orders = 0 THEN 0
        ELSE total_sales / total_orders 
    END AS AVO,
    CASE
        WHEN lifespan_months = 0 THEN total_sales
        ELSE total_sales / lifespan_months 
    END AS AMS
FROM
    customer_aggregations

