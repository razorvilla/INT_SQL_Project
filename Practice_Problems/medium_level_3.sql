-- How do you retrieve only duplicate product names from the Product table?

SELECT *
FROM product

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'product';

SELECT
    productname,
    COUNT(*)
FROM
    product
GROUP BY
    productname
HAVING
    COUNT(*) > 1
