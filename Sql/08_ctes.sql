-- 08_ctes.sql
-- Olist E-commerce Analysis: CTEs (WITH)
-- Concepts: a named temporary table, chaining two CTEs with a comma

-- Q: One review score per order, and the overall average (98673 orders, avg 4.09)
WITH order_scores AS (
    SELECT order_id,
           AVG(review_score) AS avg_score
    FROM order_reviews
    GROUP BY order_id
)
SELECT COUNT(*) AS orders,
       ROUND(AVG(avg_score), 2) AS overall_avg
FROM order_scores;

-- Q: How many orders have an average review score below 3? (14483, about 14.7% of 98673)
WITH order_scores AS (
    SELECT order_id,
           AVG(review_score) AS avg_score
    FROM order_reviews
    GROUP BY order_id
)
SELECT COUNT(*)
FROM order_scores
WHERE avg_score < 3;

-- Q: Do late deliveries get lower review scores? (same result as 06, written with two CTEs)
-- Result: late 7661 orders avg 2.57; on time 88163 orders avg 4.29
WITH order_scores AS (
    SELECT order_id,
           AVG(review_score) AS avg_score
    FROM order_reviews
    GROUP BY order_id
),
delivery AS (
    SELECT order_id,
           CASE WHEN order_delivered_customer_date > order_estimated_delivery_date
                THEN 'late' ELSE 'on time' END AS delivery_status
    FROM orders
    WHERE order_status = 'delivered'
      AND order_delivered_customer_date IS NOT NULL
)
SELECT d.delivery_status,
       COUNT(*) AS orders,
       ROUND(AVG(s.avg_score), 2) AS avg_review_score
FROM delivery AS d
JOIN order_scores AS s ON d.order_id = s.order_id
GROUP BY d.delivery_status;