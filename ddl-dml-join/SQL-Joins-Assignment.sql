
create table customers (
customer_id int primary key,
Name varchar(50) null,
email varchar(50),
country varchar(50) 
)
;
create table product (
product_id int primary key,
product_name varchar(50),
price decimal

)
;
create table orders(
order_id int primary key,
customer_id int,
order_date date,
 FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
)
;
create table orderdetail (
orderdetail_id int primary key,
order_id int ,
product_id int ,
quantity int,
 FOREIGN KEY (order_id) REFERENCES orders(order_id),
 FOREIGN KEY (product_id) REFERENCES  product(product_id)
); 

insert into customers (customer_id,name,email,country)
values
(1,'saqlain','khan','german'),
(2,'muhtasham','muhstahamsajjad','french'),
(3,'ali','hassam','danish'),
(4,'hamid','hamidali','swedish'),
(5,'tipu','tipukhan','finnish')

;
insert into product
values
(6,'laptop','50000'),
(7,'keyboard','2000'),
(8,'cabel','5000'),
(9,'counter','51000'),
(10,'mothernoard','15000')
;
insert into orders
values
('1001','2','2005-01-11'),
('1002','4','2007-02-12'),
('1003','5','2010-03-07'),
('1004','5','2012-05-06'),
('1005','5','2011-09-08');
insert into orderdetail
values
('1305','1001','6','15'),
('1306','1002','7','20'),
('1307','1003','8','50'),
('1308','1004','9','30'),
('1309','1005','10','10'),
('1310','1001','6','200'),
('1311','1002','7','30'),
('1312','1003','8','20');





select c.name,
o.order_id
from customers as c
inner join orders as o
on c.customer_id = o.customer_id
;
select 
c.name,
o.order_id
from 
customers as c
left join orders as o
on c.customer_id = o.customer_id
;
select
p.product_id,
p.product_name,
od.orderdetail_id,
od.order_id
from product as p
left join orderdetail as od
on p.product_id=od.product_id
where od.product_id is null
;

select
	c.name,
	p.product_name,
	od.quantity,
	(od.quantity * p.price) AS total_price

FROM OrderDetail as od
JOIN Orders as o ON od.order_id = o.order_id
JOIN Customers as  c ON o.customer_id = c.customer_id
JOIN Product as  p ON od.product_id = p.product_id;

SELECT 
c.name, 
COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o 
ON c.customer_id = o.customer_id
GROUP BY c.name;

SELECT c.name, SUM(od.quantity * p.price) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderDetail od ON o.order_id = od.order_id
JOIN Product p ON od.product_id = p.product_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 2;

SELECT p.product_name, SUM(od.quantity) AS total_quantity
FROM Product p
JOIN OrderDetail od ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC
LIMIT 1;
