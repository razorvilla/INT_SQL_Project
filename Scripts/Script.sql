CREATE VIEW daily_revenue AS
	SELECT
		orderdate,
		SUM(quantity * netprice * exchangerate) AS total_revenue
FROM
		sales
GROUP BY
		orderdate;

SELECT
	*
FROM
	daily_revenue
	
DROP VIEW daily_revenue