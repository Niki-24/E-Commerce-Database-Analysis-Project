# 📌 Project Overview
This project simulates an E-Commerce database system using MySQL.
It includes database design, data insertion, and analytical queries.
## The goal of this project is to demonstrate:
### SQL fundamentals
- Joins
- Aggregations
- GROUP BY & HAVING
- Business KPI calculations
--- 
# 📂 Database Schema
The project includes 5 tables:
- Customers
- Products
- Orders
- Order_Items
- Payments
---
# 📊 Business Questions Solved
1. Customers from Delhi
2. Electronics products list
3. Delivered orders
4. Total orders per customer
5. Revenue per customer
6. Top spending customer
7. Most sold product
8. Total quantity sold per product
--- 
# 🛠 Skills Demonstrated
- SQL Joins (INNER JOIN, LEFT JOIN)
- Aggregate Functions (SUM, COUNT)
- GROUP BY & HAVING
- Filtering with WHERE
- Revenue calculation logic
- Business KPI analysis
--- 
# 📈 Future Improvements
- Add Foreign Key constraints
- Add Indexes for performance
- Add Monthly Revenue Analysis
- Add Window Functions (RANK, DENSE_RANK)
- Create Stored Procedures
- Convert into Data Warehouse Star Schema
- Build Power BI Dashboard on top of this database

# 📊📉 Data Analaysis & Findings
1. **Get all customers from Delhi.**
```sql
  SELECT * 
FROM CUSTOMERS
WHERE CITY = 'Delhi';
```
2. **List all products in Electronics category.**
```sql
  SELECT product_name, category
FROM PRODUCTS
where category = 'Electronics';
```
3. **Show all delivered orders.**
```sql
  SELECT *
FROM orders
WHERE status = 'Delivered';
```
4. **Show order_id with customer name.**
   ```sql
SELECT o.order_id, c.name
FROM orders o
JOIN customers c
on o.customer_id = c.customer_id ; 
```
5. **Show customer name with total number of orders.**
```sql
SELECT c.name,count(o.order_id) as total_number_orders
FROM orders o
JOIN Customers c 
ON o.customer_id = c.customer_id 
GROUP BY c.name, c.customer_id;
``` 
6.**Find total revenue per customer.**
```sql
  SELECT sum(o.quantity * p.amount) as total_revenue
FROM payments p
JOIN order_items o
ON o. order_id = p.order_id 
WHERE p.payment_status = 'Success' ;
```
7.**Find top spending customer.**
```sql
  select  c.customer_id, c.name, sum(od.quantity*p.price) as total_spent
from customers c 
join orders o on c.customer_id = o.customer_id 
join order_items od on o.order_id = od.order_id 
join products p on od.product_id = p.product_id 
group by c.customer_id, c.name 
order by total_spent desc
limit 5 ;
```
8. **Calculate total quantity sold per product.**
```sql
  SELECT  p.product_name, sum(ot.quantity) as total_quantity 
FROM products p
JOIN order_items as ot
ON p.product_id = ot.product_id 
GROUP BY p.product_id,p.product_name ;
```
9.**Find most sold product.**
```sql
  SELECT p.product_name, sum(ot.quantity) as total_quantity
 FROM products p
 JOIN  order_items ot
 ON ot.product_id = p.product_id 
 GROUP By p.product_id, p.product_name
 ORDER BY total_quantity DESC
 LIMIT 1 ;
```
     

