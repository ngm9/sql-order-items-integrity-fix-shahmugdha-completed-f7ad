-- ============================================================
-- DATA CLEANUP SCRIPT
-- Run BEFORE adding constraints
-- ============================================================

BEGIN;

-- Step 1: Remove order_items referencing non-existent orders
DELETE FROM order_items
WHERE order_id NOT IN (SELECT order_id FROM orders);

-- Step 2: Remove order_items referencing non-existent products
DELETE FROM order_items
WHERE product_id NOT IN (SELECT product_id FROM products);

-- Step 3: Remove order_items with zero or negative quantity
DELETE FROM order_items
WHERE quantity <= 0;

-- Step 4: Remove orders referencing non-existent customers
DELETE FROM order_items
WHERE order_id IN (
    SELECT o.order_id FROM orders o
    WHERE o.customer_id NOT IN (SELECT customer_id FROM customers)
);

DELETE FROM orders
WHERE customer_id NOT IN (SELECT customer_id FROM customers);

-- ============================================================
-- VERIFICATION: confirm cleanup worked
-- ============================================================

-- Should return 0 rows: no orphan order_items -> orders
SELECT oi.order_item_id, oi.order_id
FROM order_items oi
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Should return 0 rows: no orphan order_items -> products
SELECT oi.order_item_id, oi.product_id
FROM order_items oi
LEFT JOIN products p ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Should return 0 rows: no invalid quantities
SELECT order_item_id, quantity
FROM order_items
WHERE quantity <= 0;

-- Should return 0 rows: no orphan orders -> customers
SELECT o.order_id, o.customer_id
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

COMMIT;
