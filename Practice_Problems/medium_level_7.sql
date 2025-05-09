-- Fetch all sales transactions where the SalesDate is within the last 7 days.

SELECT *
FROM sales
WHERE
    orderdate >= CURRENT_DATE - INTERVAL '7 days';