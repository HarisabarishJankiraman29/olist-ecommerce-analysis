-- 06_reviews_and_delivery.sql
-- Olist E-commerce Analysis: do late deliveries hurt review scores?
-- Concepts: LEFT/INNER JOIN with a subquery, SUM(CASE ...), AVG per group

-- Q: Which states have the highest late-delivery rate? (excluding orders with no delivery date)
SELECT c.customer_state,
       COUNT(*) AS delivered_orders,
       SUM(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
                THEN 1 ELSE 0 END) AS late_orders,
       ROUND(100.0 * SUM(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
                              THEN 1 ELSE 0 END) / COUNT(*), 1) AS late_pct
FROM orders AS o
JOIN customers AS c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY late_pct DESC
LIMIT 10;

-- Q: One review score per order (an order can have more than one review)
SELECT order_id, AVG(review_score) AS avg_score
FROM order_reviews
GROUP BY order_id
LIMIT 10;

-- Q: Do late deliveries get lower review scores?
-- Result: late 7661 orders avg 2.57; on time 88163 orders avg 4.29
SELECT CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
            THEN 'late' ELSE 'on time' END AS delivery_status,
       COUNT(*) AS orders,
       ROUND(AVG(r.avg_score), 2) AS avg_review_score
FROM orders AS o
JOIN (SELECT order_id, AVG(review_score) AS avg_score
      FROM order_reviews
      GROUP BY order_id) AS r
  ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY delivery_status;