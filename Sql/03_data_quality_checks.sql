-- 03_data_quality_checks.sql
-- Olist E-commerce Analysis: data quality checks
-- Concepts: IS NULL, AND, COUNT(DISTINCT), duplicate checks

-- Q: How many orders have no delivery date?
SELECT COUNT(*) FROM orders WHERE order_delivered_customer_date IS NULL;

-- Q: How many orders were never approved, and what status are they in?
SELECT order_status, COUNT(*)
FROM orders
WHERE order_approved_at IS NULL
GROUP BY order_status;

-- Q: Are there delivered orders with no delivery date? (data issue: should be zero)
SELECT COUNT(*)
FROM orders
WHERE order_status = 'delivered'
AND order_delivered_customer_date IS NULL;

-- Q: Is order_id unique in orders? (rows vs distinct order_ids)
SELECT COUNT(*), COUNT(DISTINCT order_id) FROM orders;

-- Q: Same check on order_items (differs because one order can have many items)
SELECT COUNT(*), COUNT(DISTINCT order_id) FROM order_items;