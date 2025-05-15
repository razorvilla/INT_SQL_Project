-- Write a query to get the count of customers active on both weekdays and weekends, using the Sales and Date tables.

WITH sales_with_day_type AS(
    SELECT
        s.customerkey,
        CASE
            WHEN d.dayofweek IN ('Saturday', 'Sunday') THEN 'weekend'
            ELSE 'weekday'
        END AS day_type
    FROM
        sales s
    LEFT JOIN date d ON s.orderdate = d.date
),
customer_activity AS(
    SELECT
        customerkey,
        COUNT(DISTINCT day_type) AS day_type_count
    FROM
        sales_with_day_type
    GROUP BY
        customerkey
)

SELECT
    COUNT(*) AS customer_active_all_week
FROM
    customer_activity
WHERE
    day_type_count = 2