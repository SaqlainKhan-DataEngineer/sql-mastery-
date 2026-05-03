select * from customers 
select * from products 
select * from orders 
/*Show:

customer name
product name
amount */
select c.name as customer_name,
p.name as product_name,
o.amount 
from customers as c 
inner join orders as o 
on c.customer_id=o.customer_id
inner join products as p 
on o.product_id=p.product_id  
-- Sirf Lahore ke customers ke orders lao 
select * from customers as c 
inner join orders as o 
on c.customer_id=o.customer_id 
where city='lahore' 
--Har customer ka total spend 
select c.name,
c.customer_id,
sum(o.amount) as totalspend
from customers as c
left join orders as o 
on c.customer_id=o.customer_id 
group by c.customer_id,c.name 
--Sab se zyada spend karne wala customer 
select TOP 1
c.name,
c.customer_id,
sum(o.amount) as totalspend
from customers as c
left join orders as o 
on c.customer_id=o.customer_id 
group by c.customer_id,c.name 
order by sum(o.amount) desc 

-- Wo customers jinhone koi order nahi kiya 
select * from customers as c 
left join orders as o 
on c.customer_id=o.customer_id 
where o.customer_id is null 

-- Har category ka total revenue 
select p.category,
sum(o.amount ) as totalrevenue
from products as p 
left join orders as o 
on p.product_id=o.product_id 
group by category 
--jinhone sirf 1 hi category se purchase kiya ho  
SELECT c.customer_id, c.name,COUNT(DISTINCT p.category)as categorycount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN products p
ON o.product_id = p.product_id
GROUP BY c.customer_id, c.name
HAVING COUNT(DISTINCT p.category) = 1; 
--Wo customers lao jinhone exactly 2 different products buy kiye ho 
select c.customer_id,c.name,count(distinct o.product_id) as product_buy
from customers as c 
left join orders as o 
on c.customer_id=o.customer_id 
group by c.customer_id,c.name 
having count(distinct o.product_id) =2 

/* Wo customers lao:

jinhone exactly 1 product buy kiya
aur kam az kam 2 orders kiye ho*/ 
select c.customer_id,c.name,count(distinct o.product_id)
from customers as c 
left join orders as o
on c.customer_id=o.customer_id 
group by c.customer_id,c.name 
having count(distinct o.product_id) =1 and count(distinct o.order_id)=2 


/* Wo customers lao:

jinhone exactly 1 product buy kiya ho */ 
select c.customer_id,c.name,count(distinct o.product_id)as product_buy	 
from customers as c 
left join orders  as o 
on c.customer_id=o.customer_id 
group by c.customer_id, c.name 
having count(distinct o.product_id) =1 

/* Wo customers lao:

jinhone exactly 1 product buy kiya
aur  2 yee 2 se zayda  orders kiye ho*/ 
select c.customer_id,c.name,count(distinct o.product_id) as totalproduct 
from customers as c 
left join orders as o
on c.customer_id=o.customer_id 
group by c.customer_id,c.name 
having count(distinct o.product_id) =1 and count(distinct o.order_id)<=2

/*Wo customers lao:

jinhone 2 different products buy kiye ho*/ 
select c.customer_id,c.name,count(distinct o.product_id)as product_buy	 
from customers as c 
left join orders  as o 
on c.customer_id=o.customer_id 
group by c.customer_id, c.name 
having count(distinct o.product_id) =2  

/* Wo customers lao:

jinhone 2 ya zyada different categories se purchase kiya ho */ 
SELECT c.customer_id, c.name,COUNT(DISTINCT p.category)as categorycount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN products p
ON o.product_id = p.product_id
GROUP BY c.customer_id, c.name
HAVING COUNT(DISTINCT p.category) >=2 
/*Wo customers lao:

jinhone sirf 1 category se purchase kiya ho
aur total orders ≥ 3 ho*/ 
SELECT c.customer_id, c.name,COUNT(DISTINCT p.category)as categorycount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN products p
ON o.product_id = p.product_id
GROUP BY c.customer_id, c.name
HAVING COUNT(DISTINCT p.category) =1 and count(o.order_id) >=3 
/*Wo products lao:

jo sirf 1 hi customer ne buy kiye ho*/ 
select p.name,p.product_id,count(distinct o.customer_id) as customer_buy
from products as p 
left join orders as o 
on p.product_id=o.product_id 
group by p.name,p.product_id 
having count(distinct o.customer_id)=1 

/*Wo products lao:

jinko 2 ya zyada different customers ne buy kiya ho*/
select p.name,p.product_id,count(distinct o.customer_id) as customer_buy
from products as p 
left join orders as o 
on p.product_id=o.product_id 
group by p.name,p.product_id 
having count(distinct o.customer_id)>=2 
/* Wo customers lao:

jinhone total 2 orders kiye ho
lekin dono orders me same product ho */ 
select c.customer_id,c.name,count(distinct o.product_id) as productcount
from customers as c 
left join orders as o 
on c.customer_id=o.customer_id 
group by c.customer_id,c.name 
having count(distinct o.product_id)=1 and count( o.order_id)=2 

/*Wo customers lao:

jinhone 3 ya zyada orders kiye ho
aur har order me different product ho*/
select c.customer_id,c.name,count(distinct o.product_id) as productcount
from customers as c 
left join orders as o 
on c.customer_id=o.customer_id 
group by c.customer_id,c.name 
having   count( o.order_id)>=3  and count( o.order_id)= COUNT(DISTINCT o.product_id);

/*Wo customers lao:

jinhone 2 ya zyada categories se purchase kiya ho
lekin kisi bhi category me 1 se zyada order nahi kiya*/ 
SELECT c.customer_id, c.name,COUNT(DISTINCT p.category)as categorycount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN products p
ON o.product_id = p.product_id
GROUP BY c.customer_id, c.name
HAVING COUNT(DISTINCT p.category) >=2 
AND COUNT(o.order_id) = COUNT(DISTINCT p.category);