-- Task 6: Sales Trend Analysis Using Aggregations
-- Database: online_sales
-- Table: orders(order_id, order_date, amount, product_id)
create database online_sales;
use online_sales;

-- Create table
CREATE TABLE orders (
    order_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    product_id INT
);

-- Insert larger sample data (50 rows across 2022–2023)
INSERT INTO orders (order_id, order_date, amount, product_id) VALUES
(1, '2022-11-05', 200.00, 101),
(2, '2022-11-12', 150.00, 102),
(3, '2022-11-18', 300.00, 103),
(4, '2022-12-01', 400.00, 104),
(5, '2022-12-05', 250.00, 105),
(6, '2022-12-15', 600.00, 106),
(7, '2022-12-28', 750.00, 107),
(8, '2023-01-05', 500.00, 108),
(9, '2023-01-10', 320.00, 109),
(10, '2023-01-15', 150.00, 110),
(11, '2023-01-22', 700.00, 111),
(12, '2023-02-02', 450.00, 112),
(13, '2023-02-07', 650.00, 113),
(14, '2023-02-12', 900.00, 114),
(15, '2023-02-18', 350.00, 115),
(16, '2023-02-25', 400.00, 116),
(17, '2023-03-01', 1000.00, 117),
(18, '2023-03-05', 780.00, 118),
(19, '2023-03-12', 640.00, 119),
(20, '2023-03-18', 500.00, 120),
(21, '2023-03-25', 860.00, 121),
(22, '2023-04-02', 1200.00, 122),
(23, '2023-04-07', 400.00, 123),
(24, '2023-04-11', 300.00, 124),
(25, '2023-04-20', 950.00, 125),
(26, '2023-05-03', 700.00, 126),
(27, '2023-05-09', 450.00, 127),
(28, '2023-05-15', 640.00, 128),
(29, '2023-05-19', 800.00, 129),
(30, '2023-05-25', 1000.00, 130),
(31, '2023-06-01', 150.00, 131),
(32, '2023-06-07', 400.00, 132),
(33, '2023-06-13', 900.00, 133),
(34, '2023-06-20', 750.00, 134),
(35, '2023-06-27', 300.00, 135),
(36, '2023-07-02', 620.00, 136),
(37, '2023-07-08', 540.00, 137),
(38, '2023-07-14', 850.00, 138),
(39, '2023-07-21', 400.00, 139),
(40, '2023-07-28', 990.00, 140),
(41, '2023-08-03', 1500.00, 141),
(42, '2023-08-09', 1200.00, 142),
(43, '2023-08-15', 800.00, 143),
(44, '2023-08-21', 600.00, 144),
(45, '2023-08-27', 450.00, 145),
(46, '2023-09-01', 1100.00, 146),
(47, '2023-09-06', 700.00, 147),
(48, '2023-09-12', 950.00, 148),
(49, '2023-09-18', 1050.00, 149),
(50, '2023-09-25', 1300.00, 150);


-- These query is to prepare outputs of all 3 queries into one table
WITH monthly AS (
    SELECT 
        EXTRACT(YEAR FROM order_date) AS Year,
        EXTRACT(MONTH FROM order_date) AS Month,
        SUM(amount) AS Monthly_Revenue,
        COUNT(DISTINCT order_id) AS Order_Volume
    FROM orders
    GROUP BY Year, Month
),
top3 AS (
    SELECT 
        EXTRACT(YEAR FROM order_date) AS Year,
        EXTRACT(MONTH FROM order_date) AS Month,
        SUM(amount) AS Monthly_Revenue,
        COUNT(DISTINCT order_id) AS Order_Volume
    FROM orders
    GROUP BY Year, Month
    ORDER BY Monthly_Revenue DESC
    LIMIT 3
),
nullsafe AS (
    SELECT 
        EXTRACT(YEAR FROM order_date) AS Year,
        EXTRACT(MONTH FROM order_date) AS Month,
        SUM(COALESCE(amount, 0)) AS Monthly_Revenue,
        COUNT(DISTINCT order_id) AS Order_Volume
    FROM orders
    GROUP BY Year, Month
)

-- Final combined output
SELECT 'Monthly Revenue and Order Volume' AS Section, Year, Month, Monthly_Revenue, Order_Volume
FROM monthly
UNION ALL
SELECT 'Top 3 Months by Revenue' AS Section, Year, Month, Monthly_Revenue, Order_Volume
FROM top3
UNION ALL
SELECT 'Revenue Handling NULLs' AS Section, Year, Month, Monthly_Revenue, Order_Volume
FROM nullsafe
ORDER BY Section, Year, Month;

