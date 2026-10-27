\# Olist E-commerce Performance Analysis



An analysis of \~96,000 delivered orders from the Brazilian e-commerce marketplace Olist. I used \*\*SQL (SQLite)\*\* to clean and explore the data, then built a two-page \*\*Power BI\*\* dashboard with DAX measures.



\## Business questions

\- Which product categories and states drive revenue?

\- How does revenue change month to month?

\- How many customers come back to buy again?

\- How often are deliveries late, and does it affect customer reviews?



\## Dashboard



\*\*Overview\*\*

!\[Overview page](images/overview.png)



\*\*Delivery\*\*

!\[Delivery page](images/delivery.png)



\## Key findings

\- \*\*Revenue:\*\* 13.22M BRL across 96,478 delivered orders, with an average order value of 137.04 BRL.

\- \*\*Growth and seasonality:\*\* monthly revenue grew through 2017 and peaked in \*\*November 2017\*\* (about 1M BRL), then levelled off in 2018.

\- \*\*Geography:\*\* São Paulo (SP) earns 5.07M BRL, far more than RJ (1.76M) or MG (1.55M). SP wins on order volume, not order size: its average order value (125.12) is lower than in RJ, BA and SC.

\- \*\*Customer loyalty:\*\* only \*\*3.0%\*\* of customers (2,801 of 93,358) placed more than one order.

\- \*\*Delivery and reviews:\*\* 91.9% of orders arrived on time. Late orders averaged \*\*2.57 stars\*\* against \*\*4.29\*\* for on-time orders.

\- \*\*Delivery performance fell over time:\*\* on-time delivery was 93.4% in 2017 and 90.6% in 2018 (January to August).

\- \*\*Regional gaps:\*\* the lowest on-time rates were in north-eastern states, led by AL (about 76%), MA (about 80%) and PI (about 84%).



\## Recommendations

1\. Investigate delivery performance in the north-eastern states, where late deliveries are most common. Late orders score about 1.7 stars lower.

2\. Look at why delivery performance fell in 2018 while order volume grew.

3\. With only 3% repeat customers, test retention actions such as follow-up offers after a first purchase.



\## How it was built

1\. Loaded the 9 Olist CSV files into SQLite (DB Browser).

2\. Wrote SQL scripts (see `/Sql`): joins, aggregation, CASE WHEN, subqueries, CTEs, window functions and data-quality checks.

3\. Built one order-level table in SQL (one row per delivered order) and exported it to CSV.

4\. In Power BI: created a date table and a relationship, wrote DAX measures (Total Revenue, Total Orders, Avg Order Value, On-Time Delivery %, Avg Review Score) and built the report pages.



\## Data notes and limitations

\- Currency is Brazilian reals (BRL). Revenue is item price and excludes freight.

\- The dashboard covers \*\*delivered orders only\*\* (96,478 orders).

\- 775 orders had no items and were excluded. 8 delivered orders had no delivery date and are excluded from the on-time rate.

\- Some orders have more than one review, so reviews are averaged per order.

\- Data runs to August 2018, so the last months may be incomplete, and 2016 volume is very small.

\- Late delivery and low reviews are linked, but this analysis does not prove that late delivery causes them.



\## Tools

SQL (SQLite), DB Browser for SQLite, Power BI Desktop, DAX, Git and GitHub.



\## Dataset

\[Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) (Kaggle). The raw CSV files and database are not included in this repository.

