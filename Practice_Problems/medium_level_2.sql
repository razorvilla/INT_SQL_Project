-- 2️⃣ Fetch all customer names from the Customer table that contain the letter “a” exactly twice.

SELECT *
FROM
    customer;

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'customer';

WITH customer_name_table AS(
    SELECT
        givenname || ' ' || surname AS customer_name
    FROM
        customer
)

SELECT
    customer_name,
    LENGTH(customer_name) - LENGTH(REPLACE(LOWER(customer_name), 'a', '')) AS a_count
FROM
    customer_name_table
WHERE
    LENGTH(customer_name) - LENGTH(REPLACE(LOWER(customer_name), 'a', '')) = 2

