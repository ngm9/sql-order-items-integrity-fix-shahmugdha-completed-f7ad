SELECT oi.order_item_id, oi.order_id, oi.product_id, oi.quantity
FROM order_items oi
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

SELECT oi.order_item_id, oi.order_id, oi.product_id, oi.quantity
FROM order_items oi
LEFT JOIN products p ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

SELECT c.customer_id,
       c.full_name,
       SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.full_name
ORDER BY total_spent DESC NULLS LAST;
