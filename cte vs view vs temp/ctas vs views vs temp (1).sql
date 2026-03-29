/*
Project: SQL Performance Strategies (View vs CTAS vs Temp Tables)
Author: [Tera Naam Yahan Likh]
Description: 
    This project demonstrates when to use different SQL storage strategies based on business needs:
    1. VIEW: For real-time data access (Live Dashboard).
    2. CTAS (Create Table As Select): For freezing data for historical reporting (Snapshot).
    3. TEMPORARY TABLES: For complex, multi-step ad-hoc analysis (Scratchpad).
*/

-- ==========================================
-- 1. SETUP: Simulating an E-commerce Database
-- ==========================================
DROP TABLE IF EXISTS Sales_Data;

CREATE TABLE Sales_Data (
    SaleID INT,
    Product VARCHAR(50),
    Category VARCHAR(50),
    Amount INT,
    SaleDate DATE
);

INSERT INTO Sales_Data VALUES 
(1, 'Laptop', 'Electronics', 1200, '2024-01-01'),
(2, 'Headphones', 'Electronics', 100, '2024-01-02'),
(3, 'T-Shirt', 'Clothing', 25, '2024-01-02'),
(4, 'Phone', 'Electronics', 800, '2024-01-03'),
(5, 'Jeans', 'Clothing', 50, '2024-01-04');

-- ==========================================
-- STRATEGY 1: THE VIEW (Live Window)
-- Use Case: Customer Support needs to see current orders immediately.
-- ==========================================
CREATE OR REPLACE VIEW V_Live_Electronics AS
SELECT * FROM Sales_Data 
WHERE Category = 'Electronics';

-- Test: This will always show the latest data.
SELECT * FROM V_Live_Electronics;


-- ==========================================
-- STRATEGY 2: CTAS (Snapshot / Materialized Data)
-- Use Case: End-of-Month Report. We need a "Frozen" copy so numbers don't change while we analyze.
-- Benefit: Faster read performance for heavy reporting.
-- ==========================================
DROP TABLE IF EXISTS Monthly_Sales_Snapshot;

CREATE TABLE Monthly_Sales_Snapshot AS
SELECT 
    Category, 
    SUM(Amount) as Total_Revenue,
    COUNT(*) as Total_Items_Sold
FROM Sales_Data
GROUP BY Category;

-- Test: This data is now permanent and won't change even if Sales_Data changes.
SELECT * FROM Monthly_Sales_Snapshot;


-- ==========================================
-- STRATEGY 3: TEMPORARY TABLE (The Scratchpad)
-- Use Case: Complex Ad-hoc Analysis.
-- Problem: Find products that are cheaper than the average price of their category.
-- Solution: We need intermediate steps but don't want to clutter the database permanently.
-- ==========================================

-- Step A: Calculate Average Price per Category in a Temp Table
CREATE TEMPORARY TABLE Temp_Category_Avg AS
SELECT 
    Category, 
    AVG(Amount) as Avg_Price
FROM Sales_Data
GROUP BY Category;

-- Step B: Join Temp Table with Original Data to find cheap items
SELECT 
    S.Product, 
    S.Amount, 
    T.Avg_Price
FROM Sales_Data S
JOIN Temp_Category_Avg T ON S.Category = T.Category
WHERE S.Amount < T.Avg_Price;

-- Note: Temp_Category_Avg will automatically vanish when the session ends.