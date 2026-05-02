/*
retrive a list of all orders ,along with the related customers ,product,and employees details  
for each order display 
order id 
customer name 
product name 
sales amount 
product price 
salespersons name */ 
use SalesDB 
select o.orderid,
c.firstname as customer_name,
p.product as productname,
o.sales,
p.price as productprice,
e.firstname as sales_person_name
from sales.orders as o 
left join sales.customers as c 
on o.customerid=c.customerid 
left join sales.products  as p
on o.productid=p.productid
left join sales.employees as e 
on o.SalesPersonID=e.EmployeeID 

