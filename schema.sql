-- Drop tables in reverse order of dependency to avoid foreign key errors
DROP TABLE IF EXISTS warranty;
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS stores;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS category;

-- Create the category table to store product category information
CREATE TABLE category (
    category_id VARCHAR(10) PRIMARY KEY,
    category_name VARCHAR(50)
);

-- Create the product table to store product details
CREATE TABLE product (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(50),
    category_id VARCHAR(10),
    launch_date DATE,
    price INT
);

-- Create the sales table to log transaction data
CREATE TABLE sales (
    sale_id VARCHAR(50),
    sale_date DATE,
    store_id VARCHAR(50),
    product_id VARCHAR(10),
    quantity INT
);

-- Create the stores table to store information about retail locations
CREATE TABLE stores (
    store_id VARCHAR(50) PRIMARY KEY,
    store_name VARCHAR(50),
    city VARCHAR(50),
    country VARCHAR(50)
);

-- Create the warranty table to track product repair claims
CREATE TABLE warranty (
    claim_id VARCHAR(50) PRIMARY KEY,
    claim_date DATE,
    sale_id VARCHAR(50),
    repair_status VARCHAR(50)
);