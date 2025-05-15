-- Write a query to delete duplicate rows from the Sales table, keeping only one.

-- creating backup of the duplicate rows
-- CREATE TABLE deleted_sales_backup AS

WITH ranked_sales AS (
    SELECT *,
        ctid,
        ROW_NUMBER() OVER(
            PARTITION BY customerkey, storekey, productkey
            ORDER BY orderkey
        ) as rn
    FROM sales
)
DELETE FROM sales
WHERE ctid IN (

    SELECT ctid
    FROM ranked_sales
    WHERE rn > 1
)
    
-- VERIFY DELETED ROWS
SELECT COUNT(*)
FROM sales