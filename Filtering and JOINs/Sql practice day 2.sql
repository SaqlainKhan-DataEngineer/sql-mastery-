CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount INT,
    order_date DATE
); 

INSERT INTO customers VALUES
(1,'Ali','Lahore'),
(2,'Saqlain','Faisalabad'),
(3,'Ahmed','Karachi'),
(4,'Sara','Lahore');

INSERT INTO orders VALUES
(101,1,5000,'2024-01-01'),
(102,2,7000,'2024-01-02'),
(103,1,3000,'2024-01-03'),
(104,3,9000,'2024-01-04'),
(105,4,2000,'2024-01-05'); 
--1
select * from orders as o  
left join customers as c 
on o.customer_id=c.customer_id 
--2
select * from orders as o  
left join customers as c 
on o.customer_id=c.customer_id 
where c.city='lahore'
--3
select c.customer_id,
sum(o.amount) as totalspend 
from orders as o  
left join customers as c 
on o.customer_id=c.customer_id 
where c.city='lahore'
group by c.customer_id  
--4
select Top 1
c.customer_id,
sum(o.amount) as totalspend 
from orders as o  
left join customers as c 
on o.customer_id=c.customer_id 
where c.city='lahore'
group by c.customer_id   
order by sum(o.amount) desc   

--5
select * from customers as c 
left join orders as o 
on
c.customer_id=o.customer_id  
where name like 's%' and order_id is not null
--6
select * from customers as c 
left join orders as o 
on
c.customer_id=o.customer_id 
where amount >5000 
--7 
select c.customer_id, c.name,
count(o.order_id) as total_orders
from customers c
inner join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.name
having count(o.order_id) >= 2;
