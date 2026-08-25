-- this project is about e-commerce funnel analysis
-- goal is to understand how users move from home page till purchase
-- using sql queries to find drop offs, conversion and user behavior
-- dataset is event based and analysis is done step by step

-- creating database for funnel analysis
CREATE DATABASE funnel_analysis;
USE funnel_analysis;

-- creating customers table
-- this table store all user events
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    SessionID VARCHAR(50),
    UserID VARCHAR(50),
    Timestampp DATETIME,
    PageType VARCHAR(50),
    DeviceType VARCHAR(20),
    Country VARCHAR(50),
    ReferralSource VARCHAR(50),
    TimeOnPage_seconds INT,
    ItemsInCart INT,
    Purchased INT
);

-- checking first few rows after import
SELECT * FROM  customers
LIMIT 10;


-- basic data sanity check
SELECT COUNT(*) AS total_rows, COUNT(DISTINCT UserID) AS total_users,
COUNT(DISTINCT SessionID) AS total_sessions FROM customers;
SELECT DISTINCT PageType FROM customers;

-- simple funnel summary
CREATE VIEW funnel_summary AS
SELECT PageType, COUNT(DISTINCT UserID) AS users
FROM customers
GROUP BY PageType
order by users desc;

select * from funnel_summary;

-- overall conversion calculation
-- using confirmation page as purchase
WITH base AS (
SELECT COUNT(DISTINCT UserID) AS total_users,
COUNT(DISTINCT CASE WHEN PageType = 'confirmation' THEN UserID END) AS converted_users FROM customers)

-- showing values in table format using union
SELECT 'Total Users' AS Category, total_users AS value FROM base
UNION ALL
SELECT 'Converted Users', converted_users FROM base
UNION ALL
SELECT 'Conversion Rate %', ROUND(converted_users * 100.0 / total_users, 2)
FROM base;

-- preparing step wise timestamps for funnel
-- taking first time user reached each step
WITH step_times1 AS (
SELECT
SessionID, UserID,
MIN(CASE WHEN PageType = 'home' THEN Timestampp END) AS home_time,
MIN(CASE WHEN PageType = 'product_page' THEN Timestampp END) AS product_time,
MIN(CASE WHEN ItemsInCart > 0 THEN Timestampp END) AS cart_time,
MIN(CASE WHEN PageType = 'checkout' THEN Timestampp END) AS checkout_time,
MIN(CASE WHEN PageType = 'confirmation' THEN Timestampp END) AS purchased_time
FROM customers
GROUP BY SessionID, UserID)

-- checking only purchased sessions
SELECT * FROM step_times1
WHERE purchased_time IS NOT NULL;

-- device wise funnel analysis
-- checking how users move in funnel per device
WITH step_times AS (
SELECT
SessionID, UserID, DeviceType,
MIN(CASE WHEN PageType='home' THEN Timestampp END) AS home_time,
MIN(CASE WHEN PageType='product_page' THEN Timestampp END) AS product_time,
MIN(CASE WHEN PageType='cart' THEN Timestampp END) AS cart_time,
MIN(CASE WHEN PageType='checkout' THEN Timestampp END) AS checkout_time,
MIN(CASE WHEN PageType='confirmation' THEN Timestampp END) AS purchase_time
FROM customers
GROUP BY SessionID, UserID, DeviceType)

SELECT
DeviceType,
COUNT(DISTINCT UserID) AS visits,
COUNT(DISTINCT CASE WHEN product_time > home_time THEN UserID END) AS product_users,
COUNT(DISTINCT CASE WHEN cart_time > product_time THEN UserID END) AS cart_users,
COUNT(DISTINCT CASE WHEN checkout_time > cart_time THEN UserID END) AS checkout_users,
COUNT(DISTINCT CASE WHEN purchase_time > checkout_time THEN UserID END) AS purchase_users
FROM step_times
GROUP BY DeviceType;

-- referral source wise funnel
-- helps to know which source convert better
WITH step_times AS (
SELECT
SessionID, UserID, ReferralSource,
MIN(CASE WHEN PageType='home' THEN Timestampp END) AS home_time,
MIN(CASE WHEN PageType='product_page' THEN Timestampp END) AS product_time,
MIN(CASE WHEN PageType='cart' THEN Timestampp END) AS cart_time,
MIN(CASE WHEN PageType='checkout' THEN Timestampp END) AS checkout_time,
MIN(CASE WHEN PageType='confirmation' THEN Timestampp END) AS purchase_time
FROM customers
GROUP BY SessionID, UserID, ReferralSource)

SELECT
ReferralSource, COUNT(DISTINCT UserID) AS visits,
COUNT(DISTINCT CASE WHEN purchase_time > checkout_time THEN UserID END) AS purchases,
ROUND(COUNT(DISTINCT CASE WHEN purchase_time > checkout_time THEN UserID END)*100.0 / COUNT(DISTINCT UserID), 2) AS conversion_rate
FROM step_times
GROUP BY ReferralSource
ORDER BY conversion_rate DESC;

-- country wise conversion analysis
WITH step_times AS (
SELECT
SessionID, UserID, Country,
MIN(CASE WHEN PageType='home' THEN Timestampp END) AS home_time,
MIN(CASE WHEN PageType='confirmation' THEN Timestampp END) AS purchase_time
FROM customers
GROUP BY SessionID, UserID, Country)

SELECT
Country, COUNT(DISTINCT UserID) AS visits,
COUNT(DISTINCT CASE WHEN purchase_time > home_time THEN UserID END) AS purchases,
ROUND(COUNT(DISTINCT CASE WHEN purchase_time > home_time THEN UserID END)*100.0 / COUNT(DISTINCT UserID), 2) AS conversion_rate
FROM step_times
GROUP BY Country
ORDER BY conversion_rate DESC;

-- checking avg time spent on each page
SELECT
PageType, ROUND(AVG(TimeOnPage_seconds),2) AS avg_time_sec
FROM customers
GROUP BY PageType;

-- cart size vs conversion analysis
-- checking if more items increase purchase chance
WITH carts AS (
SELECT
SessionID, UserID,
MAX(ItemsInCart) AS max_items,
MAX(CASE WHEN PageType='confirmation' THEN 1 ELSE 0 END) AS converted
FROM customers
GROUP BY SessionID, UserID)

SELECT
max_items,
COUNT(DISTINCT UserID) AS users,
ROUND(SUM(converted)*100.0/COUNT(DISTINCT UserID),2) AS conversion_pct
FROM carts
GROUP BY max_items
ORDER BY max_items;

-- final funnel output in proper table format
-- easy to read and power bi ready
WITH funnel_counts AS (
SELECT COUNT(DISTINCT CASE WHEN PageType='home' THEN UserID END) AS visit_users,
COUNT(DISTINCT CASE WHEN PageType='product_page' THEN UserID END) AS product_page_users,
COUNT(DISTINCT CASE WHEN PageType='cart' THEN UserID END) AS cart_users,
COUNT(DISTINCT CASE WHEN PageType='checkout' THEN UserID END) AS checkout_users,
COUNT(DISTINCT CASE WHEN PageType='confirmation' THEN UserID END) AS purchase_users
FROM customers ),

funnel_steps AS (
SELECT 1 AS step_order, 'Visit (Home page)' AS funnel_step, visit_users AS users, NULL AS prev_users FROM funnel_counts
UNION ALL
SELECT 2, 'Product Page', product_page_users, visit_users FROM funnel_counts
UNION ALL
SELECT 3, 'Cart', cart_users, product_page_users FROM funnel_counts
UNION ALL
SELECT 4, 'Checkout', checkout_users, cart_users FROM funnel_counts
UNION ALL
SELECT 5, 'Purchase', purchase_users, checkout_users FROM funnel_counts)

SELECT
step_order, funnel_step, users,
ROUND(CASE WHEN prev_users IS NULL THEN NULL ELSE (prev_users - users) * 100.0 / prev_users END, 2) AS drop_off_rate
FROM funnel_steps
ORDER BY step_order;

-- end of funnel analysis queries
-- covered overall funnel, device, referral, country and cart behavior
-- confirmation page is used as final purchase step
-- queries are written simple and clear for easy understanding
-- this analysis can be connected to power bi for visualization

