-- =====================================================
-- RAW MYSQL QUERIES USED IN CART, CHECKOUT, AND ORDERS
-- =====================================================

-- =====================================================
-- 1. CART FORM (cart.vb) QUERIES
-- =====================================================

-- Main Cart Query (when user is logged in):
SELECT 
    ca.cartId,
    c.customerId,
    p.productName,
    p.productPrice,
    ca.productQty AS remainingQty
FROM cart ca
INNER JOIN customers c ON ca.customers_customerId = c.customerId
INNER JOIN products p ON ca.products_productId = p.productId
WHERE c.customerId = 1
ORDER BY p.productName;

-- Empty Cart Query (when user is not logged in):
SELECT 
    NULL as cartId,
    NULL as customerId,
    'No items in cart' as productName,
    0 as productPrice,
    0 as remainingQty
WHERE 1 = 0;

-- Product Image Query:
SELECT productId FROM products WHERE productName = 'Resistor 10k';

-- Check Existing Checkout Item Query:
SELECT oi.orderItemsId, oi.productQty, o.orderId 
FROM orderitems oi 
INNER JOIN orders o ON oi.orders_orderId = o.orderId 
WHERE o.customers_customerId = 1 
AND o.orderStatus = 'checkout' 
AND oi.products_productId = 1;

-- Update Checkout Item Query:
UPDATE orderitems SET productQty = 5 WHERE orderItemsId = 1;

-- Create New Checkout Order Query:
INSERT INTO orders (orderDate, orderStatus, customers_customerId) VALUES (CURDATE(), 'checkout', 1);

-- Add to OrderItems Query:
INSERT INTO orderitems (productQty, orders_orderId, products_productId) VALUES (2, 1, 1);

-- Update Cart Quantity Query:
UPDATE cart SET productQty = 3 WHERE cartId = 1;

-- Delete Cart Item Query:
DELETE FROM cart WHERE cartId = 1;

-- =====================================================
-- 2. CHECKOUT FORM (checkout.vb) QUERIES
-- =====================================================

-- Load Checkout Items Query:
SELECT 
    o.orderId,
    o.orderDate,
    o.orderStatus,
    p.productId,
    p.productName,
    p.productPrice,
    oi.productQty,
    (p.productPrice * oi.productQty) AS totalPrice
FROM orders o
INNER JOIN orderitems oi ON o.orderId = oi.orders_orderId
INNER JOIN products p ON oi.products_productId = p.productId
WHERE o.customers_customerId = 1 AND o.orderStatus = 'checkout'
ORDER BY o.orderDate DESC, p.productName;

-- Create Paid Order Query:
INSERT INTO orders (orderDate, orderStatus, customers_customerId) VALUES (CURDATE(), 'paid', 1);

-- Get Last Insert ID Query:
SELECT LAST_INSERT_ID();

-- Update OrderItems to New Order Query:
UPDATE orderitems SET orders_orderId = 2 WHERE orders_orderId = 1 AND products_productId = 1;

-- Delete Empty Checkout Orders Query:
DELETE FROM orders WHERE customers_customerId = 1 AND orderStatus = 'checkout' AND orderId NOT IN (SELECT DISTINCT orders_orderId FROM orderitems);

-- Check Existing Cart Item Query:
SELECT cartId, productQty FROM cart WHERE customers_customerId = 1 AND products_productId = 1;

-- Update Cart Quantity Query:
UPDATE cart SET productQty = 5 WHERE cartId = 1;

-- Add New Cart Item Query:
INSERT INTO cart (products_productId, customers_customerId, productQty) VALUES (1, 1, 2);

-- Delete OrderItems Query:
DELETE FROM orderitems WHERE orders_orderId = 1 AND products_productId = 1;

-- =====================================================
-- 3. ORDERS FORM (orders.vb) QUERIES
-- =====================================================

-- Load Orders Query (all orders):
SELECT 
    o.orderId,
    p.productName,
    oi.productQty AS numberOfItems,
    p.productPrice,
    (p.productPrice * oi.productQty) AS itemTotal,
    o.orderDate,
    o.orderStatus
FROM orders o
INNER JOIN customers c ON o.customers_customerId = c.customerId
INNER JOIN orderitems oi ON o.orderId = oi.orders_orderId
INNER JOIN products p ON oi.products_productId = p.productId
WHERE o.customers_customerId = 1
ORDER BY o.orderDate DESC, o.orderId, p.productName;

-- Load Orders Query (filtered by status):
SELECT 
    o.orderId,
    p.productName,
    oi.productQty AS numberOfItems,
    p.productPrice,
    (p.productPrice * oi.productQty) AS itemTotal,
    o.orderDate,
    o.orderStatus
FROM orders o
INNER JOIN customers c ON o.customers_customerId = c.customerId
INNER JOIN orderitems oi ON o.orderId = oi.orders_orderId
INNER JOIN products p ON oi.products_productId = p.productId
WHERE o.customers_customerId = 1 AND o.orderStatus = 'paid'
ORDER BY o.orderDate DESC, o.orderId, p.productName;

-- Cancel Order Query:
UPDATE orders SET orderStatus = 'cancelled' WHERE orderId = 1;

-- =====================================================
-- QUERY SUMMARY:
-- =====================================================
-- Cart Form: Display user's cart items (cart, customers, products tables)
-- Checkout Form: Process checkout items to paid orders (orders, orderitems, products tables)
-- Orders Form: Display and manage all user orders (orders, orderitems, products, customers tables)
-- =====================================================