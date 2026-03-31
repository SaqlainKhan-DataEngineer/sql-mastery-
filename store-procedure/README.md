# store-procedure

# 🚀 SQL Stored Procedures & Business Logic

## 📌 Project Overview
This project demonstrates the power of **Stored Procedures** in MySQL to handle complex business logic directly within the database. 
Instead of writing repetitive queries, I encapsulated logic into reusable procedures to improve **performance**, **security**, and **maintainability**.

## 🛠️ Key Concepts Implemented
- **Stored Procedures:** Creating reusable logic blocks to avoid code repetition.
- **Input Parameters:** Making queries dynamic by accepting user inputs (e.g., `cust_id`, `CountryName`).
- **Conditional Logic (IF-ELSE):** Implementing business rules (e.g., classifying customers as 'VIP' or 'Regular' based on scores).
- **Variables:** Using internal variables (`DECLARE`, `SET`) to hold intermediate calculations.
- **Error Handling:** Fixing collation mismatch errors (`COLLATE`) for robust string comparison.

## 📂 Scenarios Covered

### 1. Customer Loyalty System (`CheckLoyalty`)
- **Goal:** Automatically classify a customer based on their score.
- **Logic:** - Retrieves the customer's score from the database.
  - Checks if `Score > 500`.
  - Returns a dynamic message: *"VIP Member 🌟"* or *"Regular Member 😐"*.

### 2. Dynamic Country Report (`PrintCustomers`)
- **Goal:** Fetch customer statistics for any specific country.
- **Logic:** - Accepts a `Country` name as a parameter.
  - Calculates Total Customers and Average Score.
  - Handles **Collation Errors** to ensure seamless text comparison across different charsets.

## 💻 Tech Stack
- **Database:** MySQL
- **Language:** SQL (Structured Query Language)

## 🚀 How to Run
1. Clone this repository.
2. Run the SQL script to create the tables and procedures.
3. Call the procedures using:
   ```sql
   CALL CheckLoyalty(101);
   CALL PrintCustomers('USA');
