-- Retrieve products from the Product table that were never sold, using a LEFT JOIN with Sales.

SELECT
    p.productkey,
    p.productname,
    s.orderkey,
    s.orderdate
FROM
    product p
LEFT JOIN
    sales s
ON p.productkey = s.productkey
WHERE
    s.orderkey IS NULL

