-- Find the median sales revenue per customer from the Sales and Customer tables.

WITH order_and_customer_details AS(
    SELECT
        c.customerkey,
        s.quantity*s.netprice*s.exchangerate AS total_revenue
    FROM customer c
    LEFT JOIN sales s ON c.customerkey = s.customerkey
),
median_revenue AS(
    SELECT
        customerkey,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY COALESCE(total_revenue, 0)) AS median_revenue
    FROM
        order_and_customer_details
    GROUP BY
        customerkey
    ORDER BY
        customerkey
)

SELECT
    c.customerkey,
    c.givenname || ' ' || c.surname AS fullname,
    m.median_revenue
FROM
    customer c
LEFT JOIN median_revenue m ON c.customerkey = m.customerkey
WHERE median_revenue != 0

