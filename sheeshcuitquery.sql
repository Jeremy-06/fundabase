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
JOIN suppliers s ON i.suppliers_supplierId = s.supplierId;


--try nga mag pull request
