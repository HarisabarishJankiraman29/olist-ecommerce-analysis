-- 12_state_performance.sql
-- Olist E-commerce Analysis: revenue and average order value by state
-- Concepts: COUNT(DISTINCT), AOV = revenue / distinct orders, three-table join

-- Q: Which states earn the most, and what is the average order value (AOV)?
-- Note: COUNT(DISTINCT order_id) because one order has one row per item after joining order_items.
-- Result: SP 40501 orders, revenue 5067633, AOV 125.12; RJ AOV 142.48; BA AOV 151.59
-- SP wins on volume, not on order size.
SELECT c.customer_state,
       COUNT(DISTINCT o.order_id) AS orders,
       ROUND(SUM(oi.price), 0) AS revenue,
       ROUND(SUM(oi.price) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM orders AS o
JOIN customers AS c ON o.customer_id = c.customer_id
JOIN order_items AS oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY revenue DESC
LIMIT 10;