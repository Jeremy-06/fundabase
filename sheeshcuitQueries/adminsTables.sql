-- =====================================================
-- COMPLETE DATABASE QUERIES FOR ALL ADMIN ROLES
-- =====================================================

-- =====================================================
-- 1. SUPER ADMIN - FULL ACCESS TO ALL TABLES
-- =====================================================

-- User Management (2 tables joined)
SELECT u.userId, u.username, u.userRole, 
       au.adminId, au.adminRole, au.fullName, au.email, au.isActive
FROM users u
JOIN admin_users au ON u.userId = au.userId;

-- Product Management (4 tables joined)
SELECT p.productId, p.productName, p.productPrice, p.productCategories_categoryId,
       pc.categoryId, pc.category,
       i.inventoryId, i.productStock, i.products_productId, i.suppliers_supplierId,
       s.supplierId, s.supplierName
FROM products p
JOIN productcategories pc ON p.productCategories_categoryId = pc.categoryId
JOIN inventory i ON p.productId = i.products_productId
JOIN suppliers s ON i.suppliers_supplierId = s.supplierId;

-- Order Management (4 tables joined)
SELECT o.orderId, o.orderDate, o.orderStatus, o.customers_customerId,
       oi.orderItemsId, oi.productQty, oi.orders_orderId, oi.products_productId,
       p.productId, p.productName, p.productPrice, p.productCategories_categoryId,
       c.customerId, c.customerFname, c.customerLname, c.customerAddress, c.customerPhone, c.userId
FROM orders o
JOIN orderitems oi ON o.orderId = oi.orders_orderId
JOIN products p ON oi.products_productId = p.productId
JOIN customers c ON o.customers_customerId = c.customerId;

-- Financial Management (3 tables joined)
SELECT s.salesId, s.salesDate, s.orderId,
       o.orderId, o.orderDate, o.orderStatus, o.customers_customerId,
       c.customerId, c.customerFname, c.customerLname, c.customerAddress, c.customerPhone, c.userId
FROM sales s
JOIN orders o ON s.orderId = o.orderId
JOIN customers c ON o.customers_customerId = c.customerId;

-- =====================================================
-- 2. INVENTORY MANAGER - 4 TABLES (FULL MODIFY) + 3 TABLES (READ ONLY)
-- =====================================================

-- Product Management (4 tables joined - FULL MODIFY)
SELECT p.productId, p.productName, p.productPrice, p.productCategories_categoryId,
       pc.categoryId, pc.category,
       i.inventoryId, i.productStock, i.products_productId, i.suppliers_supplierId,
       s.supplierId, s.supplierName
FROM products p
JOIN productcategories pc ON p.productCategories_categoryId = pc.categoryId
JOIN inventory i ON p.productId = i.products_productId
JOIN suppliers s ON i.suppliers_supplierId = s.supplierId;

-- Cart Monitoring (3 tables joined - READ ONLY)
SELECT c.cartId, c.products_productId, c.customers_customerId, c.productQty,
       p.productId, p.productName, p.productPrice, p.productCategories_categoryId,
       cu.customerId, cu.customerFname, cu.customerLname, cu.customerAddress, cu.customerPhone, cu.userId
FROM cart c
JOIN products p ON c.products_productId = p.productId
JOIN customers cu ON c.customers_customerId = cu.customerId;

-- Order Items Monitoring (3 tables joined - READ ONLY)
SELECT oi.orderItemsId, oi.productQty, oi.orders_orderId, oi.products_productId,
       p.productId, p.productName, p.productPrice, p.productCategories_categoryId,
       o.orderId, o.orderDate, o.orderStatus, o.customers_customerId
FROM orderitems oi
JOIN products p ON oi.products_productId = p.productId
JOIN orders o ON oi.orders_orderId = o.orderId;

-- =====================================================
-- 3. ORDER MANAGER - 3 TABLES (FULL MODIFY) + 3 TABLES (READ ONLY)
-- =====================================================

--data1
-- Order Processing (3 tables joined - FULL MODIFY)
SELECT o.orderId, o.orderDate, o.orderStatus, o.customers_customerId,
       oi.orderItemsId, oi.productQty, oi.orders_orderId, oi.products_productId,
       s.salesId, s.salesDate, s.orderId
FROM orders o
JOIN orderitems oi ON o.orderId = oi.orders_orderId
LEFT JOIN sales s ON o.orderId = s.orderId;
--data2
-- Customer Order Management (4 tables joined - MODIFY orders/orderitems/sales, READ customers/products)
SELECT o.orderId, o.orderDate, o.orderStatus, o.customers_customerId,
       oi.orderItemsId, oi.productQty, oi.orders_orderId, oi.products_productId,
       c.customerId, c.customerFname, c.customerLname, c.customerAddress, c.customerPhone, c.userId,
       p.productId, p.productName, p.productPrice, p.productCategories_categoryId
FROM orders o
JOIN orderitems oi ON o.orderId = oi.orders_orderId
JOIN customers c ON o.customers_customerId = c.customerId
JOIN products p ON oi.products_productId = p.productId;
--data3
-- Cart Monitoring (3 tables joined - READ ONLY)
SELECT c.cartId, c.products_productId, c.customers_customerId, c.productQty,
       p.productId, p.productName, p.productPrice, p.productCategories_categoryId,
       cu.customerId, cu.customerFname, cu.customerLname, cu.customerAddress, cu.customerPhone, cu.userId
FROM cart c
JOIN products p ON c.products_productId = p.productId
JOIN customers cu ON c.customers_customerId = cu.customerId;

-- =====================================================
-- 4. FINANCIAL AUDITOR - 2 TABLES (FULL MODIFY) + 4 TABLES (READ ONLY)
-- =====================================================

-- Financial Management (2 tables joined - FULL MODIFY)
SELECT s.salesId, s.salesDate, s.orderId,
       e.expensesId, e.expenseDate, e.expenseDescription, e.expenseAmount
FROM sales s
CROSS JOIN expenses e
WHERE DATE(s.salesDate) = DATE(e.expenseDate);

-- Revenue Analysis (4 tables joined - READ ONLY)
SELECT s.salesId, s.salesDate, s.orderId,
       o.orderId, o.orderDate, o.orderStatus, o.customers_customerId,
       oi.orderItemsId, oi.productQty, oi.orders_orderId, oi.products_productId,
       p.productId, p.productName, p.productPrice, p.productCategories_categoryId
FROM sales s
JOIN orders o ON s.orderId = o.orderId
JOIN orderitems oi ON o.orderId = oi.orders_orderId
JOIN products p ON oi.products_productId = p.productId;

-- Customer Financial Analysis (4 tables joined - READ ONLY)
SELECT s.salesId, s.salesDate, s.orderId,
       o.orderId, o.orderDate, o.orderStatus, o.customers_customerId,
       c.customerId, c.customerFname, c.customerLname, c.customerAddress, c.customerPhone, c.userId,
       oi.orderItemsId, oi.productQty, oi.orders_orderId, oi.products_productId
FROM sales s
JOIN orders o ON s.orderId = o.orderId
JOIN customers c ON o.customers_customerId = c.customerId
JOIN orderitems oi ON o.orderId = oi.orders_orderId;

-- Complete Financial Report (5 tables joined - READ ONLY)
SELECT s.salesId, s.salesDate, s.orderId,
       o.orderId, o.orderDate, o.orderStatus, o.customers_customerId,
       oi.orderItemsId, oi.productQty, oi.orders_orderId, oi.products_productId,
       p.productId, p.productName, p.productPrice, p.productCategories_categoryId,
       c.customerId, c.customerFname, c.customerLname, c.customerAddress, c.customerPhone, c.userId
FROM sales s
JOIN orders o ON s.orderId = o.orderId
JOIN orderitems oi ON o.orderId = oi.orders_orderId
JOIN products p ON oi.products_productId = p.productId
JOIN customers c ON o.customers_customerId = c.customerId;





-- =====================================================
-- ADMIN DATASETS
-- =====================================================

-- INVENTORY MANAGER

-- 1. Product Inventory Management (FULL MODIFY)
SELECT 
    p.productId, p.productName, p.productPrice,
    pc.categoryId, pc.category,
    i.inventoryId, i.productStock,
    s.supplierId, s.supplierName
FROM products p
JOIN productcategories pc ON p.productCategories_categoryId = pc.categoryId
JOIN inventory i ON p.productId = i.products_productId
JOIN suppliers s ON i.suppliers_supplierId = s.supplierId;

-- 2. Cart Monitoring (READ ONLY)
SELECT 
    c.cartId, c.products_productId, c.customers_customerId, c.productQty,
    p.productName, p.productPrice,
    cu.customerFname, cu.customerLname, cu.customerAddress, cu.customerPhone
FROM cart c
JOIN products p ON c.products_productId = p.productId
JOIN customers cu ON c.customers_customerId = cu.customerId;

-- 3. Order Items Monitoring (READ ONLY)
SELECT 
    oi.orderItemsId, oi.productQty, oi.orders_orderId, oi.products_productId,
    p.productName, p.productPrice,
    o.orderId, o.orderDate, o.orderStatus, o.customers_customerId
FROM orderitems oi
JOIN products p ON oi.products_productId = p.productId
JOIN orders o ON oi.orders_orderId = o.orderId;

-- ORDER MANAGER

-- 4. Order Processing (FULL MODIFY)
SELECT 
    o.orderId, o.orderDate, o.orderStatus, o.customers_customerId,
    oi.orderItemsId, oi.productQty, oi.products_productId,
    s.salesId, s.salesDate
FROM orders o
JOIN orderitems oi ON o.orderId = oi.orders_orderId
LEFT JOIN sales s ON o.orderId = s.orderId;

-- 5. Orders with Customer Info (READ ONLY)
SELECT 
    o.orderId, o.orderDate, o.orderStatus,
    c.customerId, c.customerFname, c.customerLname, c.customerAddress, c.customerPhone
FROM orders o
JOIN customers c ON o.customers_customerId = c.customerId;

-- FINANCIAL AUDITOR

-- 6. Sales Summary (READ ONLY)
SELECT 
    s.salesId, s.salesDate, o.orderId, o.orderDate, o.orderStatus,
    c.customerId, c.customerFname, c.customerLname,
    SUM(oi.productQty * p.productPrice) AS totalSalesAmount
FROM sales s
JOIN orders o ON s.orderId = o.orderId
JOIN customers c ON o.customers_customerId = c.customerId
JOIN orderitems oi ON o.orderId = oi.orders_orderId
JOIN products p ON oi.products_productId = p.productId
WHERE LOWER(o.orderStatus) = 'completed'
GROUP BY s.salesId, s.salesDate, o.orderId, o.orderDate, o.orderStatus, c.customerId, c.customerFname, c.customerLname;

-- 7. Expenses List (FULL MODIFY)
SELECT 
    expensesId, 
    expenseDate, 
    expenseDescription, 
    expenseAmount
FROM expenses;

-- 8. Net Income Report Summary (READ ONLY)
SELECT
    IFNULL(sales_summary.totalSales, 0) AS totalSales,
    IFNULL(expenses_summary.totalExpenses, 0) AS totalExpenses,
    IFNULL(sales_summary.totalSales, 0) - IFNULL(expenses_summary.totalExpenses, 0) AS netIncome
FROM
    (
        SELECT
            SUM(oi.productQty * p.productPrice) AS totalSales
        FROM sales s
        JOIN orders o ON s.orderId = o.orderId
        JOIN orderitems oi ON o.orderId = oi.orders_orderId
        JOIN products p ON oi.products_productId = p.productId
        WHERE LOWER(o.orderStatus) = 'completed'
    ) AS sales_summary
LEFT JOIN
    (
        SELECT
            SUM(expenseAmount) AS totalExpenses
        FROM expenses
    ) AS expenses_summary ON 1=1;

-- =====================================================
-- SUMMARY TABLE:
-- =====================================================
-- Super Admin: 11 TABLES (ALL TABLES)
-- Inventory Manager: 7 TABLES (4 MODIFY + 3 READ)
-- Order Manager: 6 TABLES (3 MODIFY + 3 READ)  
-- Financial Auditor: 6 TABLES (2 MODIFY + 4 READ)
-- =====================================================



SELECT 
    u.userId,
    u.username,
    u.userRole,
    c.customerId,
    c.customerFname,
    c.customerLname,
    c.customerAddress,
    c.customerPhone
FROM users u
LEFT JOIN customers c ON u.userId = c.userId
WHERE u.userRole = 'customer'
ORDER BY u.userId;


SELECT 
    u.userId,
    u.username,
    u.userRole,
    a.adminId,
    a.adminRole,
    a.fullName,
    a.email,
    a.phone,
    a.isActive,
    a.lastLogin,
    a.createdAt
FROM users u
LEFT JOIN admin_users a ON u.userId = a.userId
WHERE u.userRole IN ('admin', 'inventory_manager', 'order_manager', 'financial_auditor')
ORDER BY u.userId;


