-- 05_case_when_delivery.sql
-- Olist E-commerce Analysis: CASE WHEN and delivery performance
-- Concepts: CASE WHEN, IS NULL inside CASE, GROUP BY on a CASE label

-- Q: Label each item as budget / cheap / mid / premium (smallest limit first)
SELECT order_id,
       price,
       CASE WHEN price < 20 THEN 'budget'
            WHEN price < 50 THEN 'cheap'
            WHEN price < 150 THEN 'mid'
            ELSE 'premium'
       END AS price_band
FROM order_items
LIMIT 10;

-- Q: Was each delivered order late or on time? (IS NULL first so missing dates are not called on time)
SELECT order_id,
       order_delivered_customer_date,
       order_estimated_delivery_date,
       CASE WHEN order_delivered_customer_date IS NULL THEN 'no delivery date'
            WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 'late'
            ELSE 'on time'
       END AS delivery_status
FROM orders
WHERE order_status = 'delivered'
LIMIT 10;

-- Q: How many delivered orders were late, on time, or have no delivery date?
-- Result: late 7826, on time 88644, no delivery date 8 (total 96478, about 8.1% late)
SELECT CASE WHEN order_delivered_customer_date IS NULL THEN 'no delivery date'
            WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 'late'
            ELSE 'on time'
       END AS delivery_status,
       COUNT(*) AS orders
FROM orders
WHERE order_status = 'delivered'
GROUP BY delivery_status;