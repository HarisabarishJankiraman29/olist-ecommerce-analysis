-- 01_basics_select_where_orderby.sql
-- Olist E-commerce Analysis: first exploration queries
-- Concepts: SELECT, FROM, WHERE, ORDER BY, LIMIT

-- Q: What does the orders table look like? (one row = one order)
SELECT * FROM orders LIMIT 10;

-- Q: Pick specific columns only
SELECT order_id, order_status, order_purchase_timestamp FROM orders LIMIT 20;

-- Q: Which orders were cancelled? (the status value is spelled 'canceled')
SELECT order_id, order_status FROM orders WHERE order_status = 'canceled' LIMIT 10;

-- Q: Which items cost less than 10? (one row in order_items = one item within an order)
SELECT order_id, price FROM order_items WHERE price < 10 LIMIT 10;

-- Q: What are the 10 cheapest items costing more than 100?
SELECT order_id, price FROM order_items WHERE price > 100 ORDER BY price ASC LIMIT 10;

-- Q: What are the 10 most expensive items?
SELECT order_id, price FROM order_items ORDER BY price DESC LIMIT 10;