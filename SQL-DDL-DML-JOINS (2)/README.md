# SQL-DDL-DML-joins-Practice2
DDL and DML JOINS practice with Customers and Orders tables and write some of the quries 
# SQL Aggregation & Subquery Assignment

This project demonstrates practice with **SQL Aggregations, Joins, Grouping, and Subqueries**.  
It contains a small database with `employees` and `sales` tables.

---

## 📂 Project Structure
- `SQL-Aggregation-Assignment.sql` → Contains table creation, inserts, and queries.  
- `README.md` → Documentation with query descriptions and screenshots.  

---

## 🗄️ Database Schema
- **employees**
  - emp_id (Primary Key)  
  - name  
  - department  
  - salary  

- **sales**
  - sales_id (Primary Key)  
  - emp_id (Foreign Key → employees)  
  - sales_date  
  - amount  

---

## 📝 Queries Implemented
1. Show all employees with their sales (INNER JOIN).  
2. Show employees who never made a sale.  
3. Find the total sales amount per employee.  
4. Find the average salary per department.  
5. Show employees who made more than 2 sales (GROUP BY + HAVING).  
6. Find the employee with the highest single sale.  
7. Find the department with the highest total sales.  
8. Show the top 2 employees by total sales.  
9. Find employees whose total sales are above the average sales of all employees (Subquery).  

---


