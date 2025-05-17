CREATE SCHEMA gold;

-- Dimension: Customers
CREATE TABLE gold.dim_customers (
    customer_key INT PRIMARY KEY,
    customer_id INT,
    customer_number VARCHAR(50),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    country VARCHAR(50),
    marital_status VARCHAR(50),
    gender VARCHAR(50),
    birthdate DATE,
    create_date DATE
);

-- Dimension: Products
CREATE TABLE gold.dim_products (
    product_key INT PRIMARY KEY,
    product_id INT,
    product_number VARCHAR(50),
    product_name VARCHAR(50),
    category_id VARCHAR(50),
    category VARCHAR(50),
    subcategory VARCHAR(50),
    maintenance VARCHAR(50),
    cost INT,
    product_line VARCHAR(50),
    start_date DATE
);

-- Fact: Sales
CREATE TABLE gold.fact_sales (
    order_number VARCHAR(50),
    product_key INT,
    customer_key INT,
    order_date DATE,
    shipping_date DATE,
    due_date DATE,
    sales_amount INT,
    quantity SMALLINT,
    price INT,
    PRIMARY KEY (order_number, product_key, customer_key),
    FOREIGN KEY (product_key) REFERENCES gold.dim_products(product_key),
    FOREIGN KEY (customer_key) REFERENCES gold.dim_customers(customer_key)
);

-- Set ownership of the tables to the postgres user
ALTER TABLE gold.dim_customers OWNER to postgres;
ALTER TABLE gold.dim_products OWNER to postgres;
ALTER TABLE gold.fact_sales OWNER to postgres;

-- Create index on foreign key column in fact_sales for better join performance
CREATE INDEX idx_product_key ON gold.fact_sales (product_key);
CREATE INDEX idx_customer_key ON gold.fact_sales (customer_key);

