-- 10_monthly_trend.sql
-- Olist E-commerce Analysis: monthly revenue trend
-- Concepts: strftime, LAG() OVER, window functions on time series

-- Q: Monthly revenue of delivered orders, with the previous month beside it
-- Notes: 2016 months are tiny and 2016-11 has no rows, so LAG compares 2016-12 with 2016-10.
--        Peak month: 2017-11 (987765, about +52% on October, Black Friday).
--        Spring 2018 is a sustained high level (about 950k-980k a month).
WITH monthly AS (
    SELECT strftime('%Y-%m', o.order_purchase_timestamp) AS month,
           ROUND(SUM(oi.price), 0) AS revenue
    FROM orders AS o
    JOIN order_items AS oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY month
)
SELECT month,
       revenue,
       LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue
FROM monthly
ORDER BY month;