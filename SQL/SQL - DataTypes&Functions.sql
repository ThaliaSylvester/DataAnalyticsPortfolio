--------------------------------CASE QUESTION ONE-----------------------------
-- Pull 6 columns from Dual table with various SYSDATE formats
SELECT
  SYSDATE,
  TO_CHAR(SYSDATE, 'MM/DD/YYYY') AS "MONTH/DAY/YEAR",
  TO_CHAR(SYSDATE, 'DY-MON-DD-YY HH24:MI:SS') AS "DAY-MON-DAY-YY TIME",
  TO_CHAR(SYSDATE, 'MONTH DD, YYYY') AS "MONTH DAY YEAR",
  TO_CHAR(SYSDATE, 'YYYY-MON-DD HH12:MI:SS') AS "YEAR-MONTH-DAY TIME",
  TO_CHAR(SYSDATE, 'DD/MON/YY') AS "DAY/MONTH/YEAR"
FROM dual;

--------------------------------CASE QUESTION TWO-----------------------------
-- Retrieve product category details with product info, using outer join
SELECT
  pc.category_name,
  pc.category_desc,
  p.product_id,
  NVL(product_name, 'No products assigned') AS product_name,
  TO_CHAR(p.price, '$99.99') AS list_price
FROM product_category pc
FULL OUTER JOIN products p ON pc.category_id = p.category_id
ORDER BY category_name, product_name ASC;

--------------------------------CASE QUESTION THREE---------------------------
-- Retrieve distinct state and city code, sorted by state and city code
SELECT DISTINCT
  state,
  UPPER(SUBSTR(city, 1, 3)) AS city_code
FROM customer_address
ORDER BY state DESC, city_code ASC;

--------------------------------CASE QUESTION FOUR----------------------------
-- Retrieve order details with formatted subtotal, tax, and profit amount
SELECT
  order_date,
  TO_CHAR(subtotal, '$99.99') AS subtotal,
  TO_CHAR(tax_amount, '$99.99') AS tax_amount,
  TO_CHAR(subtotal * 0.35, '$99.99') AS profit_amount
FROM orders
ORDER BY order_date ASC;

--------------------------------CASE QUESTION FIVE----------------------------
-- Retrieve order shipping details for February 2023, with approximate ship date
SELECT
  order_number,
  order_date,
  shipped_date - order_date AS days_to_ship,
  order_date + 4 AS approx_ship_date,
  (order_date + 4) - order_date AS approx_days_to_ship
FROM orders
WHERE order_date BETWEEN '01-FEB-23' AND '28-FEB-23'
ORDER BY order_date DESC;

--------------------------------CASE QUESTION SIX-----------------------------
-- Update previous query to handle null shipped dates with text
SELECT
  order_number,
  order_date,
  COALESCE(TO_CHAR(shipped_date), 'Not shipped yet') AS new_Shipped_Date,
  NVL(TO_CHAR(shipped_date - order_date), ' ') AS new_Shipped_Date,
  order_date + 4 AS approx_ship_date,
  (order_date + 4) - order_date AS approx_days_to_ship
FROM orders
WHERE order_date BETWEEN '01-FEB-23' AND '28-FEB-23'
ORDER BY order_date DESC;

--------------------------------CASE QUESTION SEVEN---------------------------
-- Retrieve email details with parsed user name and domain
SELECT
  email,
  LENGTH(email) AS email_length,
  SUBSTR(email, 1, INSTR(email, '@') - 1) AS user_name,
  SUBSTR(email, INSTR(email, '@') + 1) AS email_domain,
  'AAAAAA' || SUBSTR(email, INSTR(email, '@')) AS redacted_email
FROM customers;

--------------------------------CASE QUESTION EIGHT---------------------------
-- Retrieve product details with parsed brand and product name
SELECT
  product_id,
  product_name,
  SUBSTR(product_name, 1, INSTR(product_name, ' ') - 1) AS "Possible Brand",
  SUBSTR(product_name, INSTR(product_name, ' ') + 1) AS "Product"
FROM products
ORDER BY product_name;

--------------------------------CASE QUESTION NINE----------------------------
-- Retrieve customer details with shopping tier
SELECT
  c.customer_id,
  c.first_name || ' ' || c.last_name AS customer_name,
  COUNT(DISTINCT product_id) AS products_purchased,
  CASE
    WHEN COUNT(DISTINCT product_id) = 1 THEN 'Bronze Member'
    WHEN COUNT(DISTINCT product_id) = 2 THEN 'Silver Member'
    WHEN COUNT(DISTINCT product_id) = 3 THEN 'Gold Member'
    WHEN COUNT(DISTINCT product_id) > 3 THEN 'Platinum Member'
  END AS Shopper_Tier
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_number = od.order_number
GROUP BY c.customer_id, c.first_name, c.last_name;

--------------------------------CASE QUESTION TEN-----------------------------
-- Retrieve customer email and revenue with ranking
SELECT
  c.email,
  SUM(p.price * od.quantity) AS Revenue,
  RANK() OVER (ORDER BY SUM(p.price * od.quantity) DESC) AS Revenue_Rank
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_number = od.order_number
JOIN products p ON od.product_id = p.product_id
GROUP BY c.email, o.order_number
ORDER BY Revenue_Rank;
