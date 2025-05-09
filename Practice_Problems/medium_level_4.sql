-- Write a query to calculate the running total of sales amount by date from the Sales table.

WITH daily_sales AS (
    SELECT
        orderdate,
        SUM(quantity*netprice*exchangerate) AS total_revenue
    FROM
        sales
    GROUP BY
        orderdate
    ORDER BY
        orderdate
)

SELECT
    orderdate,
    total_revenue,
    SUM(total_revenue) OVER(ORDER BY orderdate) AS running_total
FROM
    daily_sales

