CREATE DATABASE utkrusht_store;
\connect utkrusht_store;

CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY,
  full_name TEXT NOT NULL,
  email TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE products (
  product_id SERIAL PRIMARY KEY,
  product_name TEXT NOT NULL,
  category TEXT NOT NULL,
  unit_price NUMERIC(10,2) NOT NULL
);

CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  order_date DATE NOT NULL,
  status TEXT NOT NULL
);

CREATE TABLE order_items (
  order_item_id SERIAL,
  order_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  unit_price NUMERIC(10,2) NOT NULL
);

INSERT INTO customers (full_name, email, created_at) VALUES
('Alice Sharma', 'alice@example.com', '2023-11-01'),
('Ben Kumar', 'ben@example.com', '2023-11-05'),
('Chetan Rao', 'chetan@example.com', '2023-12-01'),
('Divya Singh', 'divya@example.com', '2023-12-10'),
('Esha Patel', 'esha@example.com', '2024-01-02');

INSERT INTO products (product_name, category, unit_price) VALUES
('Wireless Mouse', 'Electronics', 799.00),
('Mechanical Keyboard', 'Electronics', 3499.00),
('USB-C Cable', 'Accessories', 299.00),
('Laptop Stand', 'Accessories', 1499.00),
('Notebook', 'Stationery', 99.00),
('Pen Set', 'Stationery', 199.00);

INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2024-01-10', 'shipped'),
(1, '2024-01-15', 'shipped'),
(2, '2024-01-18', 'pending'),
(3, '2024-01-20', 'shipped'),
(4, '2024-01-25', 'cancelled'),
(5, '2024-02-02', 'shipped'),
(2, '2024-02-05', 'shipped'),
(3, '2024-02-07', 'pending');

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 2, 799.00),
(1, 3, 1, 299.00),
(2, 2, 1, 3499.00),
(2, 3, 0, 299.00),
(3, 4, 1, 1499.00),
(3, 5, -2, 99.00),
(4, 1, 1, 799.00),
(5, 2, 1, 3499.00),
(6, 6, 3, 199.00),
(7, 3, 1, 299.00),
(9, 1, 1, 799.00),
(6, 10, 1, 199.00);
