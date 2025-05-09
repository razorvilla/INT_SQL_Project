-- 1️⃣ Write a query to find the second highest sales amount from the Sales table.

SELECT *
FROM
    sales

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'sales';

SELECT
    quantity * netprice * exchangerate AS total_revenue
FROM sales
ORDER BY
    total_revenue DESC
OFFSET 1
LIMIT 1
