-- ============================================================
-- CONSTRAINTS & INDEXES SCRIPT
-- Run AFTER cleanup.sql
-- ============================================================

BEGIN;

-- 1. Primary key on order_items
ALTER TABLE order_items
ADD CONSTRAINT pk_order_items PRIMARY KEY (order_item_id);

-- 2. Foreign key: order_items.order_id -> orders.order_id
ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_order
FOREIGN KEY (order_id) REFERENCES orders(order_id);

-- 3. Foreign key: order_items.product_id -> products.product_id
ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_product
FOREIGN KEY (product_id) REFERENCES products(product_id);

-- 4. Check constraint: quantity must be > 0
ALTER TABLE order_items
ADD CONSTRAINT chk_quantity_positive CHECK (quantity > 0);

-- 5. Foreign key: orders.customer_id -> customers.customer_id
ALTER TABLE orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

-- 6. Index on orders.status
CREATE INDEX idx_orders_status ON orders(status);

-- 7. Indexes on order_items.quantity and order_items.unit_price
CREATE INDEX idx_order_items_quantity ON order_items(quantity);
CREATE INDEX idx_order_items_unit_price ON order_items(unit_price);

COMMIT;

-- ============================================================
-- VERIFICATION: confirm constraints are in place
-- ============================================================

-- Should fail: order_id 999 doesn't exist
-- INSERT INTO order_items (order_id, product_id, quantity, unit_price)
-- VALUES (999, 1, 1, 799.00);

-- Should fail: product_id 999 doesn't exist
-- INSERT INTO order_items (order_id, product_id, quantity, unit_price)
-- VALUES (1, 999, 1, 799.00);

-- Should fail: quantity <= 0
-- INSERT INTO order_items (order_id, product_id, quantity, unit_price)
-- VALUES (1, 1, -1, 799.00);

-- Should fail: customer_id 999 doesn't exist
-- INSERT INTO orders (customer_id, order_date, status)
-- VALUES (999, '2024-03-01', 'pending');

-- ============================================================
-- FINAL VERIFICATION QUERY (JOIN across 3 tables)
-- Confirms all order_items have valid orders and products,
-- and all quantities are positive.
-- ============================================================
SELECT
    oi.order_item_id,
    o.order_id,
    o.status,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    (oi.quantity * oi.unit_price) AS line_total
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id
ORDER BY o.order_id, oi.order_item_id;
