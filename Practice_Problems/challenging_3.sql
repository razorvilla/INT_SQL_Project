-- Write a query to calculate the percentage change in total sales month-over-month from the Sales table.
WITH monthly_sales AS(
    SELECT
        DATE_TRUNC('month', orderdate) AS month,
        SUM(quantity * netprice * exchangerate) AS total_sales
    FROM
        sales
    GROUP BY
        DATE_TRUNC('month', orderdate)
    ORDER BY
        month
),
sales_with_change AS ( 
    SELECT
        month,
        total_sales,
        LAG(total_sales, 1, 0) OVER(ORDER BY month) AS previous_month_sales
    FROM
        monthly_sales
)

SELECT
    month,
    total_sales,
    previous_month_sales,
    ROUND(
        (100.0 * (total_sales - previous_month_sales)/ NULLIF(previous_month_sales, 0))::numeric, 2
    ) AS percent_change
FROM
    sales_with_change