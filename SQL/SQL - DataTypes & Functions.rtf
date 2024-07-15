{\rtf1\ansi\ansicpg1252\cocoartf2639
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\froman\fcharset0 TimesNewRomanPSMT;\f1\froman\fcharset0 Times-Roman;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs32 \cf0 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 --------------------------------CASE QUESTION ONE-----------------------------
\f1\fs24 \

\f0\fs32 -- Pull 6 columns from Dual table with various SYSDATE formats
\f1\fs24 \

\f0\fs32 SELECT
\f1\fs24 \

\f0\fs32 \'a0\'a0SYSDATE,
\f1\fs24 \

\f0\fs32 \'a0\'a0TO_CHAR(SYSDATE, 'MM/DD/YYYY') AS "MONTH/DAY/YEAR",
\f1\fs24 \

\f0\fs32 \'a0\'a0TO_CHAR(SYSDATE, 'DY-MON-DD-YY HH24:MI:SS') AS "DAY-MON-DAY-YY TIME",
\f1\fs24 \

\f0\fs32 \'a0\'a0TO_CHAR(SYSDATE, 'MONTH DD, YYYY') AS "MONTH DAY YEAR",
\f1\fs24 \

\f0\fs32 \'a0\'a0TO_CHAR(SYSDATE, 'YYYY-MON-DD HH12:MI:SS') AS "YEAR-MONTH-DAY TIME",
\f1\fs24 \

\f0\fs32 \'a0\'a0TO_CHAR(SYSDATE, 'DD/MON/YY') AS "DAY/MONTH/YEAR"
\f1\fs24 \

\f0\fs32 FROM dual;
\f1\fs24 \
\

\f0\fs32 --------------------------------CASE QUESTION TWO-----------------------------
\f1\fs24 \

\f0\fs32 -- Retrieve product category details with product info, using outer join
\f1\fs24 \

\f0\fs32 SELECT
\f1\fs24 \

\f0\fs32 \'a0\'a0pc.category_name,
\f1\fs24 \

\f0\fs32 \'a0\'a0pc.category_desc,
\f1\fs24 \

\f0\fs32 \'a0\'a0p.product_id,
\f1\fs24 \

\f0\fs32 \'a0\'a0NVL(product_name, 'No products assigned') AS product_name,
\f1\fs24 \

\f0\fs32 \'a0\'a0TO_CHAR(p.price, '$99.99') AS list_price
\f1\fs24 \

\f0\fs32 FROM product_category pc
\f1\fs24 \

\f0\fs32 FULL OUTER JOIN products p ON pc.category_id = p.category_id
\f1\fs24 \

\f0\fs32 ORDER BY category_name, product_name ASC;
\f1\fs24 \
\

\f0\fs32 --------------------------------CASE QUESTION THREE---------------------------
\f1\fs24 \

\f0\fs32 -- Retrieve distinct state and city code, sorted by state and city code
\f1\fs24 \

\f0\fs32 SELECT DISTINCT
\f1\fs24 \

\f0\fs32 \'a0\'a0state,
\f1\fs24 \

\f0\fs32 \'a0\'a0UPPER(SUBSTR(city, 1, 3)) AS city_code
\f1\fs24 \

\f0\fs32 FROM customer_address
\f1\fs24 \

\f0\fs32 ORDER BY state DESC, city_code ASC;
\f1\fs24 \
\

\f0\fs32 --------------------------------CASE QUESTION FOUR----------------------------
\f1\fs24 \

\f0\fs32 -- Retrieve order details with formatted subtotal, tax, and profit amount
\f1\fs24 \

\f0\fs32 SELECT
\f1\fs24 \

\f0\fs32 \'a0\'a0order_date,
\f1\fs24 \

\f0\fs32 \'a0\'a0TO_CHAR(subtotal, '$99.99') AS subtotal,
\f1\fs24 \

\f0\fs32 \'a0\'a0TO_CHAR(tax_amount, '$99.99') AS tax_amount,
\f1\fs24 \

\f0\fs32 \'a0\'a0TO_CHAR(subtotal * 0.35, '$99.99') AS profit_amount
\f1\fs24 \

\f0\fs32 FROM orders
\f1\fs24 \

\f0\fs32 ORDER BY order_date ASC;
\f1\fs24 \
\

\f0\fs32 --------------------------------CASE QUESTION FIVE----------------------------
\f1\fs24 \

\f0\fs32 -- Retrieve order shipping details for February 2023, with approximate ship date
\f1\fs24 \

\f0\fs32 SELECT
\f1\fs24 \

\f0\fs32 \'a0\'a0order_number,
\f1\fs24 \

\f0\fs32 \'a0\'a0order_date,
\f1\fs24 \

\f0\fs32 \'a0\'a0shipped_date - order_date AS days_to_ship,
\f1\fs24 \

\f0\fs32 \'a0\'a0order_date + 4 AS approx_ship_date,
\f1\fs24 \

\f0\fs32 \'a0\'a0(order_date + 4) - order_date AS approx_days_to_ship
\f1\fs24 \

\f0\fs32 FROM orders
\f1\fs24 \

\f0\fs32 WHERE order_date BETWEEN '01-FEB-23' AND '28-FEB-23'
\f1\fs24 \

\f0\fs32 ORDER BY order_date DESC;
\f1\fs24 \
\

\f0\fs32 --------------------------------CASE QUESTION SIX-----------------------------
\f1\fs24 \

\f0\fs32 -- Update previous query to handle null shipped dates with text
\f1\fs24 \

\f0\fs32 SELECT
\f1\fs24 \

\f0\fs32 \'a0\'a0order_number,
\f1\fs24 \

\f0\fs32 \'a0\'a0order_date,
\f1\fs24 \

\f0\fs32 \'a0\'a0COALESCE(TO_CHAR(shipped_date), 'Not shipped yet') AS new_Shipped_Date,
\f1\fs24 \

\f0\fs32 \'a0\'a0NVL(TO_CHAR(shipped_date - order_date), ' ') AS new_Shipped_Date,
\f1\fs24 \

\f0\fs32 \'a0\'a0order_date + 4 AS approx_ship_date,
\f1\fs24 \

\f0\fs32 \'a0\'a0(order_date + 4) - order_date AS approx_days_to_ship
\f1\fs24 \

\f0\fs32 FROM orders
\f1\fs24 \

\f0\fs32 WHERE order_date BETWEEN '01-FEB-23' AND '28-FEB-23'
\f1\fs24 \

\f0\fs32 ORDER BY order_date DESC;
\f1\fs24 \
\

\f0\fs32 --------------------------------CASE QUESTION SEVEN---------------------------
\f1\fs24 \

\f0\fs32 -- Retrieve email details with parsed user name and domain
\f1\fs24 \

\f0\fs32 SELECT
\f1\fs24 \

\f0\fs32 \'a0\'a0email,
\f1\fs24 \

\f0\fs32 \'a0\'a0LENGTH(email) AS email_length,
\f1\fs24 \

\f0\fs32 \'a0\'a0SUBSTR(email, 1, INSTR(email, '@') - 1) AS user_name,
\f1\fs24 \

\f0\fs32 \'a0\'a0SUBSTR(email, INSTR(email, '@') + 1) AS email_domain,
\f1\fs24 \

\f0\fs32 \'a0\'a0'AAAAAA' || SUBSTR(email, INSTR(email, '@')) AS redacted_email
\f1\fs24 \

\f0\fs32 FROM customers;
\f1\fs24 \
\

\f0\fs32 --------------------------------CASE QUESTION EIGHT---------------------------
\f1\fs24 \

\f0\fs32 -- Retrieve product details with parsed brand and product name
\f1\fs24 \

\f0\fs32 SELECT
\f1\fs24 \

\f0\fs32 \'a0\'a0product_id,
\f1\fs24 \

\f0\fs32 \'a0\'a0product_name,
\f1\fs24 \

\f0\fs32 \'a0\'a0SUBSTR(product_name, 1, INSTR(product_name, ' ') - 1) AS "Possible Brand",
\f1\fs24 \

\f0\fs32 \'a0\'a0SUBSTR(product_name, INSTR(product_name, ' ') + 1) AS "Product"
\f1\fs24 \

\f0\fs32 FROM products
\f1\fs24 \

\f0\fs32 ORDER BY product_name;
\f1\fs24 \
\

\f0\fs32 --------------------------------CASE QUESTION NINE----------------------------
\f1\fs24 \

\f0\fs32 -- Retrieve customer details with shopping tier
\f1\fs24 \

\f0\fs32 SELECT
\f1\fs24 \

\f0\fs32 \'a0\'a0c.customer_id,
\f1\fs24 \

\f0\fs32 \'a0\'a0c.first_name || ' ' || c.last_name AS customer_name,
\f1\fs24 \

\f0\fs32 \'a0\'a0COUNT(DISTINCT product_id) AS products_purchased,
\f1\fs24 \

\f0\fs32 \'a0\'a0CASE
\f1\fs24 \

\f0\fs32 \'a0\'a0\'a0\'a0WHEN COUNT(DISTINCT product_id) = 1 THEN 'Bronze Member'
\f1\fs24 \

\f0\fs32 \'a0\'a0\'a0\'a0WHEN COUNT(DISTINCT product_id) = 2 THEN 'Silver Member'
\f1\fs24 \

\f0\fs32 \'a0\'a0\'a0\'a0WHEN COUNT(DISTINCT product_id) = 3 THEN 'Gold Member'
\f1\fs24 \

\f0\fs32 \'a0\'a0\'a0\'a0WHEN COUNT(DISTINCT product_id) > 3 THEN 'Platinum Member'
\f1\fs24 \

\f0\fs32 \'a0\'a0END AS Shopper_Tier
\f1\fs24 \

\f0\fs32 FROM customers c
\f1\fs24 \

\f0\fs32 LEFT JOIN orders o ON c.customer_id = o.customer_id
\f1\fs24 \

\f0\fs32 JOIN order_details od ON o.order_number = od.order_number
\f1\fs24 \

\f0\fs32 GROUP BY c.customer_id, c.first_name, c.last_name;
\f1\fs24 \
\

\f0\fs32 --------------------------------CASE QUESTION TEN-----------------------------
\f1\fs24 \

\f0\fs32 -- Retrieve customer email and revenue with ranking
\f1\fs24 \

\f0\fs32 SELECT
\f1\fs24 \

\f0\fs32 \'a0\'a0c.email,
\f1\fs24 \

\f0\fs32 \'a0\'a0SUM(p.price * od.quantity) AS Revenue,
\f1\fs24 \

\f0\fs32 \'a0\'a0RANK() OVER (ORDER BY SUM(p.price * od.quantity) DESC) AS Revenue_Rank
\f1\fs24 \

\f0\fs32 FROM customers c
\f1\fs24 \

\f0\fs32 JOIN orders o ON c.customer_id = o.customer_id
\f1\fs24 \

\f0\fs32 JOIN order_details od ON o.order_number = od.order_number
\f1\fs24 \

\f0\fs32 JOIN products p ON od.product_id = p.product_id
\f1\fs24 \

\f0\fs32 GROUP BY c.email, o.order_number
\f1\fs24 \

\f0\fs32 ORDER BY Revenue_Rank;
\f1\fs24 \
}