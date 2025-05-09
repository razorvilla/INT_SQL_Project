-- Write a query to count how many customers share the same geography (city or region).


SELECT
    city,
    COUNT(*) AS customer_count
FROM
    customer
GROUP BY
    city
ORDER BY
    customer_count DESC