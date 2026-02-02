select * from ecom_one_big_table;

-- Country-wise User Engagement  --> Which countries have more active users?
SELECT
    Country,
    COUNT(*) AS Total_Users,
    AVG(Users_ProductsSold) AS Avg_Products_Sold,
    AVG(Users_productsWished) AS Avg_Products_Wished
FROM ecom_one_big_table
GROUP BY Country
ORDER BY Avg_Products_Sold DESC;

-- Account Age vs Selling Behavior  --> Do experienced users sell more?
SELECT
    Users_account_age_group,
    COUNT(*) AS Users_Count,
    AVG(Users_ProductsSold) AS Avg_Products_Sold
FROM ecom_one_big_table
GROUP BY Users_account_age_group
ORDER BY Avg_Products_Sold DESC;

-- Impact of Mobile App Usage --> Do users with the app sell more?
SELECT
    Users_hasanyapp,
    COUNT(*) AS Users_Count,
    AVG(Users_ProductsSold) AS Avg_Products_Sold,
    AVG(Users_socialnbfollowers) AS Avg_Followers
FROM ecom_one_big_table
GROUP BY Users_hasanyapp;


-- Social Followers vs Sales Performance --> Does social reach influence sales?
SELECT
    CASE
        WHEN Users_socialnbfollowers < 50 THEN 'Low'
        WHEN Users_socialnbfollowers BETWEEN 50 AND 500 THEN 'Medium'
        ELSE 'High'
    END AS Follower_Group,
    AVG(Users_ProductsSold) AS Avg_Products_Sold
FROM ecom_one_big_table
GROUP BY
    CASE
        WHEN Users_socialnbfollowers < 50 THEN 'Low'
        WHEN Users_socialnbfollowers BETWEEN 50 AND 500 THEN 'Medium'
        ELSE 'High'
    END
ORDER BY Avg_Products_Sold DESC;

-- Top Seller Concentration by Country --> Are sales dominated by a few sellers?
SELECT
    Country,
    SUM(Countries_TopSellers) AS Countries_TopSellers,
    SUM(Countries_Sellers) AS Countries_Sellers,
    CAST(
        SUM(Countries_TopSellers) * 100.0 / NULLIF(SUM(Countries_Sellers), 0)
        AS DECIMAL(5,2)
    ) AS TopSeller_Percentage
FROM ecom_one_big_table
WHERE Countries_Sellers IS NOT NULL
GROUP BY Country
ORDER BY TopSeller_Percentage DESC;


-- Gender-wise Buyer Distribution --> Buyer gender demographics.
SELECT
    Country,
    Buyers_Female,
    Buyers_Male,
    Buyers_Total
FROM ecom_one_big_table
WHERE Buyers_Total IS NOT NULL
ORDER BY Buyers_Total DESC;

-- Seller Performance Benchmark --> : Average seller productivity.
SELECT
    Country,
    Sellers_MeanProductsSold,
    Sellers_MeanProductsListed,
    Sellers_MeanFollowers
FROM ecom_one_big_table
WHERE Sellers_MeanProductsSold IS NOT NULL
ORDER BY Sellers_MeanProductsSold DESC;

-- Flagged Listings Impact  --> Do long titles affect sales?
SELECT
    Users_flag_long_title,
    COUNT(*) AS Users_Count,
    AVG(Users_ProductsSold) AS Avg_Products_Sold
FROM ecom_one_big_table
GROUP BY Users_flag_long_title;

-- Buyer vs Seller Market Balance --> Is the market buyer-heavy or seller-heavy?
    SELECT
    Country,
    Buyers_Total,
    Sellers_Total,
    CASE
        WHEN Buyers_Total > Sellers_Total THEN 'Buyer Heavy'
        WHEN Buyers_Total < Sellers_Total THEN 'Seller Heavy'
        ELSE 'Balanced'
    END AS Market_Type
FROM ecom_one_big_table
WHERE Buyers_Total IS NOT NULL
AND Sellers_Total IS NOT NULL;


















