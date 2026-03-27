create table employees (
emp_id int primary key,
name varchar(50),
department varchar(100),
salary decimal
);
create table sales (
sales_id int primary key,
emp_id int,
sales_dates date,
amount decimal,
FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
)
;
insert into employees (emp_id, name, department, salary) values 
(1,'saqlain','it',50000),
(2,'tipu','cs',60000),
(3,'ali','finance',80000),
(4,'hamza','tech',40000),
(5,'hamid','marketing',70000)
;
insert into sales 
values
('1001',1,'2008-08-03','3000'),
('1002',2,'2008-09-03','4000'),
('1003',2,'2008-07-03','6000'),
('1004',3,'2008-06-03','5000'),
('1005',4,'2008-05-03','3000'),
('1006',1,'2008-04-03','7000'),
('1007',5,'2008-03-03','2000'),
('1008',4,'2008-03-03','5000');

-- Show all employees with their sales

select e.name,
s.sales_id
from employees as e
inner join sales as s
on e.emp_id=s.emp_id;

-- Show employees who never made a sale
select e.name,
s.sales_id
from employees as e
left join sales as s
on e.emp_id=s.emp_id
where sales_id is null
;

-- Find the total sales amount per employee.
SELECT e.name, 
       SUM(s.amount) AS total_sales
FROM employees as e
left JOIN sales as s
ON e.emp_id = s.emp_id
GROUP BY e.name; 

-- Find the average salary per department.
select
e.department,
avg(e.salary)
from
employees as e
group by e.department
;
-- Show employees who made more than 2 sales (use GROUP BY + HAVING).
SELECT 
  e.name,
  COUNT(s.sales_id) AS total_sales
FROM employees e
LEFT JOIN sales s
  ON e.emp_id = s.emp_id
GROUP BY e.name
HAVING COUNT(s.sales_id) > 2;

--  Find the employee with the highest single sale.
select 
e.name,
s.sales_id,
s.amount
from employees as e
left join sales as s
on e.emp_id=s.emp_id
order by s.amount DESC
limit 1
;
-- Find the department with the highest total sales.
select 
e.department,
count(s.sales_id)AS total_sales_count,
  SUM(s.amount) AS total_sales_amount

from employees as e
left join sales as s
on e.emp_id=s.emp_id
group by e.department
order by total_sales_amount DESC
limit 1

;

-- Show the top 2 employees by total sales
select 
e.name,
count(s.sales_id)AS total_sales_count,
  SUM(s.amount) AS total_sales_amount

from employees as e
left join sales as s
on e.emp_id=s.emp_id
group by e.name
order by total_sales_amount DESC
limit 2;
-- Use a subquery: Find employees whose total sales are above the average sales of all employees.
SELECT e.name, 
       SUM(s.amount) AS total_sales
FROM employees e
JOIN sales s ON e.emp_id = s.emp_id
GROUP BY e.name
HAVING SUM(s.amount) > (
    SELECT AVG(total_emp_sales)
    FROM (
        SELECT SUM(s2.amount) AS total_emp_sales
        FROM employees e2
        JOIN sales s2 ON e2.emp_id = s2.emp_id
        GROUP BY e2.name
    ) AS emp_totals
);

