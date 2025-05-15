-- Rank products by total sales amount in descending order for each region, using Sales and Geography.

WITH sales_and_region AS (
    SELECT
        s.productkey,
        c.countryfull,
        s.quantity*s.netprice*s.exchangerate as total_revenue
    FROM
        sales s
    LEFT JOIN customer c ON s.customerkey = c.customerkey
),
product_sales AS (
    SELECT
        SUM(total_revenue) AS product_revenue,
        productkey,
        countryfull
    FROM
        sales_and_region
    GROUP BY
        productkey,
        countryfull
)

SELECT
    productkey,
    countryfull,
    product_revenue,
    DENSE_RANK() OVER(PARTITION BY countryfull ORDER BY product_revenue DESC) AS product_rank
FROM product_sales