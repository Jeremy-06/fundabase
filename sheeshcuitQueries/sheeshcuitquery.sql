Suppliers

INSERT INTO suppliers (supplierName) VALUES
('Makerlab Electronics'),
('Circuitrocks'),
('element14'),
('RS Components');

Categories

INSERT INTO productCategories (category)
VALUES
('Digital Displays'),
('Integrated Circuits'),
('LEDs'),
('Power Supply and Modules'),
('Wires and Cables'),
('Breadboards'),
('Switches'),
('Resistors'),
('Capacitors'),
('Oscilloscopes'),
('Others');
-- Example: Add a foreign key field to an existing table
-- ALTER TABLE <table_name> ADD COLUMN <new_column_name> <datatype>;
-- ALTER TABLE <table_name> ADD CONSTRAINT <constraint_name> FOREIGN KEY (<new_column_name>) REFERENCES <referenced_table>(<referenced_column>);

-- For example, to add a categoryId foreign key to products:
ALTER TABLE products ADD COLUMN productCategories_categoryId INT;
ALTER TABLE products ADD CONSTRAINT fk_products_productCategories FOREIGN KEY (productCategories_categoryId) REFERENCES productCategories(categoryId);


Products

INSERT INTO products (productName, productPrice, productCategories_categoryId) VALUES
-- Digital Displays
('1 inch 7 Segment Display Common Anode | SH1106BS', 35.00, 1),
('4 digit 7 Segment display | SH3461AS', 40.00, 1),

-- Integrated Circuits
('8-Pin IC SMD Timer NE555 IC 555 Timer (10 pcs)', 49.00, 2),
('SN74LS08N, Quad 2-Input AND Logic Gate', 40.00, 2),
('SN74LS32N, Quad 2-Input OR Logic Gate', 40.00, 2),
('SN74LS04N, Inverter or NOT Logic Gate', 35.00, 2),

-- LEDs
('LED 5mm (10 pcs)', 25.00, 3),

-- Power Supply and Modules
('MCU Micro USB Breadboard 5V Power Supply Module', 35.00, 4),
('9V Alkaline Battery', 27.00, 4),
('Breadboard Power Supply 3.3V or 5V with USB Port', 57.00, 4),
('Linear Voltage Regulator 3.3V 800mA LD1117-3.3 TO-220', 25.00, 4),

-- Wires and Cables
('40-Pin Jumper Wires (various sizes/types)', 50.00, 5),
('Battery 9V Buckle with 15cm Cable', 15.00, 5),

-- Breadboards
('Breadboard MB102 830 Point', 65.00, 6),
('Breadboard MB102 830 Point Clear', 65.00, 6),
('Breadboard 400 Tie Point Interlocking', 45.00, 6),
('Breadboard 400 Tie Point Interlocking Crystal', 45.00, 6),
('Breadboard Mini 4.5x3.5cm Clear', 15.00, 6),
('Breadboard SYB-120 700 pins', 55.00, 6),
('Breadboard SYB-46 300pins', 35.00, 6),

-- Switches
('Tactile Button Switch 6mm (20 pcs)', 25.00, 7),

-- Resistors
('Resistor 470 ohm 5% 1/4W (10 pcs)', 19.00, 8),
('Resistor 4.7k ohm 5% 1/4W (10 pcs)', 19.00, 8),
('Resistor 47k ohm 5% 1/4W (10 pcs)', 19.00, 8),
('Resistor 2.2k ohm 5% 1/4W (10 pcs)', 19.00, 8),
('Resistor 22k ohm 5% 1/4W (10 pcs)', 19.00, 8),
('Resistor 100k ohm 5% 1/4W (10 pcs)', 19.00, 8),

-- Capacitors
('Electrolytic Capacitor 12V 1uF-470uF (120 pcs)', 95.00, 9),
('Electrolytic Capacitor 16V 100uF (10 pcs)', 19.00, 9),
('Electrolytic Capacitor 16V 220uF (10 pcs)', 25.00, 9),
('Electrolytic Capacitor 25V 2200uF (10 pcs)', 85.00, 9),
('Electrolytic Capacitor 400V 100uF (10 pcs)', 55.00, 9),
('Electrolytic Capacitor 100V 470uF (10 pcs)', 79.00, 9),
('Electrolytic Capacitor 10V 4700uF (10 pcs)', 99.00, 9),

-- Oscilloscopes
('Oscilloscope Handheld DMM', 16750.00, 10),
('Oscilloscope with 2-Channel Handheld DMM', 13750.00, 10),

-- Others
('Battery Holder 18650 Dual Slot', 39.00, 11);



Inventory

INSERT INTO inventory (productStock, products_productId, suppliers_supplierId) VALUES
-- Digital Displays
(100, 1, 1),
(95, 2, 1),

-- Integrated Circuits
(120, 3, 1),
(90, 4, 4),
(85, 5, 4),
(110, 6, 4),

-- LEDs
(150, 7, 1),

-- Power Supply and Modules
(130, 8, 4),
(180, 9, 1),
(160, 10, 2),
(140, 11, 2),                                                                                                                                                                                                                                                                                                                                                                                  

-- Wires and Cables
(200, 12, 1),
(200, 13, 2),

-- Breadboards
(100, 14, 2),
(100, 15, 2),
(100, 16, 2),
(100, 17, 2),
(100, 18, 2),
(100, 19, 2),
(100, 20, 2),

-- Switches
(180, 21, 2),

-- Resistors
(300, 22, 2),
(280, 23, 2),
(260, 24, 2),
(240, 25, 2),
(220, 26, 2),
(200, 27, 2),

-- Capacitors
(100, 28, 2),
(150, 29, 2),
(130, 30, 2),
(120, 31, 2),
(90, 32, 2),
(80, 33, 2),
(70, 34, 2),

-- Oscilloscopes
(2, 35, 3),
(2, 36, 3),

-- Others
(95, 37, 2);

-- Example: Drop a column from a table
-- ALTER TABLE <table_name> DROP COLUMN <column_name>;

ALTER TABLE inventory DROP COLUMN pproductId;

-- Rename database from 'mydb' to 'newdb'
RENAME DATABASE mydb TO newdb;

SELECT * FROM suppliers;
SELECT * FROM productCategories;
SELECT * FROM products;
SELECT * FROM inventory;

SELECT 
    s.supplierName, 
    pc.category, 
    p.productName, 
    p.productPrice, 
    i.productStock FROM inventory i
JOIN products p ON i.products_productId = p.productId
JOIN productCategories pc ON p.productCategories_categoryId = pc.categoryId
JOIN suppliers s ON i.suppliers_supplierId = s.supplierId
ORDER BY p.productId;

INSERT INTO products (productName, productPrice, productCategories_categoryId)
VALUES ('New Product', 99.99, (SELECT categoryId FROM productCategories WHERE category = 'Digital Displays'));

ALTER TABLE cart ADD COLUMN productQty INT;

INSERT INTO customers (customerFname, customerLname, customerAddress, customerPhone) 
VALUES('RON', 'JEREMY', 'TAGUIG', '111');

SELECT 
    c.customerId,
    p.productName, 
    p.productPrice, 
    ca.productQty FROM customers c
JOIN cart ca ON c.customerId = ca.customers_customerId
JOIN products p ON ca.products_productId = p.productId
ORDER BY c.customerId;

ALTER TABLE customers ADD COLUMN userId INT NOT NULL;
ALTER TABLE customers ADD CONSTRAINT fk_customers_userId FOREIGN KEY (userId) REFERENCES users(userId);

INSERT INTO users (username, password)
VALUES ('ronjeremy', 'password123');

UPDATE customers 
SET userId = (SELECT userId FROM users WHERE username = 'ronjeremy')
WHERE customerId = 1

SELECT * FROM users;
SELECT * FROM customers;

SELECT
    p.productId,
    s.supplierName,
    pc.category,
    p.productName,
    p.productPrice
FROM products p
JOIN productCategories pc ON p.productCategories_categoryId = pc.categoryId
JOIN inventory i ON p.productId = i.products_productId
JOIN suppliers s ON i.suppliers_supplierId = s.supplierId
ORDER BY s.supplierId, p.productId;

ALTER TABLE orderitems DROP COLUMN productQty;

SELECT
    s.supplierName,
    pc.category,
    p.productName,
    p.productPrice
FROM products p
JOIN productCategories pc ON p.productCategories_categoryId = pc.categoryId
JOIN inventory i ON p.productId = i.products_productId
JOIN suppliers s ON i.suppliers_supplierId = s.supplierId
GROUP BY pc.category
ORDER BY p.productId;

SELECT
    p.productId,
    s.supplierName,
    pc.category,
    p.productName,
    p.productPrice
FROM products p
JOIN productCategories pc ON p.productCategories_categoryId = pc.categoryId
JOIN inventory i ON p.productId = i.products_productId
JOIN suppliers s ON i.suppliers_supplierId = s.supplierId
ORDER BY pc.category, p.productId;

SELECT
    p.productId,
    s.supplierName,
    pc.category,
    p.productName,
    p.productPrice
FROM products p
JOIN productCategories pc ON p.productCategories_categoryId = pc.categoryId
JOIN inventory i ON p.productId = i.products_productId
JOIN suppliers s ON i.suppliers_supplierId = s.supplierId
ORDER BY s.supplierName, p.productId;

SELECT 
    o.orderId AS 'Order No.',
    CONCAT(c.customerFname, ' ', c.customerLname) AS 'Customer Name',
    c.customerAddress AS 'Address',
    o.orderDate AS 'Order Date',
    p.productName AS 'Product',
    p.productPrice AS 'Product Price'
FROM orders o
JOIN orderitems oi ON o.orderId = oi.orders_orderId
JOIN customers c ON oi.cart_customers_customerId = c.customerId
JOIN products p ON oi.cart_products_productId = p.productId;

INSERT INTO orderitems (productQty, );

ALTER TABLE orderitems DROP COLUMN orders_orderId;

ALTER TABLE orderitems
DROP PRIMARY KEY;

ALTER TABLE orderitems
DROP FOREIGN KEY fk_orderitems_orders;

ALTER TABLE orderitems
DROP COLUMN orders_orderId;

ALTER TABLE orderitems
ADD PRIMARY KEY (
  orderItemsId,
  cart_cartId,
  cart_products_productId,
  cart_customers_customerId
);

SELECT 
    ca.cartId,
    o.orderId,
    oi.orderitemsId,
    o.orderDate,
    o.orderStatus,
    CONCAT(c.customerFname, ' ', c.customerLname) AS customerName,
    c.customerAddress,
    p.productName,
    oi.productQty,
    p.productPrice,
    (oi.productQty * p.productPrice) AS totalAmount,
    s.salesDate
FROM orders o
JOIN sales s ON o.sales_salesId = s.salesId
JOIN orderitems oi ON oi.orders_orderId = o.orderId
JOIN cart ca ON oi.cart_cartId = ca.cartId
    AND oi.cart_products_productId = ca.products_productId
    AND oi.cart_customers_customerId = ca.customers_customerId
JOIN products p ON ca.products_productId = p.productId
JOIN customers c ON ca.customers_customerId = c.customerId
ORDER BY orderId, oi.orderitemsId;

SELECT 
    SUM(oi.productQty * p.productPrice) AS totalSales
FROM orders o
JOIN orderitems oi ON oi.orders_orderId = o.orderId
JOIN cart ca ON oi.cart_cartId = ca.cartId
    AND oi.cart_products_productId = ca.products_productId
    AND oi.cart_customers_customerId = ca.customers_customerId
JOIN products p ON ca.products_productId = p.productId;
--WHERE o.orderStatus = 'Completed';

ALTER TABLE sales ADD COLUMN orderId INT UNIQUE;
ALTER TABLE sales
ADD CONSTRAINT fk_sales_order
FOREIGN KEY (orderId) REFERENCES orders(orderId)
ON DELETE CASCADE
ON UPDATE CASCADE;
-- This may vary by your DB setup
ALTER TABLE orders DROP FOREIGN KEY sales_salesId;
ALTER TABLE orders DROP COLUMN sales_salesId;

SELECT 
                        ca.cartId,
                        c.customerId,
                        p.productName,
                        p.productPrice,
                        ca.productQty
                     FROM customers c
                     INNER JOIN cart ca ON c.customerId = ca.customers_customerId
                     INNER JOIN products p ON ca.products_productId = p.productId
                     LEFT JOIN orderitems oi ON ca.cartId = oi.cart_cartId
                     WHERE oi.cart_cartId IS NULL
                     ORDER BY p.productId;

                
SELECT 
    ca.cartId,
    c.customerId,
    p.productName,
    p.productPrice,
    ca.productQty - IFNULL(SUM(oi.productQty), 0) AS remainingQty
FROM cart ca
INNER JOIN customers c ON ca.customers_customerId = c.customerId
INNER JOIN products p ON ca.products_productId = p.productId
LEFT JOIN orderitems oi ON ca.cartId = oi.cart_cartId
GROUP BY ca.cartId
HAVING remainingQty > 0
ORDER BY p.productId;

-- Delete in correct order (child tables first)
DELETE FROM orderitems;
DELETE FROM orders;
DELETE FROM sales;
DELETE FROM cart;

-- Optional: Reset auto-increment counters
ALTER TABLE orderitems AUTO_INCREMENT = 1;
ALTER TABLE orders AUTO_INCREMENT = 1;
ALTER TABLE sales AUTO_INCREMENT = 1;
ALTER TABLE cart AUTO_INCREMENT = 1;

ALTER TABLE users ADD COLUMN userRole ENUM('admin', 'customer') DEFAULT 'customer';
ALTER TABLE users MODIFY COLUMN userRole ENUM('admin', 'customer') NOT NULL DEFAULT 'customer';

DELETE FROM customers;
DELETE FROM users;
ALTER TABLE customers AUTO_INCREMENT = 1;
ALTER TABLE users AUTO_INCREMENT = 1;

ALTER TABLE users MODIFY password CHAR(64);



-- Remove cart-related columns from orderitems
ALTER TABLE orderitems 
DROP FOREIGN KEY orderitems_ibfk_2,  -- cart_cartId foreign key
DROP FOREIGN KEY orderitems_ibfk_3,  -- cart_products_productId foreign key  
DROP FOREIGN KEY orderitems_ibfk_4;  -- cart_customers_customerId foreign key

-- Drop the cart-related columns
ALTER TABLE orderitems 
DROP COLUMN cart_cartId,
DROP COLUMN cart_products_productId,
DROP COLUMN cart_customers_customerId;

-- Keep only these columns:
-- orderItemsId (PK)
-- productQty
-- orders_orderId (FK to orders)

-- Remove sales foreign key from orders
ALTER TABLE orders 
DROP FOREIGN KEY orders_ibfk_2;  -- sales_salesId foreign key

-- Drop the sales_salesId column
ALTER TABLE orders 
DROP COLUMN sales_salesId;

-- Keep only these columns:
-- orderId (PK)
-- orderDate
-- orderStatus


CREATE TABLE orderitems (
    orderItemsId INT AUTO_INCREMENT PRIMARY KEY,
    productQty INT NOT NULL,
    orders_orderId INT NOT NULL,
    FOREIGN KEY (orders_orderId) REFERENCES orders(orderId)
);

CREATE TABLE orders (
    orderId INT AUTO_INCREMENT PRIMARY KEY,
    orderDate DATE NOT NULL,
    orderStatus VARCHAR(45) NOT NULL
);

CREATE TABLE sales (
    salesId INT AUTO_INCREMENT PRIMARY KEY,
    salesDate DATE NOT NULL,
    orderId INT UNIQUE NOT NULL,
    FOREIGN KEY (orderId) REFERENCES orders(orderId)
);

CREATE TABLE cart (
    cartId INT AUTO_INCREMENT PRIMARY KEY,
    products_productId INT NOT NULL,
    customers_customerId INT NOT NULL,
    productQty INT,
    FOREIGN KEY (products_productId) REFERENCES products(productId),
    FOREIGN KEY (customers_customerId) REFERENCES customers(customerId)
);


DESCRIBE cart;             
DESCRIBE customers;        
DESCRIBE expenses;         
DESCRIBE inventory;        
DESCRIBE orderitems;       
DESCRIBE orders;           
DESCRIBE productcategories;
DESCRIBE products;         
DESCRIBE sales;            
DESCRIBE suppliers;        
DESCRIBE users;       

-- Fix expenses table (add missing fields)
ALTER TABLE expenses ADD COLUMN expenseDescription VARCHAR(255) NOT NULL;
ALTER TABLE expenses ADD COLUMN expenseAmount DECIMAL(10,2) NOT NULL;

-- Fix customers table (phone should be VARCHAR)
ALTER TABLE customers MODIFY COLUMN customerPhone VARCHAR(20);

-- Expand users table roles
ALTER TABLE users MODIFY COLUMN userRole ENUM('admin', 'inventory_manager', 'order_manager', 'financial_auditor', 'customer') DEFAULT 'customer';


UPDATE users
SET userRole = 'admin'
WHERE userId = 2;
INSERT INTO admin_users (userId, adminRole, fullName, email, phone) VALUES (2, 'super_admin', (SELECT CONCAT(customerLname, ' ', customerFname) FROM customers WHERE customerId = 2), 'queenlilith@gmail.com', (SELECT customerPhone FROM customers WHERE customerId = 2));

SHOW TABLES;
