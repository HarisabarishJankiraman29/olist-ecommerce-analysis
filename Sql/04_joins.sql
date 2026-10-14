-- 04_joins.sql
-- Olist E-commerce Analysis: JOINs
-- Concepts: JOIN, LEFT JOIN, table aliases, multi-table joins

-- Q: Which state is each order's customer in?
SELECT orders.order_id, customers.customer_state, orders.order_status
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
LIMIT 10;

-- Q: Row count after joining orders to customers (should stay 99441: one customer record per order)
SELECT COUNT(*)
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id;

-- Q: Row count after joining orders to order_items (more rows: one row per item)
SELECT COUNT(*)
FROM orders
JOIN order_items ON orders.order_id = order_items.order_id;

-- Q: Row count with LEFT JOIN (keeps orders that have no items)
SELECT COUNT(*)
FROM orders
LEFT JOIN order_items ON orders.order_id = order_items.order_id;

-- Q: Which orders have no items at all?
SELECT COUNT(*)
FROM orders
LEFT JOIN order_items ON orders.order_id = order_items.order_id
WHERE order_items.order_id IS NULL;

-- Q: Revenue, items sold and average price by product category (English names)
-- Note: includes all order statuses; to be refined later.
SELECT t.product_category_name_english,
       SUM(oi.price) AS revenue,
       COUNT(*) AS items_sold,
       AVG(oi.price) AS avg_price
FROM order_items AS oi
JOIN products AS p ON oi.product_id = p.product_id
JOIN category_translation AS t ON p.product_category_name = t.product_category_name
GROUP BY t.product_category_name_english
ORDER BY revenue DESC
LIMIT 10;