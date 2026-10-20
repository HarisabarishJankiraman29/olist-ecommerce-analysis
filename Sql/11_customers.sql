-- 11_customers.sql
-- Olist E-commerce Analysis: repeat purchases and customer value
-- Concepts: CTE, COUNT(DISTINCT), SUM(CASE ...), joining three tables

-- Q: What share of customers bought more than once?
-- Result: 93358 customers, 2801 repeat customers, 3.0% repeat rate
WITH customer_orders AS (
    SELECT c.customer_unique_id,
           COUNT(DISTINCT o.order_id) AS orders
    FROM orders AS o
    JOIN customers AS c ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)
SELECT COUNT(*) AS customers,
       SUM(CASE WHEN orders > 1 THEN 1 ELSE 0 END) AS repeat_customers,
       ROUND(100.0 * SUM(CASE WHEN orders > 1 THEN 1 ELSE 0 END) / COUNT(*), 1) AS repeat_pct
FROM customer_orders;

-- Q: Who are the highest-spending customers?
-- Note: most of the top spenders placed just 1 order (one big purchase), so spend alone does not mean loyalty.
WITH customer_spend AS (
    SELECT c.customer_unique_id,
           COUNT(DISTINCT o.order_id) AS orders,
           ROUND(SUM(oi.price), 2) AS total_spend
    FROM orders AS o
    JOIN customers AS c ON o.customer_id = c.customer_id
    JOIN order_items AS oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)
SELECT customer_unique_id,
       orders,
       total_spend
FROM customer_spend
ORDER BY total_spend DESC
LIMIT 10;