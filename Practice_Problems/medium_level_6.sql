-- Write a query to find the most frequently purchased product from the Sales table.

SELECT
    productkey,
    COUNT(*) AS total_orders
FROM sales
GROUP BY
    productkey
ORDER BY
    total_orders DESC
LIMIT 1
