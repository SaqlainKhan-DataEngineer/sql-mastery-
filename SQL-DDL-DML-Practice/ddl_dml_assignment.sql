DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    country VARCHAR(20),
    signup_date DATE
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product VARCHAR(50),
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

ALTER TABLE Customers
ADD email VARCHAR(100);

ALTER TABLE Customers 
DROP COLUMN email;

INSERT INTO Customers
VALUES 
(1, 'Ali Khan', 'Pakistan', '2024-01-15'),
(2, 'John Doe', 'United States', '2024-02-20'),
(3, 'Sara Malik', 'Pakistan', '2024-03-05'),
(4, 'Emily Lee', 'Canada', '2024-01-25'),
(5, 'Ahmed Raza', 'Pakistan', '2024-04-10');

INSERT INTO Orders
VALUES
(101, 1, 'Laptop', 1, '2024-03-01'),
(102, 3, 'Headphones', 2, '2024-03-15'),
(103, 2, 'Keyboard', 1, '2024-04-01'),
(104, 1, 'Mouse', 1, '2024-04-05'),
(105, 5, 'Monitor', 2, '2024-05-12'),
(106, 3, 'Laptop', 1, '2024-05-20');

UPDATE Customers
SET country = 'United States'
WHERE customer_id = 2;

DELETE FROM Orders
WHERE order_id = 104;

INSERT INTO Customers
VALUES
(6, 'Saqlain', 'Pakistan', '2025-08-10');

INSERT INTO Orders
VALUES
(107, 5, 'RAM', 1, '2024-07-22');

SELECT *
FROM Customers;

SELECT *
FROM Orders;

SELECT COUNT(*) AS total_orders
FROM Orders;
