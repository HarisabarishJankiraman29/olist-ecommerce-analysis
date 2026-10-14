-- 02_aggregates_group_by.sql
-- Olist E-commerce Analysis: aggregates and GROUP BY
-- Concepts: COUNT, SUM, AVG, COUNT(DISTINCT), GROUP BY

-- Q: How many orders are there? (one row = one order)
SELECT COUNT(*) FROM orders;

-- Q: How many orders were delivered?
SELECT COUNT(*) FROM orders WHERE order_status = 'delivered';

-- Q: How many rows in order_items? (one row = one item in an order)
SELECT COUNT(*) FROM order_items;

-- Q: Total and average item price (Brazilian reals)
SELECT SUM(price), AVG(price) FROM order_items;

-- Q: Total freight (shipping) cost
SELECT SUM(freight_value) FROM order_items;

-- Q: How many orders per status?
SELECT order_status, COUNT(*) FROM orders GROUP BY order_status;

-- Q: Which 5 categories have the most products?
SELECT product_category_name, COUNT(*)
FROM products
GROUP BY product_category_name
ORDER BY COUNT(*) DESC
LIMIT 5;

-- Q: Which 5 sellers have the highest total sales, and how many items did they sell?
SELECT seller_id, SUM(price), COUNT(*)
FROM order_items
GROUP BY seller_id
ORDER BY SUM(price) DESC
LIMIT 5;

-- Q: Which 5 states have the most customer rows? (rows = orders, not people)
SELECT customer_state, COUNT(*)
FROM customers
GROUP BY customer_state
ORDER BY COUNT(*) DESC
LIMIT 5;

-- Q: How many real people vs customer rows? (customer_unique_id identifies the person)
SELECT COUNT(customer_id) FROM customers;
SELECT COUNT(DISTINCT customer_unique_id) FROM customers;