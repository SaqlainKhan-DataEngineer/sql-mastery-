/*
Project: Amazon Returns Analysis (Storage Strategies)
Author: [Tera Naam Yahan Likh]
Description: 
    This project demonstrates three different SQL storage techniques using an E-commerce Returns dataset:
    1. VIEW: Created a dynamic filter for 'Damaged' items (Live Data).
    2. CTAS (Create Table As Select): Created a static backup for Audit purposes (Frozen Data).
    3. TEMPORARY TABLE: Used for ad-hoc tax calculations without altering the main database.
*/

-- ==========================================
-- 1. SETUP: Fresh & Clean Database
-- ==========================================
-- Cleaning up old tables to avoid duplicates/errors
DROP TABLE IF EXISTS Amazon_Returns;
DROP VIEW IF EXISTS V_Damaged_Items;
DROP TABLE IF EXISTS Returns_Backup;

-- Creating the Main Table
CREATE TABLE Amazon_Returns (
    ReturnID int,
    Product varchar(50),
    Reason varchar(50),
    RefundAmount int
);

-- Inserting Clean Data (Single Batch)
INSERT INTO Amazon_Returns VALUES 
(1, 'Laptop', 'Damaged', 1000),
(2, 'Mouse', 'Changed Mind', 20),
(3, 'Shirt', 'Wrong Size', 50),
(5, 'Cell', 'Damaged', 40);


-- ==========================================
-- STRATEGY 1: THE VIEW (Dynamic Filter)
-- Goal: Operations team needs to see ONLY Damaged items in real-time.
-- ==========================================
CREATE VIEW V_Damaged_Items AS
SELECT 
    Product,
    Reason
FROM Amazon_Returns
WHERE Reason = 'Damaged';

-- Test the View
SELECT * FROM V_Damaged_Items;


-- ==========================================
-- STRATEGY 2: CTAS (Static Backup)
-- Goal: Audit team needs a "Snapshot" of returns as they were today.
--       This table will NOT change even if main data is deleted.
-- ==========================================
CREATE TABLE Returns_Backup AS 
SELECT * FROM Amazon_Returns;

-- Test the Backup
SELECT * FROM Returns_Backup;


-- ==========================================
-- STRATEGY 3: TEMPORARY TABLE (Ad-hoc Analysis)
-- Goal: Calculate Refund amount after 10% processing fee.
--       We use a Temp Table to keep the main DB clean.
-- ==========================================
CREATE TEMPORARY TABLE Temp_Electronics AS
SELECT 
    Product,
    RefundAmount
FROM Amazon_Returns;

-- Final Calculation (Refund - 10%)
SELECT 
    Product,
    RefundAmount * 0.9 AS Refund_After_Fee
FROM Temp_Electronics;

-- Note: Temp_Electronics will be automatically deleted when session ends.