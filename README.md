# Apple Retail Sales & Product Lifecycle Analysis

## Project Overview

This project provides a comprehensive analysis of Apple's retail sales, product performance, and warranty claim data. The primary objective is to dissect sales patterns, identify top-performing products and categories, and evaluate the product lifecycle from launch to peak sales. By joining data from sales, products, stores, and warranties, this analysis uncovers actionable insights into customer behavior, product quality, and regional performance, culminating in a set of data-driven strategic recommendations for the business.

---

## 📂 Dataset

The analysis is based on the "Apple Retail Sales Dataset" publicly available on Kaggle. The dataset is relational and split into five distinct CSV files, which were structured into a PostgreSQL database for analysis.

-   **Dataset Source:** [Apple Retail Sales Dataset on Kaggle](https://www.kaggle.com/datasets/amangarg08/apple-retail-sales-dataset?select=sales.csv)
-   **Tables Used:**
    -   `sales`: Transactional data including sale ID, date, store, product, and quantity.
    -   `product`: Detailed product information, including name, category, launch date, and price.
    -   `category`: A lookup table for product category names.
    -   `stores`: Information on retail store locations, including city and country.
    -   `warranty`: Data on warranty claims, including claim date and repair status.

---

## 🎯 Business Objectives

The analysis was guided by a set of key business questions aimed at understanding different facets of the business:

#### 1. **Sales & Revenue Performance**
-   Which products and categories generate the highest revenue and sales volume?
-   What are the top-performing product categories?
-   What are the monthly, quarterly, and yearly sales trends?

#### 2. **Geographical Performance**
-   Which stores, cities, and countries drive the most sales?
-   How do product preferences differ between top-performing countries?

#### 3. **Product Lifecycle & Adoption**
-   Are newly launched products adopted faster than older models?
-   How long, on average, does it take for a product to reach its peak sales after launch?
-   Do new product launches correlate with overall revenue spikes?

#### 4. **Warranty & Quality Analysis**
-   What percentage of total sales result in a warranty claim?
-   Which products or categories have the highest failure/repair rates?
-   What are the most common outcomes for warranty claims (e.g., Repaired, Rejected)?

---

## 🛠️ Tech Stack & Workflow

-   **Database:** PostgreSQL
-   **SQL Editor:** Dbeaver
-   **Language:** SQL
-   **Workflow:**
    1.  **Schema Design (`schema.sql`):** Defined the relational database structure by creating five tables (`category`, `product`, `sales`, `stores`, `warranty`).
    2.  **Data Cleaning (`data_cleaning.sql`):** Performed data integrity checks, identifying significant `NULL` values in the `sales` table's `sale_date` and `quantity` columns. This was a critical finding that impacted the accuracy of trend analysis.
    3.  **In-Depth Analysis (`analysis.sql`):** Executed a series of complex SQL queries using `JOINs`, `CTEs`, and aggregate functions to answer the defined business objectives.

---

## 📊 Key Analytical Findings

-   **Top Performers:** "Apple Music" is the highest revenue-generating product ($125M), while "Accessories" is the highest-volume sales category (163k units).
-   **Geographical Dominance:** The **United States** is the top-performing country with **207k sales**, significantly outpacing Australia (97k).
-   **Time to Peak Sales:** On average, an Apple product takes approximately **364 days** (nearly one year) to reach its peak sales volume, highlighting a long and sustainable product lifecycle.
-   **Warranty Claim Rate:** A relatively low **2.8%** of sales result in a warranty claim, indicating strong overall product reliability.
-   **Product Adoption:** New product adoption is not guaranteed; it is strongly correlated with **perceived innovation**. For example, the innovative leap from iPhone 12 to 13 drove higher sales, while more iterative updates did not produce the same impact.
-   **Data Quality Issues:** A major finding was the **8,375 rows with missing `sale_date` or `quantity`**, which severely limits the reliability of any time-series or trend analysis.

---

## 📝 Summary & Strategic Recommendations

This analysis reveals that Apple's market strength is driven by a loyal customer base, a long product lifecycle, and a high-volume accessories business. While overall product reliability is strong, certain premium products like the "MacBook Pro (Touch Bar)" show higher-than-average claim rates, warranting further investigation. The most significant limitation to this analysis is the poor quality of the sales data, which prevents accurate forecasting and trend identification.

Based on the findings, the following strategic recommendations are proposed:

> ### **1. Double Down on iPhone Innovation**
> The data confirms that sales growth for new iPhones is directly tied to meaningful innovation. Apple should continue to invest heavily in developing significant new features for its flagship product line, as this is a proven driver of both sales volume and brand value.

> ### **2. Implement Strategic Accessory Bundling**
> Accessories are the highest-volume sales category and are essential for the Apple ecosystem. It is highly recommended to create strategic product bundles (e.g., a new iPhone with a MagSafe charger) to increase the average revenue per sale and secure future high-margin accessory purchases.

> ### **3. Enhance Service Training in High-Claim Stores**
> Stores with a disproportionately high number of warranty claims should be targeted for enhanced service training and stricter pre-sale quality checks. This proactive approach can help reduce claim rates, improve customer satisfaction, and lower service costs.

> ### **4. Prioritize Data Integrity and Governance**
> The most critical recommendation is to address the severe data quality issues in the sales transaction data. Accurate, complete data is the foundation of any reliable business intelligence, and fixing this issue is essential for future forecasting, trend analysis, and strategic planning.
