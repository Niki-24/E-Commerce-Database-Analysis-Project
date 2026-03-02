Create Database E_Commerce;
show databases;
use E_commerce; 

--  Customers table
CREATE TABLE customers(
	customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50), 
    singup_date  DATE );

-- Customers values
INSERT INTO customers VALUES
(1, 'Amit', 'amit@gmail.com', 'Delhi', '2023-01-10'),
(2, 'Sara', 'sara@gmail.com', 'Mumbai', '2023-02-15'),
(3, 'John', 'john@gmail.com', 'Delhi', '2023-03-20'),
(4, 'Priya', 'priya@gmail.com', 'Bangalore', '2023-04-01'),
(5, 'Ravi', 'ravi@gmail.com', 'Mumbai', '2023-05-05'); 

-- CREATING PRODUCTS TABLE
CREATE TABLE products(
	product_id int primary key,
    product_name varchar(50),
    category varchar(50),
    price decimal(10,2)
    );
    
-- Products Value 
INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 60000),
(102, 'Phone', 'Electronics', 30000),
(103, 'Shoes', 'Fashion', 4000),
(104, 'Watch', 'Fashion', 7000),
(105, 'Headphones', 'Electronics', 2000); 

--  CREATING ORDERS TABLE
CREATE TABLE orders(
		order_id INT PRIMARY KEY,
        customer_id INT,
        order_date DATE,
        status VARCHAR(20)
); 
INSERT INTO orders values
(1001, 1, '2023-06-01', 'Delivered'),
(1002, 2, '2023-06-05', 'Delivered'),
(1003, 1, '2023-06-10', 'Cancelled'),
(1004, 3, '2023-06-12', 'Delivered'),
(1005, 4, '2023-06-15', 'Delivered'),
(1006, 5, '2023-06-20', 'Delivered');

-- CREATING ORDER_ITEM table
CREATE TABLE Order_items( 
	order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT
);
-- Inserting values into order_items 
INSERT INTO Order_items values
(1, 1001, 101, 1),
(2, 1001, 105, 2),
(3, 1002, 102, 1),
(4, 1003, 103, 1),
(5, 1004, 104, 1),
(6, 1005, 101, 1),
(7, 1006, 103, 2); 

-- CREATING TABLE PAYMENTS
CREATE TABLE payments(
	payment_id int primary key, 
    order_id int,
    payment_date date,
    amount decimal(10,2),
    payment_status varchar(20)
    );
 
  -- INSERTING values into payments
  INSERT INTO payments VALUES
(5001, 1001, '2023-06-01', 64000, 'Success'),
(5002, 1002, '2023-06-05', 30000, 'Success'),
(5003, 1003, '2023-06-10', 4000, 'Failed'),
(5004, 1004, '2023-06-12', 7000, 'Success'),
(5005, 1005, '2023-06-15', 60000, 'Success'),
(5006, 1006, '2023-06-20', 8000, 'Success');
 
show databases;
use e_commerce;
show tables from e_commerce; 
select * from customers;
select * from order_items;
select * from orders;
select * from payments;
select * from products; 




use  e_commerce;
-- 1. Get all customers from Delhi
SELECT * 
FROM CUSTOMERS
WHERE CITY = 'Delhi';

-- 2. List all products in Electronics category.
SELECT product_name, category
FROM PRODUCTS
where category = 'Electronics';

-- 3.Show all delivered orders.
SELECT *
FROM orders
WHERE status = 'Delivered'; 

-- 4. Show order_id with customer name.
SELECT o.order_id, c.name
FROM orders o
JOIN customers c
on o.customer_id = c.customer_id ;
 
-- 5. Show customer name with total number of orders.  
SELECT c.name,count(o.order_id) as total_number_orders
FROM orders o
JOIN Customers c 
ON o.customer_id = c.customer_id 
GROUP BY c.name, c.customer_id; 

-- == LEVEL 2 
-- 6. Find total revenue per customer
SELECT sum(o.quantity * p.amount) as total_revenue
FROM payments p
JOIN order_items o
ON o. order_id = p.order_id 
WHERE p.payment_status = 'Success' ;

-- 7. Find top spending customer.
select  c.customer_id, c.name, sum(od.quantity*p.price) as total_spent
from customers c 
join orders o on c.customer_id = o.customer_id 
join order_items od on o.order_id = od.order_id 
join products p on od.product_id = p.product_id 
group by c.customer_id, c.name 
order by total_spent desc
limit 5 ;

-- 8. Calculate total quantity sold per product 
SELECT  p.product_name, sum(ot.quantity) as total_quantity 
FROM products p
JOIN order_items as ot
ON p.product_id = ot.product_id 
GROUP BY p.product_id,p.product_name ;


-- Find most sold product.
 SELECT p.product_name, sum(ot.quantity) as total_quantity
 FROM products p
 JOIN  order_items ot
 ON ot.product_id = p.product_id 
 GROUP By p.product_id, p.product_name
 ORDER BY total_quantity DESC
 LIMIT 1 ;