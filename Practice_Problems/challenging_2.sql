-- How do you pivot the Sales table to convert regions into columns with total sales as values?

SELECT
    s.productkey,
    SUM(quantity * netprice * exchangerate) FILTER (WHERE c.state = 'CA') AS ca_sales,
    SUM(quantity * netprice * exchangerate) FILTER (WHERE c.state = 'NY') AS ny_sales,
    SUM(quantity * netprice * exchangerate) FILTER (WHERE c.state = 'TX') AS tx_sales,
    SUM(quantity * netprice * exchangerate) FILTER (WHERE c.state = 'WA') AS wa_sales
FROM
    sales s
JOIN
    customer c ON s.customerkey = c.customerkey
GROUP BY
    s.productkey
ORDER BY
    s.productkey;