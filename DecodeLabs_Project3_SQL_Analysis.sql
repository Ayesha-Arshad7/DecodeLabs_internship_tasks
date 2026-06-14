-- =============================================================================
-- DecodeLabs | Project 3: SQL Data Analysis
-- Dataset   : E-Commerce Orders (1,200 records)
-- Analyst   : DecodeLabs Data Team
-- =============================================================================
-- TABLE SCHEMA
-- ------------
--   OrderID        VARCHAR   Unique order identifier
--   Date           DATE      Order placement date
--   CustomerID     VARCHAR   Unique customer identifier
--   Product        VARCHAR   Product name
--   Quantity       INT       Units ordered
--   UnitPrice      DECIMAL   Price per unit
--   ShippingAddress VARCHAR  Delivery address
--   PaymentMethod  VARCHAR   Payment method used
--   OrderStatus    VARCHAR   Shipped / Cancelled / Returned / Delivered / Pending
--   TrackingNumber VARCHAR   Shipment tracking ID
--   ItemsInCart    INT       Total items in the customer's cart
--   CouponCode     VARCHAR   Coupon applied (SAVE10, FREESHIP, WINTER15, NULL)
--   ReferralSource VARCHAR   Traffic source (Instagram, Facebook, Google, Email, Referral)
--   TotalPrice     DECIMAL   Final order value
-- =============================================================================


-- =============================================================================
-- SECTION 1 — DATA EXPLORATION
-- =============================================================================
USE decodelabs;
SET SESSION sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));
-- 1.1  Preview the first 10 rows
SELECT *
FROM orders
LIMIT 10;


-- 1.2  Count total records
SELECT COUNT(*) AS total_orders
FROM orders;


-- 1.3  Date range of the dataset
SELECT
    MIN(Date) AS earliest_order,
    MAX(Date) AS latest_order
FROM orders;


-- 1.4  Distinct products sold
SELECT DISTINCT Product
FROM orders
ORDER BY Product;


-- 1.5  Distinct order statuses
SELECT DISTINCT OrderStatus
FROM orders
ORDER BY OrderStatus;


-- =============================================================================
-- SECTION 2 — SELECT + WHERE  (Filtering Records)
-- =============================================================================

-- 2.1  All delivered orders
SELECT OrderID, CustomerID, Product, TotalPrice, Date
FROM orders
WHERE OrderStatus = 'Delivered';


-- 2.2  High-value orders (TotalPrice > 2000)
SELECT OrderID, CustomerID, Product, TotalPrice
FROM orders
WHERE TotalPrice > 2000
ORDER BY TotalPrice DESC;


-- 2.3  Laptop orders paid by Credit Card
SELECT OrderID, CustomerID, Quantity, UnitPrice, TotalPrice
FROM orders
WHERE Product = 'Laptop'
  AND PaymentMethod = 'Credit Card';


-- 2.4  Orders placed in 2024
SELECT OrderID, Date, Product, TotalPrice
FROM orders
WHERE Date BETWEEN '2024-01-01' AND '2024-12-31'
ORDER BY Date;


-- 2.5  Cancelled or Returned orders
SELECT OrderID, CustomerID, Product, OrderStatus, TotalPrice
FROM orders
WHERE OrderStatus IN ('Cancelled', 'Returned')
ORDER BY OrderStatus, TotalPrice DESC;


-- 2.6  Orders where a coupon was NOT used
SELECT OrderID, CustomerID, Product, TotalPrice
FROM orders
WHERE CouponCode IS NULL
ORDER BY TotalPrice DESC;


-- 2.7  Orders from Google referral with more than 2 items in cart
SELECT OrderID, CustomerID, ReferralSource, ItemsInCart, TotalPrice
FROM orders
WHERE ReferralSource = 'Google'
  AND ItemsInCart > 2;


-- =============================================================================
-- SECTION 3 — ORDER BY  (Sorting Results)
-- =============================================================================

-- 3.1  Top 10 highest-value orders
SELECT OrderID, CustomerID, Product, TotalPrice
FROM orders
ORDER BY TotalPrice DESC
LIMIT 10;


-- 3.2  Most recent 10 orders
SELECT OrderID, Date, CustomerID, Product, TotalPrice
FROM orders
ORDER BY Date DESC
LIMIT 10;


-- 3.3  Orders sorted by Product name, then lowest price first
SELECT OrderID, Product, UnitPrice, Quantity, TotalPrice
FROM orders
ORDER BY Product ASC, TotalPrice ASC;


-- 3.4  Pending orders sorted by cart size (largest first)
SELECT OrderID, CustomerID, ItemsInCart, TotalPrice
FROM orders
WHERE OrderStatus = 'Pending'
ORDER BY ItemsInCart DESC;


-- =============================================================================
-- SECTION 4 — GROUP BY + AGGREGATIONS  (COUNT, SUM, AVG)
-- =============================================================================

-- 4.1  Total orders and revenue per product
SELECT
    Product,
    COUNT(OrderID)          AS total_orders,
    SUM(Quantity)           AS units_sold,
    SUM(TotalPrice)         AS total_revenue,
    ROUND(AVG(TotalPrice), 2) AS avg_order_value
FROM orders
GROUP BY Product
ORDER BY total_revenue DESC;


-- 4.2  Order count and revenue by order status
SELECT
    OrderStatus,
    COUNT(OrderID)          AS order_count,
    SUM(TotalPrice)         AS total_value,
    ROUND(AVG(TotalPrice), 2) AS avg_value
FROM orders
GROUP BY OrderStatus
ORDER BY order_count DESC;


-- 4.3  Revenue and orders by payment method
SELECT
    PaymentMethod,
    COUNT(OrderID)          AS total_orders,
    SUM(TotalPrice)         AS total_revenue,
    ROUND(AVG(TotalPrice), 2) AS avg_order_value
FROM orders
GROUP BY PaymentMethod
ORDER BY total_revenue DESC;


-- 4.4  Orders and revenue by referral source
SELECT
    ReferralSource,
    COUNT(OrderID)          AS total_orders,
    SUM(TotalPrice)         AS total_revenue,
    ROUND(AVG(TotalPrice), 2) AS avg_order_value
FROM orders
GROUP BY ReferralSource
ORDER BY total_orders DESC;


-- 4.5  Coupon usage analysis
SELECT
    COALESCE(CouponCode, 'No Coupon') AS coupon,
    COUNT(OrderID)                    AS orders_used,
    SUM(TotalPrice)                   AS total_revenue,
    ROUND(AVG(TotalPrice), 2)         AS avg_order_value
FROM orders
GROUP BY CouponCode
ORDER BY orders_used DESC;


-- 4.6  Monthly revenue trend
SELECT
    YEAR(Date)  AS year,
    MONTH(Date) AS month,
    COUNT(OrderID)          AS total_orders,
    SUM(TotalPrice)         AS monthly_revenue,
    ROUND(AVG(TotalPrice), 2) AS avg_order_value
FROM orders
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY year, month;


-- 4.7  Revenue per product per year
SELECT
    Product,
    YEAR(Date)     AS year,
    COUNT(OrderID) AS orders,
    SUM(TotalPrice) AS revenue
FROM orders
GROUP BY Product, YEAR(Date)
ORDER BY Product, year;


-- =============================================================================
-- SECTION 5 — HAVING  (Filtering Aggregated Results)
-- =============================================================================

-- 5.1  Products with more than 150 total orders
SELECT
    Product,
    COUNT(OrderID) AS total_orders
FROM orders
GROUP BY Product
HAVING COUNT(OrderID) > 150
ORDER BY total_orders DESC;


-- 5.2  Payment methods with average order value above 1500
SELECT
    PaymentMethod,
    ROUND(AVG(TotalPrice), 2) AS avg_order_value
FROM orders
GROUP BY PaymentMethod
HAVING AVG(TotalPrice) > 1500
ORDER BY avg_order_value DESC;


-- 5.3  Referral sources generating more than 100000 in revenue
SELECT
    ReferralSource,
    SUM(TotalPrice) AS total_revenue
FROM orders
GROUP BY ReferralSource
HAVING SUM(TotalPrice) > 100000
ORDER BY total_revenue DESC;


-- =============================================================================
-- SECTION 6 — BUSINESS INTELLIGENCE QUERIES
-- =============================================================================

-- 6.1  Customer order frequency (top 15 customers)
SELECT
    CustomerID,
    COUNT(OrderID)          AS total_orders,
    SUM(TotalPrice)         AS lifetime_value,
    ROUND(AVG(TotalPrice), 2) AS avg_order_value
FROM orders
GROUP BY CustomerID
ORDER BY total_orders DESC
LIMIT 15;


-- 6.2  Top 10 customers by lifetime spend
SELECT
    CustomerID,
    COUNT(OrderID)  AS total_orders,
    SUM(TotalPrice) AS lifetime_value
FROM orders
GROUP BY CustomerID
ORDER BY lifetime_value DESC
LIMIT 10;


-- 6.3  Cancellation rate per product
SELECT
    Product,
    COUNT(OrderID)                                              AS total_orders,
    SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
    ROUND(
        SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) * 100.0
        / COUNT(OrderID), 2
    )                                                           AS cancellation_rate_pct
FROM orders
GROUP BY Product
ORDER BY cancellation_rate_pct DESC;


-- 6.4  Return rate per payment method
SELECT
    PaymentMethod,
    COUNT(OrderID)                                             AS total_orders,
    SUM(CASE WHEN OrderStatus = 'Returned' THEN 1 ELSE 0 END) AS returned_orders,
    ROUND(
        SUM(CASE WHEN OrderStatus = 'Returned' THEN 1 ELSE 0 END) * 100.0
        / COUNT(OrderID), 2
    )                                                          AS return_rate_pct
FROM orders
GROUP BY PaymentMethod
ORDER BY return_rate_pct DESC;


-- 6.5  Revenue lost to cancellations and returns
SELECT
    OrderStatus,
    COUNT(OrderID)  AS order_count,
    SUM(TotalPrice) AS revenue_at_risk
FROM orders
WHERE OrderStatus IN ('Cancelled', 'Returned')
GROUP BY OrderStatus;


-- 6.6  Best-selling product by quantity per referral source
SELECT
    ReferralSource,
    Product,
    SUM(Quantity) AS units_sold
FROM orders
GROUP BY ReferralSource, Product
ORDER BY ReferralSource, units_sold DESC;


-- 6.7  Average items in cart by order status
SELECT
    OrderStatus,
    ROUND(AVG(ItemsInCart), 2) AS avg_items_in_cart,
    ROUND(AVG(TotalPrice), 2)  AS avg_order_value
FROM orders
GROUP BY OrderStatus
ORDER BY avg_order_value DESC;


-- 6.8  Coupon impact — delivered orders only
SELECT
    COALESCE(CouponCode, 'No Coupon') AS coupon,
    COUNT(OrderID)                    AS delivered_orders,
    SUM(TotalPrice)                   AS revenue,
    ROUND(AVG(TotalPrice), 2)         AS avg_order_value
FROM orders
WHERE OrderStatus = 'Delivered'
GROUP BY CouponCode
ORDER BY revenue DESC;


-- 6.9  Quarterly revenue summary
SELECT
    YEAR(Date)                AS year,
    CONCAT('Q', QUARTER(Date)) AS quarter,
    COUNT(OrderID)            AS total_orders,
    SUM(TotalPrice)           AS quarterly_revenue
FROM orders
GROUP BY YEAR(Date), QUARTER(Date)
ORDER BY year, QUARTER(Date);


-- 6.10  Full performance dashboard — product × status matrix
SELECT
    Product,
    SUM(CASE WHEN OrderStatus = 'Delivered'  THEN TotalPrice ELSE 0 END) AS delivered_revenue,
    SUM(CASE WHEN OrderStatus = 'Shipped'    THEN TotalPrice ELSE 0 END) AS shipped_revenue,
    SUM(CASE WHEN OrderStatus = 'Pending'    THEN TotalPrice ELSE 0 END) AS pending_revenue,
    SUM(CASE WHEN OrderStatus = 'Cancelled'  THEN TotalPrice ELSE 0 END) AS cancelled_revenue,
    SUM(CASE WHEN OrderStatus = 'Returned'   THEN TotalPrice ELSE 0 END) AS returned_revenue,
    SUM(TotalPrice)                                                        AS total_revenue
FROM orders
GROUP BY Product
ORDER BY total_revenue DESC;


-- =============================================================================
-- END OF ANALYSIS
-- DecodeLabs | Project 3 — SQL Data Analysis Complete
-- =============================================================================
