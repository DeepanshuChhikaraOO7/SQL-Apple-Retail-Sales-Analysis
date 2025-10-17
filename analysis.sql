/*
Business Question 1: Which products generate the highest revenue and sales volume?
*/
SELECT
    p.product_name,
    SUM(COALESCE(s.quantity, 0)) AS sales_volume,
    SUM(COALESCE(s.quantity, 0) * p.price) AS revenue
FROM
    sales AS s
JOIN
    product AS p ON s.product_id = p.product_id
GROUP BY
    p.product_name
ORDER BY
    revenue DESC
LIMIT 10;
-- Conclusion: "Apple Music" is the top revenue-generating product with $125,453,460, driven by a sales volume of 63,844 units. It is followed closely by the 
-- "iMac 27-inch" at $124,006,372 in revenue. Notably, all top 10 products exhibit a remarkably stable and balanced sales volume, consistently falling within the 63k 
-- to 65k unit range.
--   | Product Name              | Sales Volume  |    Revenue ($)   |
--   |---------------------------|---------------|------------------|
--   | Apple Music               | 63,844        | 125,453,460      |
--   | iMac 27-inch              | 64,654        | 124,006,372      |
--   | iPad mini (5th Generation)| 64,828        | 123,951,136      |
--   | iPad (9th Generation)     | 63,597        | 123,950,553      |
--   | Beats Fit Pro             | 64,410        | 118,449,990      |
--   | MacBook Air (Retina)      | 63,947        | 118,110,109      |
--   | AirPods (3rd Generation)  | 64,102        | 118,075,884      |
--   | iPad Pro (M2)             | 63,543        | 116,029,518      |
--   | iPad Pro 11-inch          | 64,768        | 114,056,448      |
--   | MacBook Air (M1)          | 63,491        | 113,204,453      |


/*
Business Question 2: What are the top-performing categories?
*/
SELECT
    c.category_name,
    COUNT(COALESCE(s.quantity, 0)) AS total_sales
FROM
    sales AS s
JOIN
    product AS p ON s.product_id = p.product_id
JOIN
    category AS c ON p.category_id = c.category_id
GROUP BY
    c.category_name
ORDER BY
    total_sales DESC;
-- Conclusion: The analysis reveals that the top three performing categories by sales volume are Accessories (163k), Smartphones (151k), and Audio (128k). The 
-- high volume in Accessories is likely correlated with Apple's strategy of unbundling items like chargers from iPhone boxes, effectively converting them into separate 
-- purchases.
--	 | Category Name          | Total Sales |
--   |------------------------|-------------|
--   | Accessories            |   163,849   |
--   | Smartphone             |   151,636   |
--   | Audio                  |   128,731   |
--   | Tablet                 |   117,142   |
--   | Desktop                |   116,812   |
--   | Laptop                 |   116,369   |
--   | Wearable               |   105,521   |
--   | Subscription Service   |    81,561   |
--   | Streaming Device       |    35,014   |
--   | Smart Speaker          |    23,565   |


/*
Business Question 3: Store-level performance ranking — Which city/country drives the most sales?
*/
-- By Store
SELECT
    st.store_name,
    st.country,
    COUNT(COALESCE(s.quantity, 0)) AS total_sales
FROM
    sales AS s
JOIN
    stores AS st ON s.store_id = st.store_id
GROUP BY
    st.store_name,
    st.country
ORDER BY
    total_sales DESC;

-- By Conutry
select
	c.category_name,
	count(coalesce(s.quantity, 0)) as total_sales
from 
	sales as s
join 
	stores as st on s.store_id = st.store_id
join 
	product as p on s.product_id = p.product_id
join 
	category as c on p.category_id = c.category_id 
where 
	st.country = 'Australia'
group by 
	c.category_name
order by 
	total_sales desc;
-- Conclusion: At the individual store level, "Apple Chadstone" in Australia is the top performer with 27,851 sales. However, a country-level analysis tells a 
-- different story: the United States is the dominant market with 207k total sales, followed by Australia at 97k. In both countries, Accessories are the top-selling 
-- category by volume, which is likely driven by the high volume of Smartphone sales.


/*
Business Question 4: Are newly launched products adopted faster than older ones?
*/
select
	c.category_name,
	p.product_name,
	p.launch_date,
	sum(coalesce(s.quantity, 0)) as total_sales
from 
	sales as s
join 
	product as p on s.product_id = p.product_id
join 
	category as c on p.category_id = c.category_id
group by 
	c.category_name, p.product_name, p.launch_date
having 
	c.category_name = 'Wearable'
order by 
c.category_name;
-- (Analysis is broken down by category below for clarity)
-- Conclusion - Smartphones: Yes, adoption for newly launched models is generally faster, but it is heavily dependent on innovation. For example, the leap from iPhone 12 to 
-- 13 saw a significant sales increase, while the iPhone 14 Pro Max saw a slight dip. The base and Pro models show a consistent upward trend when new features are compelling.
-- Conclusion - Audio: Yes, newly launched Audio products are adopted faster. This category consistently features innovation with each new product, such as the AirPods Pro 
-- (2nd Generation) slightly outselling its predecessor, indicating that new technology drives adoption.

-- Conclusion - Desktop: No, this category does not show a clear pattern of faster adoption for new products. Sales figures for new iMac and Mac Mini models fluctuate, 
-- and often drop compared to previous launches, suggesting that desktop purchases are more value-driven than hype-driven.

-- Conclusion - Smart Speaker & Streaming Device: The data is insufficient for a definitive conclusion, but the available information suggests that sales for new 
-- products in these categories are declining.

-- Conclusion - Accessories: Adoption in the Accessories category is stable and consistent, with sales figures hovering between 63k and 65k for nearly all products, 
-- regardless of launch date. Sales appear to be driven by practical utility rather than newness.

-- Conclusion - Tablet: This category shows mixed results. Minor performance upgrades, like the M2 iPad Pro, did not drive higher sales than the previous M1 model. 
-- Adoption only accelerates when the perceived innovation is significant.

-- Conclusion - Subscription Service: Adoption is driven by utility and bundling, not launch recency. While new services show moderate improvement, established offerings 
-- like Apple Music and Apple One remain consistently strong.

-- Conclusion - Laptop: Adoption is value-based. Newer MacBook Air models show stable but not significantly higher sales than older ones. Only premium flagship models, 
-- like the MacBook Pro 16-inch, demonstrate a strong sales impact upon launch.

-- Conclusion - Wearable: Adoption is loyalty-driven and benefits from premium marketing. Newer Apple Watch models are adopted quickly, but older premium editions 
-- like the Hermès and Nike versions retain strong sales, indicating that design and status are key drivers.


/*
Business Question 5: How long after launch date does a product reach peak sales?
*/
WITH peak_sales_date AS (
    SELECT
        sp.product_name,
        sp.launch_date,
        (sp.sale_date - sp.launch_date) AS peak_sale_day
    FROM
        sales AS s
    JOIN
        product AS p ON s.product_id = p.product_id
    CROSS JOIN LATERAL (
        SELECT sale_date, SUM(COALESCE(quantity, 0)) as daily_sales
        FROM sales
        WHERE product_id = p.product_id AND sale_date IS NOT NULL
        GROUP BY sale_date
        ORDER BY daily_sales DESC
        LIMIT 1
    ) AS sp
)
SELECT
    ROUND(AVG(peak_sale_day), 2) AS avg_time_to_peak_sales_days
FROM
    peak_sales_date;
-- Conclusion: On average, Apple products take approximately 364.46 days (about one year) to reach their peak sales volume after launch. This indicates a long 
-- product lifecycle and sustained demand, likely driven by brand loyalty, seasonal buying cycles, and gradual market adoption.


/*
Business Question 6: What percentage of sales result in a warranty claim?
*/
SELECT
    ROUND((SELECT COUNT(*) FROM warranty)::NUMERIC / (SELECT COUNT(*) FROM sales WHERE sale_id IS NOT NULL)::NUMERIC * 100, 2) AS warranty_claim_percentage;
-- Conclusion: Approximately 2.8% of all sales result in a warranty claim.


/*
Business Question 7: Which products/categories have the highest repair or failure rates?
*/
WITH products_categories_claims AS (
    SELECT
        p.product_name,
        c.category_name,
        COUNT(w.claim_id) AS total_claims
    FROM
        sales AS s
    JOIN
        warranty AS w ON s.sale_id = w.sale_id
    JOIN
        product AS p ON s.product_id = p.product_id
    JOIN
        category AS c ON p.category_id = c.category_id
    WHERE
        w.repair_status = 'Rejected' -- This CTE specifically calculates rejected claims
    GROUP BY
        p.product_name,
        c.category_name
),
total_sales_per_product AS (
    SELECT
        p.product_name,
        c.category_name,
        COUNT(s.sale_id) AS total_sales
    FROM
        sales AS s
    JOIN
        product AS p ON s.product_id = p.product_id
    JOIN
        category AS c ON p.category_id = c.category_id
    GROUP BY
        p.product_name,
        c.category_name
)
SELECT
    pcc.product_name,
    pcc.category_name,
    pcc.total_claims,
    tspp.total_sales,
    ROUND((pcc.total_claims::NUMERIC / tspp.total_sales::NUMERIC) * 100, 2) AS claim_rate
FROM
    products_categories_claims AS pcc
JOIN
    total_sales_per_product AS tspp ON pcc.product_name = tspp.product_name
GROUP BY
    pcc.product_name,
    pcc.category_name,
    pcc.total_claims,
    tspp.total_sales
ORDER BY
    claim_rate DESC;
-- Conclusion: The "MacBook Pro (Touch Bar)" has recorded the highest claim rate, indicating that a significant portion of its sold units required warranty 
-- attention. This could suggest potential quality issues, high customer expectations, or common usage-related damages in this category. On the other hand, 
-- the "iPhone 13 Pro Max" has the highest rejection rate for its warranty claims. This may point to stricter warranty policies for this product, a higher 
-- incidence of user-induced damages not covered by warranty, or a misunderstanding of warranty terms by customers. Overall, these insights highlight the 
-- importance of monitoring product quality and evaluating warranty policies, especially for premium product lines, to maintain customer satisfaction and 
-- manage post-sale service costs.


/*
Business Question 8: What are the most common repair_status outcomes?
*/
SELECT
    repair_status,
    COUNT(repair_status) AS total_appearance
FROM
    warranty
GROUP BY
    repair_status
ORDER BY
    total_appearance DESC;
-- Conclusion: The most frequent repair status for warranty claims is "In Progress" with 7,611 instances, followed closely by "Pending" with 7,566. 
-- These two statuses combined account for a significant portion of all claims, suggesting a potential bottleneck or lengthy processing times in the warranty 
-- service pipeline.
--	 | Repair Status  | Total Appearance |
--   |----------------|------------------|
--   | In Progress    |      7,611       |
--   | Pending        |      7,566       |
--   | Completed      |      7,466       |
--   | Rejected       |      7,357       |


/*
Business Question 9: Identify monthly/quarterly sales trends.
*/
-- Conclusion on Data Quality: A definitive trend analysis is not feasible due to significant data quality issues.
--   - Missing Data: 8,375 rows in the sales table are missing either a `sale_date` or `quantity`.
--   - Incomplete Monthly Data: Several months only contain records for the first 12 days, making monthly comparisons unreliable.
--   - Future Data Anomaly: Sales records exist for the year 2026, which distorts long-term trend analysis.
-- Due to these limitations, any observed yearly, quarterly, or monthly patterns would be inaccurate.


/*
Business Question 10: Do new product launches drive overall revenue spikes?
*/
-- Conclusion: New product launches do not guarantee a revenue spike. While some launches, like the iPhone 13, correspond with a rise in revenue, others, like the 
-- iPhone 14, do not show the same impact. Revenue spikes are more likely influenced by the perceived level of innovation, market timing, and brand loyalty rather 
-- than the launch event alone.


/*
Business Question 11: What days or months have the highest claims volume?
*/
SELECT
    EXTRACT(MONTH FROM claim_date) AS claim_month,
    COUNT(claim_id) AS monthly_claims
FROM
    warranty
GROUP BY
    claim_month
ORDER BY
    monthly_claims DESC;
-- Conclusion: Analysis of claim dates shows that August is the month with the highest volume of warranty claims (3,001). At a more granular level, the 8th day of 
-- the month consistently has the highest number of claims filed (1,067).


/*
Business Question 12: Which product line should Apple invest more in based on sales vs. warranty risk?
*/
-- Conclusion: It is recommended that Apple continue to invest heavily in the **iPhone** product line. The iPhone is the cornerstone of the brand's value, and 
-- the data shows that sales volume increases significantly when new models feature meaningful innovation. Furthermore, the warranty claim rate for iPhones is 
-- relatively low, making it a high-reward, moderate-risk category for continued investment.


/*
Business Question 13: Should stores with high warranty claims receive better service training?
*/
SELECT
    st.store_name,
    COUNT(w.claim_id) AS total_claims
FROM
    sales AS s
JOIN
    warranty AS w ON s.sale_id = s.sale_id
JOIN
    stores AS st ON s.store_id = st.store_id
GROUP BY
    st.store_name
ORDER BY
    total_claims DESC;
-- Conclusion: Yes, absolutely. Stores that exhibit a disproportionately high volume of warranty claims should be prioritized for enhanced service training and 
-- potentially stricter pre-sale quality checks to proactively address issues and reduce claim rates.


/*
Business Question 14: Would you recommend bundling accessories with high-selling categories?
*/
-- Conclusion: Yes, bundling accessories is a highly recommended strategy. Accessories are essential for the functionality of high-selling products like iPhones and 
-- Desktops. By creating strategic bundles or even innovating new proprietary accessories (where regulations permit), Apple can increase the average revenue per sale 
-- and secure future accessory sales, further strengthening its ecosystem.