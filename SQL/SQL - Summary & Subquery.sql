-------------------CASE QUESTION ONE----------------------------
-- Retrieve order count, total pre-tax spend, and max subtotal
SELECT 
  COUNT(order_number) AS order_count,
  SUM(subtotal) AS total_pretax_spend,
  MAX(subtotal) AS max_subtotal
FROM orders;

-------------------CASE QUESTION TWO----------------------------
-- Retrieve category name, product count, and most expensive product, sorted by product count
SELECT 
  pc.category_name,
  COUNT(pc.category_id) AS product_count,
  MAX(p.price) AS most_expensive_product
FROM product_category pc 
INNER JOIN products p ON pc.category_id = p.category_id
GROUP BY pc.category_name
ORDER BY product_count;

-------------------CASE QUESTION THREE--------------------------
-- Retrieve category details with avg price and difference, sorted by difference
SELECT 
  pc.category_name,
  COUNT(pc.category_id) AS product_count,
  MAX(p.price) AS most_expensive_product,
  ROUND(AVG(p.price), 2) AS avg_price,
  MAX(p.price) - AVG(p.price) AS difference
FROM product_category pc 
INNER JOIN products p ON pc.category_id = p.category_id
GROUP BY pc.category_name
ORDER BY difference DESC;

-------------------CASE QUESTION FOUR----------------------------
-- Retrieve customer purchase summary, sorted by total spend
SELECT 
  c.first_name,
  c.last_name,
  c.email,
  SUM(o.subtotal + o.tax_amount) AS invoice_total_calc,
  SUM(od.quantity) AS products_purchased
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_number = od.order_number
GROUP BY c.first_name, c.last_name, c.email
ORDER BY invoice_total_calc DESC;

-------------------CASE QUESTION FIVE----------------------------
-- Retrieve customers with at least 3 unique items, sorted by product count
SELECT 
  c.first_name,
  c.last_name,
  c.email,
  COUNT(DISTINCT od.product_id) AS product_count
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON od.order_number = o.order_number
GROUP BY c.first_name, c.last_name, c.email
HAVING COUNT(DISTINCT od.product_id) >= 3
ORDER BY product_count DESC;

-------------------CASE QUESTION SIX----------------------------
-- Retrieve customers with orders over $5, showing max invoice total
SELECT 
  c.first_name,
  c.last_name,
  c.email,
  MAX(o.invoice_total) AS max_invoice_total,
  COUNT(od.product_id) AS product_count
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON od.order_number = o.order_number
WHERE o.invoice_total > 5
GROUP BY c.first_name, c.last_name, c.email
ORDER BY product_count DESC;

-------------------CASE QUESTION SEVEN----------------------------
-- Retrieve revenue summary by category and product, using ROLLUP
SELECT 
  pc.category_name,
  p.product_name,
  SUM(p.price * od.quantity) AS revenue_total
FROM product_category pc 
JOIN products p ON pc.category_id = p.category_id
JOIN order_details od ON p.product_id = od.product_id
GROUP BY ROLLUP(pc.category_name, p.product_name);

-------------------CASE QUESTION EIGHT----------------------------
-- Retrieve employees with more than 5 orders, sorted by order count
SELECT 
  e.employee_id,
  e.last_name,
  COUNT(o.order_number) AS number_of_orders
FROM employees e 
JOIN orders o ON e.employee_id = o.employee_id
GROUP BY e.employee_id, e.last_name
HAVING COUNT(o.order_number) >= 5
ORDER BY number_of_orders DESC;

-------------------CASE QUESTION NINE----------------------------
-- Retrieve last names of customers with orders, using subquery
SELECT last_name
FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders)
ORDER BY last_name;

-------------------CASE QUESTION TEN----------------------------
-- Retrieve products priced above the average, sorted by price
SELECT 
  product_name, 
  price
FROM products
WHERE price > (SELECT AVG(price) FROM products)
ORDER BY price ASC;

-------------------CASE QUESTION ELEVEN----------------------------
-- Retrieve active customer addresses without orders, using outer join
SELECT customer_id
FROM customer_address
WHERE customer_id IN (
  SELECT ca.customer_id
  FROM customer_address ca 
  LEFT JOIN orders o ON ca.address_id = o.address_id
  WHERE ca.status = 'A' AND o.order_date IS NULL
);

-------------------CASE QUESTION TWELVE----------------------------
-- Retrieve customers and max order quantity, sorted by email
SELECT 
  email, 
  MAX(product_count) AS max_order_total
FROM (
  SELECT 
    c.email, 
    o.order_number, 
    SUM(od.quantity) AS product_count
  FROM customers c 
  JOIN orders o ON c.customer_id = o.customer_id
  JOIN order_details od ON o.order_number = od.order_number
  GROUP BY c.email, o.order_number
) 
GROUP BY email
ORDER BY email;

-------------------CASE QUESTION THIRTEEN----------------------------
-- Retrieve customers with only one order, sorted by last name
SELECT 
  customer_id, 
  first_name, 
  last_name, 
  email, 
  primary_phone
FROM customers
WHERE customer_id IN (
  SELECT customer_id
  FROM orders
  GROUP BY customer_id
  HAVING COUNT(order_number) = 1
)
ORDER BY last_name;
