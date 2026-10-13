-- ================================================
-- RETAIL SALES ANALYSIS PROJECT
-- Author: Utkarsh Pandey
-- Description: Analysis of retail store sales data
-- ================================================

CREATE DATABASE retail_sales_db;
USE retail_sales_db;

-- Customers Table
CREATE TABLE customers (
    customer_id   INT PRIMARY KEY,
    first_name    VARCHAR(50),
    last_name     VARCHAR(50),
    email         VARCHAR(100),
    city          VARCHAR(50),
    state         VARCHAR(50),
    age           INT,
    gender        VARCHAR(10)
); 

-- Products Table
CREATE TABLE products (
    product_id    INT PRIMARY KEY,
    product_name  VARCHAR(100),
    category      VARCHAR(50),
    price         DECIMAL(10,2)
);

-- Orders Table
CREATE TABLE orders (
    order_id      INT PRIMARY KEY,
    customer_id   INT,
    order_date    DATE,
    status        VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order Items Table
CREATE TABLE order_items (
    item_id       INT PRIMARY KEY,
    order_id      INT,
    product_id    INT,
    quantity      INT,
    unit_price    DECIMAL(10,2),
    FOREIGN KEY (order_id)    REFERENCES orders(order_id),
    FOREIGN KEY (product_id)  REFERENCES products(product_id)
);

-- ================================================
-- INSERT SAMPLE DATA
-- ================================================

-- Insert Customers
INSERT INTO customers VALUES
(1,  'James',   'Smith',    'james@email.com',   'New York',    'NY', 34, 'Male'),
(2,  'Mary',    'Johnson',  'mary@email.com',    'Los Angeles', 'CA', 28, 'Female'),
(3,  'Robert',  'Williams', 'robert@email.com',  'Chicago',     'IL', 45, 'Male'),
(4,  'Patricia','Brown',    'pat@email.com',     'Houston',     'TX', 31, 'Female'),
(5,  'Michael', 'Jones',    'mike@email.com',    'Phoenix',     'AZ', 52, 'Male'),
(6,  'Linda',   'Garcia',   'linda@email.com',   'New York',    'NY', 27, 'Female'),
(7,  'David',   'Miller',   'david@email.com',   'Los Angeles', 'CA', 38, 'Male'),
(8,  'Barbara', 'Davis',    'barb@email.com',    'Chicago',     'IL', 43, 'Female'),
(9,  'William', 'Martinez', 'will@email.com',    'Houston',     'TX', 29, 'Male'),
(10, 'Susan',   'Wilson',   'susan@email.com',   'Phoenix',     'AZ', 55, 'Female');

-- Insert Products
INSERT INTO products VALUES
(1,  'Laptop Pro 15',      'Electronics',  1200.00),
(2,  'Wireless Mouse',     'Electronics',    25.99),
(3,  'USB-C Hub',          'Electronics',    45.00),
(4,  'Office Chair',       'Furniture',     299.99),
(5,  'Standing Desk',      'Furniture',     499.99),
(6,  'Notebook Pack',      'Stationery',     12.99),
(7,  'Ballpoint Pens',     'Stationery',      8.49),
(8,  'Monitor 27"',        'Electronics',   349.99),
(9,  'Desk Lamp',          'Furniture',      39.99),
(10, 'Mechanical Keyboard','Electronics',   129.99);

-- Insert Orders
INSERT INTO orders VALUES
(1,  1,  '2024-01-05', 'Completed'),
(2,  2,  '2024-01-10', 'Completed'),
(3,  3,  '2024-01-15', 'Completed'),
(4,  4,  '2024-02-02', 'Completed'),
(5,  5,  '2024-02-14', 'Cancelled'),
(6,  6,  '2024-02-20', 'Completed'),
(7,  7,  '2024-03-05', 'Completed'),
(8,  8,  '2024-03-12', 'Pending'),
(9,  9,  '2024-03-18', 'Completed'),
(10, 10, '2024-03-25', 'Completed'),
(11, 1,  '2024-04-01', 'Completed'),
(12, 3,  '2024-04-10', 'Completed'),
(13, 2,  '2024-04-15', 'Completed'),
(14, 7,  '2024-05-01', 'Cancelled'),
(15, 5,  '2024-05-10', 'Completed');

-- Insert Order Items
INSERT INTO order_items VALUES
(1,  1,  1,  1, 1200.00),
(2,  1,  2,  2,   25.99),
(3,  2,  4,  1,  299.99),
(4,  2,  6,  3,   12.99),
(5,  3,  8,  2,  349.99),
(6,  3,  3,  1,   45.00),
(7,  4,  5,  1,  499.99),
(8,  4,  9,  2,   39.99),
(9,  5,  10, 1,  129.99),
(10, 6,  2,  5,   25.99),
(11, 6,  7,  10,   8.49),
(12, 7,  1,  1, 1200.00),
(13, 7,  3,  2,   45.00),
(14, 8,  4,  1,  299.99),
(15, 9,  8,  1,  349.99),
(16, 9,  10, 1,  129.99),
(17, 10, 5,  1,  499.99),
(18, 11, 2,  1,   25.99),
(19, 11, 7,  5,    8.49),
(20, 12, 1,  1, 1200.00),
(21, 13, 9,  3,   39.99),
(22, 14, 6,  2,   12.99),
(23, 15, 3,  4,   45.00);

-- ================================================
-- RETAIL SALES ANALYSIS QUERIES
-- Showcasing: SELECT, JOINs, GROUP BY, HAVING,
--             Subqueries, CTEs, Window Functions
-- ================================================


-- -----------------------------------------------
-- QUERY 1: Total Revenue Per Month
-- Skills: JOIN, GROUP BY, DATE functions, ORDER BY
-- -----------------------------------------------
SELECT
    YEAR(o.order_date)          AS year,
    MONTH(o.order_date)         AS month,
    COUNT(DISTINCT o.order_id)  AS total_orders,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY
    YEAR(o.order_date),
    MONTH(o.order_date)
ORDER BY year, month;


-- -----------------------------------------------
-- QUERY 2: Top 5 Best-Selling Products
-- Skills: JOIN, GROUP BY, ORDER BY, LIMIT
-- -----------------------------------------------
SELECT
    p.product_name,
    p.category,
    SUM(oi.quantity)                  AS units_sold,
    SUM(oi.quantity * oi.unit_price)  AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o   ON oi.order_id   = o.order_id
WHERE o.status = 'Completed'
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_revenue DESC
LIMIT 5;


-- -----------------------------------------------
-- QUERY 3: Revenue by Product Category
-- Skills: JOIN, GROUP BY, Aggregate Functions
-- -----------------------------------------------
SELECT
    p.category,
    COUNT(DISTINCT o.order_id)        AS number_of_orders,
    SUM(oi.quantity)                  AS units_sold,
    ROUND(AVG(oi.unit_price), 2)      AS avg_price,
    SUM(oi.quantity * oi.unit_price)  AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o   ON oi.order_id   = o.order_id
WHERE o.status = 'Completed'
GROUP BY p.category
ORDER BY total_revenue DESC;


-- -----------------------------------------------
-- QUERY 4: Customer Lifetime Value (CLV)
-- Skills: Multiple JOINs, GROUP BY, ROUND
-- -----------------------------------------------
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name)  AS customer_name,
    c.city,
    c.state,
    COUNT(DISTINCT o.order_id)               AS total_orders,
    SUM(oi.quantity * oi.unit_price)         AS lifetime_value
FROM customers c
JOIN orders o     ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id  = oi.order_id
WHERE o.status = 'Completed'
GROUP BY c.customer_id, customer_name, c.city, c.state
ORDER BY lifetime_value DESC;


-- -----------------------------------------------
-- QUERY 5: Customers Who Spent Above Average
-- Skills: Subquery, HAVING
-- -----------------------------------------------
SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(oi.quantity * oi.unit_price)        AS total_spent
FROM customers c
JOIN orders o      ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id   = oi.order_id
WHERE o.status = 'Completed'
GROUP BY c.customer_id, customer_name
HAVING total_spent > (
    -- Subquery: calculate average spending per customer
    SELECT AVG(customer_total)
    FROM (
        SELECT SUM(oi2.quantity * oi2.unit_price) AS customer_total
        FROM orders o2
        JOIN order_items oi2 ON o2.order_id = oi2.order_id
        WHERE o2.status = 'Completed'
        GROUP BY o2.customer_id
    ) AS avg_table
)
ORDER BY total_spent DESC;


-- -----------------------------------------------
-- QUERY 6: Order Status Breakdown
-- Skills: GROUP BY, COUNT, ROUND, percentage calc
-- -----------------------------------------------
SELECT
    status,
    COUNT(*)                                        AS order_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM orders
GROUP BY status
ORDER BY order_count DESC;


-- -----------------------------------------------
-- QUERY 7: Sales by City
-- Skills: Multiple JOINs, GROUP BY
-- -----------------------------------------------
SELECT
    c.city,
    c.state,
    COUNT(DISTINCT o.order_id)        AS total_orders,
    SUM(oi.quantity * oi.unit_price)  AS total_revenue
FROM customers c
JOIN orders o      ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id   = oi.order_id
WHERE o.status = 'Completed'
GROUP BY c.city, c.state
ORDER BY total_revenue DESC;


-- -----------------------------------------------
-- QUERY 8: Running Total of Revenue (CTE + Window)
-- Skills: CTE, Window Functions, ORDER BY
-- -----------------------------------------------
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        SUM(oi.quantity * oi.unit_price)   AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.status = 'Completed'
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
)
SELECT
    month,
    revenue,
    SUM(revenue) OVER (ORDER BY month) AS running_total
FROM monthly_revenue
ORDER BY month;


-- -----------------------------------------------
-- QUERY 9: Customer Purchase Ranking
-- Skills: Window Functions (RANK, DENSE_RANK)
-- -----------------------------------------------
WITH customer_spending AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(oi.quantity * oi.unit_price) AS total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.status = 'Completed'
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT
    customer_name,
    total_spent,
    RANK() OVER (ORDER BY total_spent DESC) AS spending_rank,
    DENSE_RANK() OVER (ORDER BY total_spent DESC) AS d_rank -- Changed alias name
FROM customer_spending
ORDER BY spending_rank;


-- -----------------------------------------------
-- QUERY 10: Products Never Ordered
-- Skills: LEFT JOIN, IS NULL (finding gaps in data)
-- -----------------------------------------------
SELECT
    p.product_id,
    p.product_name,
    p.category,
    p.price
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.item_id IS NULL;


-- -----------------------------------------------
-- QUERY 11: Average Order Value by Gender
-- Skills: JOIN, GROUP BY, ROUND, AVG
-- -----------------------------------------------
SELECT
    c.gender,
    COUNT(DISTINCT o.order_id)                     AS total_orders,
    ROUND(AVG(oi.quantity * oi.unit_price), 2)     AS avg_item_value,
    ROUND(SUM(oi.quantity * oi.unit_price)
          / COUNT(DISTINCT o.order_id), 2)         AS avg_order_value
FROM customers c
JOIN orders o      ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id   = oi.order_id
WHERE o.status = 'Completed'
GROUP BY c.gender;


-- -----------------------------------------------
-- QUERY 12: Month-over-Month Revenue Growth
-- Skills: CTE, LAG Window Function, ROUND
-- -----------------------------------------------
WITH monthly AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m')   AS month,
        SUM(oi.quantity * oi.unit_price)     AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.status = 'Completed'
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
)
SELECT
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month)  AS prev_month_revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY month))
        / LAG(revenue) OVER (ORDER BY month) * 100
    , 2)                                AS mom_growth_pct
FROM monthly
ORDER BY month;