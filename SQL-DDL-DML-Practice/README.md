# SQL DDL and DML Practice


This project demonstrates my practice of **Data Definition Language (DDL)** and **Data Manipulation Language (DML)** in MySQL.  
It is part of my journey to become a Data Engineer.

---

## 📂 Project Overview
This assignment includes:
- Creating tables with primary and foreign keys
- Adding and removing columns
- Inserting, updating, and deleting records
- Counting total records using `COUNT(*)`

---

## 🛠️ Technologies Used
- **MySQL** (tested on MySQL 8.x)
- **SQL** language

---

## 📊 Tables Created

### 1. **Customers**
| Column        | Type         | Description |
|---------------|-------------|-------------|
| `customer_id` | INT (PK)    | Unique ID for each customer |
| `name`        | VARCHAR(50) | Customer name |
| `country`     | VARCHAR(20) | Customer country |
| `signup_date` | DATE        | Date of signup |

### 2. **Orders**
| Column        | Type         | Description |
|---------------|-------------|-------------|
| `order_id`    | INT (PK)    | Unique ID for each order |
| `customer_id` | INT (FK)    | References `Customers.customer_id` |
| `product`     | VARCHAR(50) | Product name |
| `quantity`    | INT         | Number of products ordered |
| `order_date`  | DATE        | Date the order was placed |

---

## 🚀 How to Run
1. Clone this repository or download the `.sql` file.
2. Open MySQL (CLI or GUI like MySQL Workbench).
3. Run the commands from `ddl_dml_assignment.sql`.
4. Use `SELECT` queries to check the results.

---

## 📌 Example Commands
```sql
-- View all customers
SELECT * FROM Customers;

-- View all orders
SELECT * FROM Orders;

-- Count total orders
SELECT COUNT(*) AS total_orders FROM Orders;




