-- 09_window_functions.sql
-- Olist E-commerce Analysis: window functions
-- Concepts: RANK() OVER, PARTITION BY, ranking inside groups, top 1 per group with a CTE

-- Q: Rank sellers by total revenue (rank 1 = top seller, 229472.63)
WITH seller_sales AS (
    SELECT seller_id,
           SUM(price) AS revenue
    FROM order_items
    GROUP BY seller_id
)
SELECT seller_id,
       revenue,
       RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM seller_sales
LIMIT 10;

-- Q: Rank sellers within each state
WITH seller_sales AS (
    SELECT s.seller_state,
           oi.seller_id,
           SUM(oi.price) AS revenue
    FROM order_items AS oi
    JOIN sellers AS s ON oi.seller_id = s.seller_id
    GROUP BY s.seller_state, oi.seller_id
)
SELECT seller_state,
       seller_id,
       revenue,
       RANK() OVER (PARTITION BY seller_state ORDER BY revenue DESC) AS rank_in_state
FROM seller_sales
ORDER BY seller_state, rank_in_state
LIMIT 15;

-- Q: Who is the top seller in each state? (23 states; SP top seller 229472.63, BA 222776.05)
WITH seller_sales AS (
    SELECT s.seller_state,
           oi.seller_id,
           SUM(oi.price) AS revenue
    FROM order_items AS oi
    JOIN sellers AS s ON oi.seller_id = s.seller_id
    GROUP BY s.seller_state, oi.seller_id
),
ranked AS (
    SELECT seller_state,
           seller_id,
           revenue,
           RANK() OVER (PARTITION BY seller_state ORDER BY revenue DESC) AS rank_in_state
    FROM seller_sales
)
SELECT seller_state,
       seller_id,
       revenue
FROM ranked
WHERE rank_in_state = 1
ORDER BY revenue DESC;