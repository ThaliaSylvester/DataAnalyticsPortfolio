SET SERVEROUTPUT ON;


-------------------------------- CASE QUESTION ONE -----------------------------
-- Write a PL/SQL block to count products and display whether the count is greater than or equal to 10.
DECLARE
  product_count_var NUMBER(9, 2);
BEGIN
  SELECT COUNT(product_id)
  INTO product_count_var
  FROM Products;
  IF product_count_var >= 10 THEN
    DBMS_OUTPUT.PUT_LINE('The number of products is greater than or equal to 10');
  ELSE
    DBMS_OUTPUT.PUT_LINE('The number of products is less than 10');
  END IF;
END;
/


-------------------------------- CASE QUESTION TWO -----------------------------
-- Write a PL/SQL block to count products and calculate the average price, displaying both if count is >= 10.
DECLARE
  product_count_var NUMBER(9, 2);
  avg_list_price_var NUMBER(9, 2);
BEGIN
  SELECT COUNT(product_id)
  INTO product_count_var
  FROM Products;
  SELECT AVG(price)
  INTO avg_list_price_var
  FROM Products;
  IF product_count_var >= 10 THEN
    DBMS_OUTPUT.PUT_LINE('Product count: ' || product_count_var || ', Average list price: $' || ROUND(avg_list_price_var, 2));
  ELSE
    DBMS_OUTPUT.PUT_LINE('The number of products is less than 10');
  END IF;
END;
/


-------------------------------- CASE QUESTION THREE -----------------------------
-- Write a PL/SQL block to get total quantity for product ID 1001 and display if it's more than 1.
DECLARE
  total_product_quantity NUMBER(9, 2);
BEGIN
  SELECT SUM(quantity)
  INTO total_product_quantity
  FROM order_details
  WHERE product_id = 1001;
  IF total_product_quantity > 1 THEN
    DBMS_OUTPUT.PUT_LINE('The product has more than 1 in quantity');
  ELSE
    DBMS_OUTPUT.PUT_LINE('The product has only 1 in quantity');
  END IF;
END;
/


-------------------------------- CASE QUESTION FOUR -----------------------------
-- Prompt for a product ID and display total quantity, handling invalid IDs.
SET SERVEROUTPUT ON;
DECLARE
  product_id_var NUMBER(9, 2);
  total_product_quantity NUMBER(9, 2);
BEGIN
  product_id_var := &product_id;
  SELECT SUM(quantity), product_id
  INTO total_product_quantity, product_id_var
  FROM order_details
  WHERE product_id = product_id_var
  GROUP BY product_id;
  IF total_product_quantity > 1 THEN
    DBMS_OUTPUT.PUT_LINE('The product with product ID:' || product_id_var || ' has more than 1 in quantity.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('The product with product ID:' || product_id_var || ' has only 1 in quantity.');
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('The product with product ID:' || product_id_var || ' is not in table.');
END;
/


-------------------------------- CASE QUESTION FIVE -----------------------------
-- Write a PL/SQL block that creates a cursor for products with a price > $4.5, sorted descending by price.
DECLARE
  product_name_var VARCHAR2(50);
  brand_var VARCHAR2(50);
  price_var NUMBER(10,2);
  CURSOR product_cursor IS
    SELECT product_name, brand, price
    FROM Products
    WHERE price > 4.5
    ORDER BY price DESC;
BEGIN
  FOR product IN product_cursor LOOP
    product_name_var := product.product_name;
    brand_var := product.brand;
    price_var := product.price;
    DBMS_OUTPUT.PUT_LINE(product_name_var || ' | ' || brand_var || ' | ' || TO_CHAR(price_var,'$99999.99') || ' | ');
  END LOOP;
END;
/


-------------------------------- CASE QUESTION SIX -----------------------------
-- Write a stored procedure to delete rows from order_details and orders based on order_number.
CREATE OR REPLACE PROCEDURE delete_detail_ID (
  order_nummber_param orders.order_number%TYPE
)
AS
BEGIN
  DELETE FROM order_details WHERE order_number = order_nummber_param;
  DELETE FROM orders WHERE order_number = order_nummber_param;
  IF SQL%ROWCOUNT = 0 THEN
    DBMS_OUTPUT.PUT_LINE('No order rows were deleted. May not be a valid order_number');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Order ' || order_nummber_param || ' has been fully deleted.');
  END IF;
  COMMIT;
END;
/


-- First Call
CALL delete_detail_ID(10000);
-- Sample Output: Order 10000 has been fully deleted.


-- Second and Third Calls
CALL delete_detail_ID(10000);
BEGIN
  delete_detail_ID(11111);
END;
/
-- Sample Outputs: No order rows were deleted. May not be a valid order_number


-------------------------------- CASE QUESTION SEVEN -----------------------------
-- Write a PL/SQL block to get distinct brands for 'Coffee' category products using bulk collect.
DECLARE
  TYPE brand_list IS TABLE OF products.brand%TYPE INDEX BY PLS_INTEGER;
  brands brand_list;
BEGIN
  SELECT DISTINCT p.brand BULK COLLECT INTO brands
  FROM product_category pc
  JOIN products p ON pc.category_id = p.category_id
  WHERE pc.category_name = 'Coffee'
  ORDER BY p.brand ASC;
  FOR i IN 1..brands.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Brand number ' || i || ': ' || brands(i));
  END LOOP;
END;
/


-------------------------------- CASE QUESTION EIGHT -----------------------------
-- Create a function to return the total number of orders for a given customer_id.
CREATE OR REPLACE FUNCTION order_count (
  customer_id_parm IN orders.customer_id%TYPE
)
RETURN NUMBER
AS
  order_count_var NUMBER(9,2);
BEGIN
  SELECT COUNT(customer_id)
  INTO order_count_var
  FROM orders
  WHERE customer_id = customer_id_parm;
  RETURN order_count_var;
END;
/


-- Test the function
SELECT customer_id, order_count(customer_id)
FROM orders
GROUP BY customer_id
ORDER BY customer_id;


SELECT customer_id, order_count(customer_id)
FROM orders
WHERE order_count(customer_id) > 1
GROUP BY customer_id
ORDER BY order_count(customer_id) DESC, customer_id;