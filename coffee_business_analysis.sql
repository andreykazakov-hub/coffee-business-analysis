/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Product ID follows the pattern: Coffee Type - Roast Type - Size
That means:
L-D-2.5 is Liberica-Dark-2.5 kg
A-L-0.2 is Arabica-Light-0.2 kg and etc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

-- Total Sales, Units, Average Sales per Order

SELECT
  SUM(sales) AS total_sales,
  SUM(quantity) AS units,
  ROUND(AVG(sales),2) AS avg_sales
FROM orders;

-- Best-selling & Most Profitable Items (LOD)

SELECT
    o.product_id,
    SUM(o.quantity) AS units_sold,
    ROUND(SUM(o.sales), 2) AS revenue,
    ROUND(SUM(o.quantity * p.profit), 2) AS profit,
    ROUND(SUM(o.quantity * p.profit) / SUM(o.sales), 4) AS profit_margin
FROM orders o
JOIN products p
  ON p.product_id = o.product_id
GROUP BY o.product_id
ORDER BY profit DESC;

-- Sales over the Years (2019-2022)

SELECT
  DATE_TRUNC('year', order_date)::date AS year,
  SUM(sales) AS total_sales,
  SUM(quantity) AS units
FROM orders
GROUP BY 1
ORDER BY 1;

-- Pricing Efficiency across Product Sizes

SELECT
  size,
  COUNT(*)                                        AS sku_count,
  ROUND(AVG(price_per_100g), 2)          AS avg_price_per_100g,
  ROUND(MIN(price_per_100g), 2)          AS min_price_per_100g,
  ROUND(MAX(price_per_100g), 2)          AS max_price_per_100g,
  ROUND(AVG(unit_price), 2)              AS avg_unit_price,
  ROUND(AVG(profit), 2)                  AS avg_profit_per_unit,
  ROUND(AVG(profit / unit_price), 2) AS avg_profit_margin_per_unit,
  ROUND(AVG(profit / (size * 10)), 2)     AS avg_profit_per_100g_est
FROM products
GROUP BY size
ORDER BY size;

-- Top Customers

SELECT
  customer_name,
  SUM(sales) AS spend,
  COUNT(*) AS purchases
FROM orders
GROUP BY customer_name
ORDER BY spend DESC
LIMIT 10;

-- Repeat Customers

SELECT
  customer_name,
  COUNT(*) AS purchases,
  SUM(sales) AS spend
FROM orders
GROUP BY customer_name
HAVING COUNT(*) >= 2
ORDER BY purchases DESC, spend DESC;

-- Customer Purchasing Behavior + Loyalty Card Impact

WITH base AS (
  SELECT
    COALESCE(c.loyalty_card, o.loyalty_card) AS loyalty_card,
    o.customer_name,
    o.country,
    COUNT(*)               AS orders_count,
    SUM(o.sales)           AS total_sales,
    SUM(o.quantity*p.profit) AS total_profit
  FROM orders o
  JOIN products p ON p.product_id = o.product_id
  LEFT JOIN customers c
    ON c.customer_name = o.customer_name
   AND c.country = o.country
  GROUP BY 1,2,3
)
SELECT
  loyalty_card,
  COUNT(*) AS customers,
  SUM(orders_count) AS orders,
  ROUND(SUM(total_sales), 2)  AS total_sales,
  ROUND(SUM(total_profit), 2) AS profit,
  ROUND((SUM(total_profit)/SUM(total_sales)), 4) AS profit_margin,
  ROUND(AVG(total_sales), 2)  AS avg_sales_per_customer,
  ROUND(AVG(total_profit), 2) AS avg_profit_per_customer,
  ROUND(AVG(orders_count), 2) AS avg_orders_per_customer
FROM base
GROUP BY loyalty_card
ORDER BY customers DESC;

