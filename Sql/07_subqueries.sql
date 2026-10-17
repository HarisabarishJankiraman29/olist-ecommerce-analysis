-- 07_subqueries.sql
-- Olist E-commerce Analysis: subqueries
-- Concepts: scalar subquery, IN / NOT IN, subquery in FROM

-- Q: Which items cost more than the average price?
SELECT order_id, price
FROM order_items
WHERE price > (SELECT AVG(price) FROM order_items)
ORDER BY price DESC
LIMIT 10;

-- Q: How many items cost more than the average? (32128 of 112650, about 28.5%: the average is pulled up by a few expensive items)
SELECT COUNT(*)
FROM order_items
WHERE price > (SELECT AVG(price) FROM order_items);

-- Q: How many orders received at least one 1-star review? (11393)
SELECT COUNT(*)
FROM orders
WHERE order_id IN (SELECT order_id
                   FROM order_reviews
                   WHERE review_score = 1);

-- Q: How many orders have no review at all? (768 = 99441 - 98673)
SELECT COUNT(*)
FROM orders
WHERE order_id NOT IN (SELECT order_id FROM order_reviews);