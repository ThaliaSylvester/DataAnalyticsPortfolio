-- CREATE SEQUENCE SECTION
DROP SEQUENCE employee_ID_seq;
DROP SEQUENCE address_ID_seq;
DROP SEQUENCE category_ID_seq;
DROP SEQUENCE order_detail_ID_seq;
DROP SEQUENCE customer_id_seq;
DROP SEQUENCE product_id_seq;
DROP SEQUENCE order_number_seq;

CREATE SEQUENCE employee_ID_seq
START WITH 1 INCREMENT BY 1
MINVALUE 1 MAXVALUE 1000
CYCLE CACHE 100;

CREATE SEQUENCE address_ID_seq
START WITH 1 INCREMENT BY 1
MINVALUE 1 MAXVALUE 1000
CYCLE CACHE 100;

CREATE SEQUENCE category_ID_seq
START WITH 1 INCREMENT BY 1
MINVALUE 1 MAXVALUE 1000
CYCLE CACHE 100;

CREATE SEQUENCE order_detail_ID_seq
START WITH 1 INCREMENT BY 1
MINVALUE 1 MAXVALUE 1000
CYCLE CACHE 100;

CREATE SEQUENCE customer_id_seq
START WITH 20000 INCREMENT BY 1
MINVALUE 20000 MAXVALUE 100000
CYCLE CACHE 100;

CREATE SEQUENCE product_id_seq
START WITH 1000 INCREMENT BY 1
MINVALUE 1000 MAXVALUE 100000
CYCLE CACHE 100;

CREATE SEQUENCE order_number_seq
START WITH 10000 INCREMENT BY 1
MINVALUE 10000 MAXVALUE 1000000
CYCLE CACHE 100;

-- CREATE TABLE SECTION
DROP TABLE order_details;
DROP TABLE products;
DROP TABLE product_category;
DROP TABLE orders;
DROP TABLE employees;
DROP TABLE customer_address;
DROP TABLE customers;

CREATE TABLE customers (
    customer_ID NUMBER (30) DEFAULT customer_id_seq.NEXTVAL,
    first_name VARCHAR (30) NOT NULL,
    last_name VARCHAR (30) NOT NULL,
    email VARCHAR (30) NOT NULL,
    primary_phone CHAR(12) NOT NULL,
    secondary_phone CHAR(12),
    password VARCHAR (50) NOT NULL, -- Increased length for passwords
    CONSTRAINT customers_pk PRIMARY KEY (customer_ID),
    CONSTRAINT customers_email_uq UNIQUE (email),
    CONSTRAINT password_length CHECK (LENGTH(password) >= 8)
);

CREATE TABLE customer_address (
    address_ID NUMBER (30) DEFAULT address_ID_seq.NEXTVAL,
    customer_ID NUMBER (30) NOT NULL,
    address_1 VARCHAR(50) NOT NULL, -- Increased length for address
    address_2 VARCHAR(50),
    city VARCHAR(30) NOT NULL,
    state CHAR(2) NOT NULL,
    zip CHAR(5) NOT NULL,
    status CHAR(1) DEFAULT 'A',
    CONSTRAINT customer_address_pk PRIMARY KEY (address_ID),
    CONSTRAINT customer_ID_fk_customer FOREIGN KEY (customer_ID) REFERENCES customers (customer_ID),
    CONSTRAINT status CHECK (status in ('A','I'))
);

CREATE TABLE employees (
    employee_ID NUMBER (30) DEFAULT employee_ID_seq.NEXTVAL,
    first_name VARCHAR (30) NOT NULL,
    last_name VARCHAR (30) NOT NULL,
    birthday DATE,
    tax_ID_number VARCHAR(30) NOT NULL, 
    mailing_address VARCHAR(50) NOT NULL,
    mailing_city VARCHAR(30) NOT NULL,
    mailing_state CHAR(2) NOT NULL,
    mailing_zip CHAR(5) NOT NULL,
    CONSTRAINT employees_pk PRIMARY KEY (employee_ID),
    CONSTRAINT employees_uq UNIQUE (tax_ID_number)
);

CREATE TABLE product_category (
    category_ID NUMBER (30) DEFAULT category_ID_seq.NEXTVAL,
    category_name VARCHAR (30) NOT NULL,
    category_desc VARCHAR (50) NOT NULL,
    CONSTRAINT product_category_pk PRIMARY KEY (category_ID),
    CONSTRAINT product_category_uq UNIQUE (category_name)
);

CREATE TABLE products (
    product_ID NUMBER (30) DEFAULT product_id_seq.NEXTVAL,
    category_ID NUMBER (30) NOT NULL,
    UPC VARCHAR(30) NOT NULL, -- Fixed to VARCHAR
    product_name VARCHAR (30) NOT NULL,
    product_desc VARCHAR (50) NOT NULL, 
    price NUMBER (30, 2) NOT NULL, 
    on_hand_amt NUMBER (30) NOT NULL,
   


CREATE TABLE orders (
    order_number NUMBER (30) DEFAULT order_number_seq.NEXTVAL,
    employee_ID NUMBER (30) NOT NULL,
    customer_ID NUMBER (30) NOT NULL,
    order_date DATE NOT NULL,
    subtotal NUMBER (30) NOT NULL,
    tax_amount NUMBER (30) NOT NULL,
    invoice_total NUMBER (30) NOT NULL,
    address_ID NUMBER (30) NOT NULL,
    CONSTRAINT orders_pk PRIMARY KEY (order_number),
    CONSTRAINT employee_ID_fk FOREIGN KEY (employee_ID) REFERENCES employees (employee_ID),
    CONSTRAINT customer_ID_fk FOREIGN KEY (customer_ID) REFERENCES customers (customer_ID),
    CONSTRAINT address_ID_fk FOREIGN KEY (address_ID) REFERENCES customer_address (address_ID),
    CONSTRAINT subtotal CHECK (subtotal > 0),
    CONSTRAINT tax_amount CHECK (tax_amount > 0),
    CONSTRAINT invoice_total CHECK (invoice_total > subtotal) -- Fixed constraint
);

CREATE TABLE order_details (
    order_details_id NUMBER (30) DEFAULT order_detail_ID_seq.NEXTVAL,
    order_number NUMBER (30) NOT NULL,
    product_ID NUMBER (30) NOT NULL,
    quantity NUMBER(30) NOT NULL,
    CONSTRAINT order_details_pk PRIMARY KEY (order_details_id),
    CONSTRAINT order_details_fk FOREIGN KEY (order_number) REFERENCES orders (order_number),
    CONSTRAINT product_ID_fk FOREIGN KEY (product_ID) REFERENCES products (product_ID),
    CONSTRAINT quantity CHECK (quantity > 0)
);

-- CREATE INDEXES
DROP INDEX customers_address_customer_ID_ix;
DROP INDEX orders_employee_ID_ix;
DROP INDEX orders_customer_ID_ix;
DROP INDEX orders_address_ID_ix;
DROP INDEX order_details_order_number_ix;
DROP INDEX order_details_product_ID_ix;
DROP INDEX products_category_ID_ix;
DROP INDEX order_date_ix;
DROP INDEX order_subtotal_ix;

CREATE INDEX customers_address_customer_ID_ix ON customer_address (customer_ID);
CREATE INDEX orders_employee_ID_ix ON orders (employee_ID);
CREATE INDEX orders_customer_ID_ix ON orders (customer_ID);
CREATE INDEX orders_address_ID_ix ON orders (address_ID);
CREATE INDEX order_details_order_number_ix ON order_details (order_number);
CREATE INDEX order_details_product_ID_ix ON order_details (product_ID);
CREATE INDEX products_category_ID_ix ON products (category_ID);
CREATE INDEX order_date_ix ON orders (order_date);
CREATE INDEX order_subtotal_ix ON orders (subtotal);

-- CREATE INSERTS
-- Categories
INSERT INTO product_category (category_ID, category_name, category_desc) VALUES (1, 'Clothes', 'All Clothes');
INSERT INTO product_category (category_ID, category_name, category_desc) VALUES (category_ID_seq.NEXTVAL, 'Shoes', 'All Shoes');

-- Products
INSERT INTO products (product_ID, UPC, product_name, product_desc, price, on_hand_amt, category_ID) VALUES (101, '123456', 'Red Shoes', 'Cute red shoes', 35, 10, 2);
INSERT INTO products (product_ID, UPC, product_name, product_desc, price, on_hand_amt, category_ID) VALUES (102, '654321', 'Blue Shoes', 'Cute blue shoes', 35, 11, 2);
INSERT INTO products (product_ID, UPC, product_name, product_desc, price, on_hand_amt, category_ID) VALUES (103, '09876', 'Blue Shirt', 'Navy Blue Shirt', 15, 13, 1);

-- Customers
INSERT INTO customers (customer_ID, first_name, last_name, email, primary_phone, password) VALUES (1, 'Thalia', 'Sylvester', 'ts38284@utexas.edu', '123-123-1234', 'password1');
INSERT INTO customers (customer_ID, first_name, last_name, email, primary_phone, secondary_phone, password) VALUES (customer_id_seq.NEXTVAL, 'John', 'Doe', 'jd38284@utexas.edu', '321-321-4321', '555-555-5555', 'password2');

-- Address
INSERT INTO customer_address (address_ID, customer_ID, address_1, city, state, zip, status) VALUES (address_ID_seq.NEXTVAL, 1, '123 Main St', 'Austin', 'TX', '78701', 'A');
INSERT INTO customer_address (address_ID, customer_ID, address_1, city, state, zip, status) VALUES (address_ID_seq.NEXTVAL, customer_id_seq.NEXTVAL, '456 Elm St', 'Austin', 'TX', '78702', 'A');

-- Employees
INSERT INTO employees (employee_ID, first_name, last_name, birthday, tax_ID_number, mailing_address, mailing_city, mailing_state, mailing_zip) VALUES (1, 'Jane', 'Doe', '1998-12-25', '1010', '123 Sunshine St', 'Austin', 'TX', '78740');
INSERT INTO employees (employee_ID, first_name, last_name, birthday, tax_ID_number, mailing_address, mailing_city, mailing_state, mailing_zip) VALUES (employee_ID_seq.NEXTVAL, 'Jack', 'Doe', '1998-11-25', '1212', '321 Sunshine St', 'Austin', 'TX', '78740');


