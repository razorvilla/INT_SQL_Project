-- Retrieve customers who made purchases across at least three different product categories.

WITH sales_with_products AS(
    SELECT *
    FROM
        sales s
    LEFT JOIN product p ON s.productkey = p.productkey
)

SELECT
    customerkey,
    COUNT(DISTINCT categorykey) AS unique_categories
FROM sales_with_products
GROUP BY
    customerkey
HAVING
    COUNT(DISTINCT categorykey) >= 3
ORDER BY
    customerkey

