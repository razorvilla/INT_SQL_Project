-- Fetch all customers who made purchases on two or more consecutive days, using the Sales table.
WITH customer_sales_dates AS(
    SELECT
        customerkey,
        DATE(orderdate) AS sales_date
    FROM
        sales
    GROUP BY
        customerkey,
        DATE(orderdate)
),
sales_with_grouping AS(
    SELECT
        customerkey,
        sales_date,
        ROW_NUMBER() OVER(PARTITION BY customerkey ORDER BY sales_date) AS row_number
    FROM
        customer_sales_dates
),
grouped_sales AS (
    SELECT
        customerkey,
        sales_date,
        sales_date - row_number * INTERVAL '1 day' AS date_group
    FROM
        sales_with_grouping
),
streaks AS (
    SELECT
        customerkey,
        COUNT(*) AS consecutive_days
    FROM
        grouped_sales
    GROUP BY
        customerkey,
        date_group
    HAVING
        COUNT(*) >= 2
)

SELECT DISTINCT
    c.customerkey,
    c.givenname || ' ' || c.surname AS fullname
FROM
    streaks s
LEFT JOIN customer c ON s.customerkey = c.customerkey