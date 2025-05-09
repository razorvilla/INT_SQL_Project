-- How do you fetch the top 3 selling products by total revenue in each state from the Sales and Customer tables?

WITH product_revenue_by_state AS(
    SELECT
        productkey,
        state,
        SUM(quantity*netprice*exchangerate) AS total_revenue
    FROM sales s
    LEFT JOIN customer c ON s.customerkey = c.customerkey
    GROUP BY
        state,
        productkey
    
),
ranked_products AS (
    SELECT
        productkey,
        state,
        total_revenue,
        RANK() OVER (PARTITION BY state ORDER BY total_revenue DESC) AS rank
    FROM
        product_revenue_by_state
)

SELECT *
FROM
    ranked_products
WHERE
    rank <= 3
ORDER BY
    state, rank