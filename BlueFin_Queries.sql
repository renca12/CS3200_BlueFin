use realty;


-- =================================================== Queries ===================================================
SELECT * FROM management_company;
SELECT * FROM realtor;
SELECT * FROM seller;
SELECT * FROM buyer;
SELECT * FROM zip_code;
SELECT * FROM seller_realtor_relation;
SELECT * FROM buyer_realtor_relation;
SELECT * FROM property;
SELECT * FROM transaction;

-- 1. Number of sales made by each realtor

SELECT 
	r.realtor_firstname, 
    r.realtor_lastname, 
    IFNULL(sum(t.got_property), '0') AS num_sales
FROM realtor r
LEFT JOIN seller_realtor_relation s ON r.realtor_id = s.realtor_id
LEFT JOIN transaction t ON s.seller_realtor_relation_id = t.seller_realtor_relation_id
GROUP BY r.realtor_firstname, r.realtor_lastname
ORDER BY num_sales DESC;

-- 2. Which realtor negotiates for their buyers the best? 

SELECT 
	ROUND(AVG((sell_price - buyer_asking_price) / (t.seller_asking_price - t.buyer_asking_price)),4) 
		AS pct_of_bid_ask_spread_realized,
	r.realtor_firstname, 
    r.realtor_lastname, 
    m.management_company_name
FROM transaction t
INNER JOIN buyer_realtor_relation b ON t.buyer_realtor_relation_id = b.buyer_realtor_relation_id
INNER JOIN realtor r ON b.realtor_id = r.realtor_id
INNER JOIN management_company m ON r.management_company_id = m.management_company_id
GROUP BY r.realtor_firstname, r.realtor_lastname, m.management_company_name
ORDER BY pct_of_bid_ask_spread_realized ASC;


-- 3. Which zip code has the most sales sorted in order

SELECT 
	p.zip_code_id AS "Zip Code", 
	COUNT(*) AS Num_Sales
FROM transaction t
	JOIN property p 
	ON p.property_id = t.property_id
GROUP BY p.zip_code_id
ORDER BY Num_Sales DESC;

-- 4. Which management company processes transactions the quickest (sell-date - offerdate)

SELECT 
	TEMP.management_company_id, 
    ROUND(AVG(days_taken), 2) AS AVG_DAYS_TAKEN 
FROM 
	(SELECT
		mc.management_company_id, 
		DATEDIFF(t.sell_date, t.offer_date) AS days_taken
	FROM seller_realtor_relation srr
	JOIN realtor r ON srr.realtor_id = r.realtor_id
	JOIN management_company mc ON mc.management_company_id = r.management_company_id
	JOIN transaction t ON t.seller_realtor_relation_id = srr.seller_realtor_relation_id
	WHERE t.got_property = 1) TEMP
GROUP BY TEMP.management_company_id
ORDER BY AVG_DAYS_TAKEN ASC;

-- 5. Breakdown of the zipcode and housing types

SELECT 
	zc.zip_code_id, 
	p.type, 
	COUNT(p.type) AS num_type, 
	ROUND(AVG(t.seller_asking_price), 2) AS avg_listing_price 
FROM zip_code zc
JOIN property p ON zc.zip_code_id = p.zip_code_id
JOIN transaction t ON p.property_id = t.property_id
GROUP BY zc.zip_code_id, p.type;


-- 6. What are the wealthiest zip codes? (this is based on average highest sell price of the homes)

SELECT 
	zc.zip_code_id, 
	zc.region, 
    ROUND(AVG(t.sell_price), 2) AS AVG_SELL_PRICE 
FROM property p
LEFT JOIN zip_code zc on zc.zip_code_id = p.zip_code_id
LEFT JOIN transaction t on p.property_id = t.property_id
GROUP BY zc.zip_code_id, zc.region
ORDER BY AVG_SELL_PRICE DESC;

-- 7. What is each realtor's most successful zip code (most sales) assuming they all take a 15% stake in the final offer price? 

SELECT 
	TEMP.realtor_id, 
	TEMP.realtor_firstname,
	TEMP.realtor_lastname,
	TEMP.zip_code_id, 
    0.15 * TEMP.total_sales AS earnings
FROM (
    SELECT
        r.realtor_id,
        r.realtor_firstname,
        r.realtor_lastname,
        z.zip_code_id,
        SUM(t.sell_price) AS total_sales,
        ROW_NUMBER() OVER ( PARTITION BY r.realtor_id ORDER BY SUM(t.sell_price) DESC
        ) AS row_num
    FROM property p
    JOIN seller_realtor_relation srr ON srr.seller_id = p.seller_id
    JOIN realtor r ON srr.realtor_id = r.realtor_id
    JOIN transaction t ON p.property_id = t.property_id
    JOIN zip_code z ON z.zip_code_id = p.zip_code_id
    GROUP BY r.realtor_id, z.zip_code_id
) AS TEMP
WHERE row_num = 1
ORDER BY earnings DESC;
