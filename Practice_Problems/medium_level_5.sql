--  Find products in the Product table that are priced above the average price of their category.

WITH catergory_avg_price AS(
    SELECT
        categoryname,
        AVG(price) AS avg_cat_price
    FROM
        product
    GROUP BY
        categoryname
)

SELECT
    p.productname,
    p.categoryname,
    p.price,
    cap.avg_cat_price
FROM
    product p
LEFT JOIN catergory_avg_price cap ON p.categoryname = cap.categoryname
WHERE
    p.price > cap.avg_cat_price