-- This script checks for NULL values across all tables in the database to assess data quality.

-- Check for nulls in the 'sales' table
SELECT
    COUNT(*) FILTER (WHERE sale_id IS NULL) AS sale_id_null,
    COUNT(*) FILTER (WHERE sale_date IS NULL) AS sale_date_null,
    COUNT(*) FILTER (WHERE store_id IS NULL) AS store_id_null,
    COUNT(*) FILTER (WHERE product_id IS NULL) AS product_id_null,
    COUNT(*) FILTER (WHERE quantity IS NULL) AS quantity_null
FROM
    sales;

-- Check for nulls in the 'product' table
SELECT
    COUNT(*) FILTER (WHERE product_id IS NULL) AS product_id_null,
    COUNT(*) FILTER (WHERE product_name IS NULL) AS product_name_null,
    COUNT(*) FILTER (WHERE category_id IS NULL) AS category_id_null,
    COUNT(*) FILTER (WHERE launch_date IS NULL) AS launch_date_null,
    COUNT(*) FILTER (WHERE price IS NULL) AS price_null
FROM
    product;

-- Check for nulls in the 'category' table
SELECT
    COUNT(*) FILTER (WHERE category_id IS NULL) AS category_id_null,
    COUNT(*) FILTER (WHERE category_name IS NULL) AS category_name_null
FROM
    category;

-- Check for nulls in the 'stores' table
SELECT
    COUNT(*) FILTER (WHERE store_id IS NULL) AS store_id_null,
    COUNT(*) FILTER (WHERE store_name IS NULL) AS store_name_null,
    COUNT(*) FILTER (WHERE city IS NULL) AS city_null,
    COUNT(*) FILTER (WHERE country IS NULL) AS country_null
FROM
    stores;

-- Check for nulls in the 'warranty' table
SELECT
    COUNT(*) FILTER (WHERE claim_id IS NULL) AS claim_id_null,
    COUNT(*) FILTER (WHERE claim_date IS NULL) AS claim_date_null,
    COUNT(*) FILTER (WHERE sale_id IS NULL) AS sale_id_null,
    COUNT(*) FILTER (WHERE repair_status IS NULL) AS repair_status_null
FROM
    warranty;

-- Conclusion: The data integrity check reveals that only the `sales` table contains missing data.
-- Specifically, the `sale_date` and `quantity` columns each have 8,375 null values.
-- These records will need to be handled (e.g., excluded from calculations or imputed) during analysis.
-- All other tables are complete with no missing values.