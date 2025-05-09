-- Retrieve customers who made their first purchase in the last 6 months, using the Sales and Customer tables.

SELECT *
FROM sales

WITH sales_and_customer AS(

    SELECT *,
        MIN(s.orderdate) OVER(PARTITION BY s.customerkey) AS first_purchase_date
    FROM
        sales s
    LEFT JOIN customer c ON s.customerkey = c.customerkey
)

SELECT
    givenname || ' ' || surname AS cusotmer_full_name,
    first_purchase_date
FROM sales_and_customer
WHERE
    first_purchase_date >= CURRENT_DATE - INTERVAL '6 months'
ORDER BY
    first_purchase_date