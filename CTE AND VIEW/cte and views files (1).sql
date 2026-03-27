/*
Project: E-commerce Revenue Analysis using SQL
Author: [Tumhara Naam]
Description: This project demonstrates the use of CTEs and Views to solve business problems.
*/

-- 1. Setup Data (Dummy Table)
CREATE TABLE IF NOT EXISTS Orders (
    OrderID int,
    Product varchar(50),
    Category varchar(50),
    Price int,
    Quantity int
);

INSERT INTO Orders VALUES 
(1, 'Laptop', 'Electronics', 1000, 2),
(2, 'Mouse', 'Electronics', 20, 10),
(3, 'Shirt', 'Clothing', 50, 5),
(4, 'Headphones', 'Electronics', 200, 3),
(5, 'Jeans', 'Clothing', 40, 10);

-- 2. Business Problem: Calculate Total Revenue per Category
-- Solution using CTE (Common Table Expression) for Modular Logic
WITH Category_Revenue AS (
    SELECT 
        Category, 
        SUM(Price * Quantity) as Total_Revenue
    FROM Orders
    GROUP BY Category
)
SELECT * FROM Category_Revenue;

-- 3. Permanent Solution: Create a View for Reporting
-- Requirement: Only show High-Value Categories (> $1000)
CREATE OR REPLACE VIEW V_Category_Summary AS
SELECT 
    Category,
    SUM(Price * Quantity) AS Total_Revenue
FROM Orders
GROUP BY Category
HAVING SUM(Price * Quantity) > 1000;

-- 4. Testing the View
SELECT * FROM V_Category_Summary;