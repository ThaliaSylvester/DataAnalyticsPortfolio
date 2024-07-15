--------------------CASE QUESTION ONE----------------------------
-- Retrieve and display products ordered by price descending
SELECT product_id, brand, product_name, price
FROM Products
ORDER BY price DESC;

--------------------CASE QUESTION TWO----------------------------
-- Concatenate first and last names for customers with specific last names
-- Using LIKE operator
SELECT first_name || ' ' || last_name AS student_full_name
FROM customers
WHERE last_name LIKE 'E%'
OR last_name LIKE 'G%'
OR last_name LIKE 'H%'
ORDER BY last_name DESC;

-- Using IN operator
SELECT first_name || ' ' || last_name AS student_full_name
FROM customers
WHERE SUBSTR(last_name, 1, 1) IN ('E', 'G', 'H')
ORDER BY last_name DESC;

--------------------CASE QUESTION THREE--------------------------
-- Retrieve products priced between 5 and 20 dollars, ordered by quantity descending
SELECT product_name, price, on_hand_amt
FROM products
WHERE price > 5 AND price < 20
ORDER BY on_hand_amt DESC;

--------------------CASE QUESTION FOUR----------------------------
-- Retrieve products priced between 5 and 20 dollars using BETWEEN operator
SELECT product_name, price, on_hand_amt
FROM products
WHERE price BETWEEN 5 AND 20
ORDER BY on_hand_amt DESC;

-- Compare with MINUS operator to ensure same results
SELECT product_name, price, on_hand_amt
FROM products
WHERE price > 5 AND price < 20
MINUS
SELECT product_name, price, on_hand_amt
FROM products
WHERE price BETWEEN 5 AND 20;
-- The MINUS operator produces 0 rows, indicating both queries yield the same results

--------------------CASE QUESTION FIVE---------------------------
-- Calculate potential revenue and profit for top 5 products
SELECT product_name, price, on_hand_amt,
price * on_hand_amt AS total_potential_revenue,
ROUND((price * on_hand_amt) / 1.2, 2) AS total_potential_profit
FROM products
WHERE ROWNUM <= 5
ORDER BY total_potential_revenue DESC;

--------------------CASE QUESTION SIX-----------------------
-- Retrieve products with potential profit over 50
SELECT product_name, brand, product_desc, price, on_hand_amt
FROM products
WHERE ROUND((price * on_hand_amt) / 1.2, 2) > 50;

--------------------CASE QUESTION SEVEN--------------------------
-- Retrieve customers with secondary phone numbers, ordered by email and last name
SELECT first_name, last_name, email, primary_phone, secondary_phone
FROM customers
WHERE secondary_phone IS NOT NULL
ORDER BY email ASC, last_name DESC;

--------------------CASE QUESTION EIGHT------------------------
-- PT 1: Display today's date formatted
-- This query retrieves the current date in both unformatted and formatted styles (MM-DD-YYYY).
SELECT
SYSDATE AS today_unformatted,
to_char(SYSDATE, 'MM-DD-YYYY') AS today_formatted
FROM dual;

-- PT 2: Display store info and date
-- This query retrieves the current date, formats it, and includes store information, customer count, and product order calculations.
SELECT
SYSDATE AS today_unformatted,
to_char(SYSDATE, 'MM-DD-YYYY') AS today_formatted,
'Clint''s Online Snack-a-rama' AS Name_Of_Store,
100 AS total_customers,
FLOOR(104 / 100) AS Products_per_order_R1,
CEIL(104 / 100) AS Products_per_order_R2
FROM dual;

--------------------CASE QUESTION NINE------------------------------
-- Retrieve top 5 products from specified categories, ordered by price descending
SELECT brand, product_name, price
FROM products
WHERE category_id IN (1, 3)
ORDER BY price DESC
FETCH NEXT 5 ROWS ONLY;

--------------------CASE QUESTION TEN--------------------------
-- Retrieve product categories with their products, ordered by category name and price
SELECT pc.category_name, p.product_name, p.price
FROM PRODUCT_CATEGORY pc LEFT JOIN products p
ON pc.category_id = p.category_id
ORDER BY category_name ASC, price DESC;

--------------------CASE QUESTION ELEVEN------------------------
-- Concatenate customer info and their activity in specified states
SELECT first_name || ' ' || last_name || ' at ' || address_1 || ' spent ' || invoice_total || ' on ' || order_date AS customer_activity
FROM customers c INNER JOIN Customer_Address ca ON c.customer_id = ca.customer_id
INNER JOIN orders o ON o.address_id = ca.address_id
WHERE state IN ('TX', 'LA', 'NM', 'OK')
ORDER BY order_date;

--------------------CASE QUESTION TWELVE-------------------------
-- PT 1: Retrieve customers with no orders
SELECT first_name, last_name, email, primary_phone
FROM customers C LEFT JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
WHERE ORDER_NUMBER IS NULL;

-- PT 2: Count of unique customer IDs in orders
SELECT COUNT(DISTINCT CUSTOMER_ID) AS count_of_unique_customer_id
FROM orders;
-- The count function informs us of how many unique customer IDs exist in the orders table.

--------------------CASE QUESTION THIRTEEN----------------------------
-- Retrieve customer and order details, highlighting missing products or orders
SELECT c.last_name, c.email, o.order_number, p.product_id, p.product_name
FROM customers c FULL OUTER JOIN orders o ON c.customer_id = o.customer_id
FULL OUTER JOIN Order_Details od ON o.order_number = od.order_number
FULL OUTER JOIN products p ON od.product_id = p.product_id
WHERE od.order_number IS NULL OR p.product_name IS NULL
ORDER BY last_name;

--------------------CASE QUESTION FOURTEEN-----------------------
-- Categorize orders by size based on invoice total
SELECT 'Small' Order_Size, Customer_ID, Order_Number, Order_Date, Invoice_Total
FROM orders
WHERE Invoice_Total > 10
UNION
SELECT 'Medium' Order_Size, Customer_ID, Order_Number, Order_Date, Invoice_Total
FROM orders
WHERE Invoice_Total >= 10 AND Invoice_Total < 20
UNION
SELECT 'Large' Order_Size, Customer_ID, Order_Number, Order_Date, Invoice_Total
FROM orders
WHERE Invoice_Total >= 20
ORDER BY Invoice_Total, ORDER_DATE;



