--filtering data 
-- retrive all customer from germany 

select * from customers where country = 'germany' 
-- retrive all customer  not from germany  
select * from customers where country != 'germany' 
-- retrive all customers with the score greater then 500 
select * from customers where score >500 
-- retrive all customers with the score  500 or more 
select * from customers where score >=500 
-- retrive all customers with the score less then 500 
select * from customers where score <500  
-- retrive all customers with the score  500 or less 
select * from customers where score <=500 
-- retive all the customers from usa and have a score greater then 500 
select * from customers where country = 'usa'and score >500  
-- retive all the customers who are either from usa or have a score greater then 500 
select * from customers where country = 'usa'or score >500 
-- retive a customers with a score not less then 500 
select * from customers where not score < 500 
-- retrive a customers whose score falls in the range between 100 and 500 
select * from customers where score between 100 and 500  
-- retrive all the customers from either germany or usa 
select * from customers  where country in ('germany','usa')  
-- find all the customers whose name strat with 'm'
select * from customers where first_name like 'm%' 
-- find all the customers whose name ends with 'n' 
select * from customers where first_name like '%n' 
-- find all customers whose first-name contain r 
select * from customers where first_name like '%r%' 
-- find all customers whose first name has r in the third position 
select * from customers where first_name like '--r' 

-- create student table 

use practice
create table students( 
id int not null,
name varchar(50) not null,
age int,
city varchar(20),
) 
select 
name,city 
from students 
where age >20  

create table employees(
id int not null,
name  varchar(50),
salary int,
constraint pk_employees primary key(id)
)
insert into employees
values(1,'saqlain',10000),
(2,'muhtasham',12000),
(3,'ali',12500)  
update employees 
set 
salary = 70000
where id =1

select * from students where city = 'lahore'
select * from students where name like 'A%'
select * from students where name like '%n' 
select * from students where name like '%ar%' 

-- joins 
-- retive all the data from customers and orders in two different result  
-- no joins

select * from customers;
select * from orders 

-- inner join 
-- get all the customers alongs with their orders but only for the customers who have placed an order
select 
c.id,
c.first_name,
o.order_id,
o.sales
from customers as c 
inner join orders as o
on c.id=o.customer_id  

-- get all the customers with orders including those without orders 
select * 
from customers  as c
left join orders as o 
on 
c.id = o.customer_id
-- get all the customers along with their orders including orders without matching customers 
select 
id, 
first_name,
order_id,
sales
from orders as o 
left join customers as c 
on o.customer_id=c.id 
-- second weay to solve this same task 
select
id, 
first_name,
order_id,
sales
from customers as c 
right join orders as o 
on c.id=o.customer_id  
-- get all the customers  and order even if their is no match  
select * from orders as o 
full join customers as c 
on c.id=o.customer_id 

-- get all the customers who have not placed any order 
select 
*  
from customers as c 
left join orders as o 
on c.id=o.customer_id 
where o.customer_id is null  

select * from orders as o 
left join customers as c 
on o.customer_id=c.id 
where c.id is null

-- find orders without customers and orders without customers 
select *
from customers as c 
full join orders as o 
on c.id=o.customer_id 
where c.id is null or o.customer_id is null 
-- genrate al possible combination of customers and orders 
select * from customers 
cross join orders

