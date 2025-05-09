-- title: sales copy table
WITH sales_copy AS (
	SELECT
		*
	FROM
		SALES
	LIMIT 10
)
SELECT
	*
FROM
	sales_copy;

-- title: customer count
SELECT 
	COUNT(*)
FROM customer c 