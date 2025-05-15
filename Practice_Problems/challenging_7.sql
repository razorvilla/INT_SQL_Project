-- Write a query to find gaps in SalesOrderNumber sequence in the Sales table.

-- SELECT orderkey
-- FROM sales
-- WHERE
--     orderkey = 1010


WITH ordered_numbers AS (
    SELECT DISTINCT orderkey
    FROM sales
),
numbered_gaps AS (
    SELECT
        orderkey,
        LEAD(orderkey) OVER(ORDER BY orderkey) AS next_order
    FROM
        ordered_numbers
)

SELECT
    orderkey + 1 AS missing_start,
    next_order - 1 AS missing_end
FROM
    numbered_gaps
WHERE
    next_order - orderkey > 1