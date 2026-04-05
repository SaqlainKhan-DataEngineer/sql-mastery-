/*
Project: Employee Salary Analysis
Author: [Tera Naam Yahan Likh]
Description: 
    This project demonstrates the critical difference between GROUP BY and Window Functions (OVER).
    - Scenario A: Aggregating data to see Department-level totals (Reducing rows).
    - Scenario B: Using Window Functions to compare individual salaries against Department totals (Keeping all rows).
*/

-- ==========================================
-- 1. SETUP: Employee Data
-- ==========================================
DROP TABLE IF EXISTS Employees;

CREATE TABLE Employees (
    Name varchar(50),
    Dept varchar(50),
    Salary int
);

INSERT INTO Employees VALUES 
('Ali', 'IT', 100),
('Bilal', 'IT', 120),
('Zara', 'HR', 90),
('Sana', 'HR', 80);

-- ==========================================
-- SCENARIO 1: The Manager's View (Aggregation)
-- Goal: Calculate total salary expense per Department.
-- Technique: GROUP BY (Collapses rows into a summary)
-- ==========================================
SELECT 
    Dept, 
    SUM(Salary) AS Total_Dept_Salary
FROM Employees
GROUP BY Dept;

-- Result:
-- IT | 220
-- HR | 170


-- ==========================================
-- SCENARIO 2: The Analytic View (Window Function)
-- Goal: Show every employee's salary alongside their Department's total.
-- Technique: OVER (PARTITION BY) - Maintains detailed rows while adding context.
-- ==========================================
SELECT 
    Name, 
    Dept, 
    Salary,
    SUM(Salary) OVER (PARTITION BY Dept) AS Dept_Total_Salary,
    -- Bonus: Calculating % of Dept Budget this employee takes
    (Salary / SUM(Salary) OVER (PARTITION BY Dept)) * 100 AS Pct_Of_Dept_Budget
FROM Employees;

-- Result:
-- Ali   | IT | 100 | 220 | 45.45%
-- Bilal | IT | 120 | 220 | 54.54%
-- ... (All rows preserved)