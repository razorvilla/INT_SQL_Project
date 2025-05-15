-- Split a comma-separated ProductCategory column (if exists) into individual rows using SQL.

-- worked using a sample table

CREATE TABLE temp_product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    ProductCategory VARCHAR(255)
);

INSERT INTO temp_product (ProductID, ProductName, ProductCategory) VALUES
(1, 'Widget A', 'Electronics,Home,Office'),
(2, 'Widget B', 'Sports,Outdoor'),
(3, 'Widget C', 'Home');


SELECT *
FROM temp_product

SELECT
    ProductID,
    ProductName,
    TRIM(category) AS ProductCategory
FROM (
    SELECT
        ProductID,
        ProductName,
        UNNEST(STRING_TO_ARRAY(ProductCategory, ',')) AS category
    FROM
        temp_product
) AS split_categories