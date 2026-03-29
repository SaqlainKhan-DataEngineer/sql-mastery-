USE new_schema;

-- Purana safaya
DROP TABLE IF EXISTS Price_Logs;
DROP TABLE IF EXISTS Products;

-- 1. Asli Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price INT
);

-- Data daal dete hain
INSERT INTO Products VALUES (1, 'iPhone 15', 1000);
INSERT INTO Products VALUES (2, 'Samsung S24', 900);

-- 2. Log Table (Jahan history save hogi)
CREATE TABLE Price_Logs (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    Old_Price INT,
    New_Price INT,
    Change_Date DATETIME
);



DELIMITER //

-- Agar pehle se bana hai to hata do
DROP TRIGGER IF EXISTS price_update_monitor;

CREATE TRIGGER price_update_monitor
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    -- Sahi Table Name: Price_Logs
    INSERT INTO Price_Logs (ProductID, Old_Price, New_Price, Change_Date)
    VALUES (NEW.ProductID, OLD.Price, NEW.Price, NOW());
END //

DELIMITER ;



-- 1. iPhone (ID=1) ka price 1000 se badal kar 950 kar do
UPDATE Products 
SET Price = 950 
WHERE ProductID = 1;

-- 2. Ab Log Table check karo
SELECT * FROM Price_Logs;
