-- Fetch all products whose total sales amount falls within the top 10% of their respective product categories.

WITH product_wise_revenue AS(
    SELECT
        SUM(s.quantity*s.netprice*s.exchangerate) AS total_product_revenue,
        p.productkey,
        p.categorykey
    FROM
        sales s
    LEFT JOIN product p ON s.productkey = p.productkey
    GROUP BY
        p.categorykey,
        p.productkey
    ORDER BY
        p.categorykey
),
ranked_products AS(
    SELECT
        *,
        DENSE_RANK() OVER(PARTITION BY categorykey ORDER BY total_product_revenue DESC) AS rk,
        COUNT(*) OVER(PARTITION BY categorykey) AS total_products
    FROM product_wise_revenue
)

SELECT
    productkey,
    total_product_revenue,
    categorykey,
    rk
FROM
    ranked_products
WHERE
    rk <= CEIL(total_products*.1)

