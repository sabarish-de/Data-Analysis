create database ecommerce_db;
use ecommerce_db;

create table customers(
  customer_id int primary key AUTO_INCREMENT,
  name_ varchar(30),
  email varchar(50),
  city varchar(50),
  country varchar(50),
  created_at date default (current_date)
);

CREATE TABLE products (
    product_id    INT PRIMARY KEY AUTO_INCREMENT,
    name_         VARCHAR(100) NOT NULL,
    category      VARCHAR(50),
    price         DECIMAL(10,2) NOT NULL,
    stock         INT DEFAULT 0
);


CREATE TABLE orders (
    order_id      INT PRIMARY KEY AUTO_INCREMENT,
    customer_id   INT,
    order_date    DATE DEFAULT (CURRENT_DATE),
    status        ENUM('pending','shipped','delivered','cancelled'),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id       INT PRIMARY KEY AUTO_INCREMENT,
    order_id      INT,
    product_id    INT,
    quantity      INT NOT NULL,
    unit_price    DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers (name_, email, city, country) VALUES
  ('Priya Sharma',  'priya@email.com',   'Mumbai',    'India'),
  ('Arjun Mehta',   'arjun@email.com',   'Delhi',     'India'),
  ('Sara Ali',      'sara@email.com',    'Bangalore', 'India'),
  ('Ravi Kumar',    'ravi@email.com',    'Chennai',   'India'),
  ('Ananya Das',    'ananya@email.com',  'Kolkata',   'India');

INSERT INTO products (name_, category, price, stock) VALUES
  ('Laptop Pro',     'Electronics', 75000.00, 50),
  ('Wireless Mouse', 'Electronics',  1200.00, 200),
  ('Office Chair',   'Furniture',   12000.00, 30),
  ('Notebook Set',   'Stationery',    350.00, 500),
  ('USB-C Hub',      'Electronics',  2500.00, 150);

INSERT INTO orders (customer_id, order_date, status) VALUES
  (1, '2024-01-10', 'delivered'),
  (2, '2024-01-15', 'shipped'),
  (3, '2024-02-01', 'delivered'),
  (4, '2024-02-20', 'pending'),
  (1, '2024-03-05', 'delivered');

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
  (1, 1, 1, 75000.00),
  (1, 2, 2,  1200.00),
  (2, 3, 1, 12000.00),
  (3, 4, 5,   350.00),
  (4, 5, 2,  2500.00),
  (5, 2, 1,  1200.00);
  
SHOW TABLES;                      
SELECT COUNT(*) FROM customers;   
SELECT COUNT(*) FROM products;    
SELECT * FROM order_items;  

-- 1. View all customers
SELECT * FROM customers;

-- 2. View all products in Electronics category
SELECT * FROM products
WHERE category = 'Electronics';

-- 3. Products priced above 2000, sorted by price descending
SELECT name_, category, price
FROM products
WHERE price > 2000
ORDER BY price DESC;

-- 4. Total orders per customer
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id;

-- 5. Number of products per category
SELECT category, COUNT(*) AS product_count
FROM products
GROUP BY category;

-- 6. Only categories with more than 1 product (HAVING)
SELECT category, COUNT(*) AS product_count
FROM products
GROUP BY category
HAVING COUNT(*) > 1;

-- 7. Total revenue from all order items
SELECT SUM(quantity * unit_price) AS total_revenue
FROM order_items;

-- 8. Average order value per order
SELECT order_id,
       SUM(quantity * unit_price) AS order_total
FROM order_items
GROUP BY order_id;

-- 9. Average product price per category
SELECT category,
       ROUND(AVG(price), 2) AS avg_price,
       MIN(price)           AS min_price,
       MAX(price)           AS max_price
FROM products
GROUP BY category;

-- 10. Total quantity sold per product
SELECT product_id,
       SUM(quantity) AS total_qty_sold
FROM order_items
GROUP BY product_id
ORDER BY total_qty_sold DESC;    

-- 11. INNER JOIN: Orders with customer names
SELECT o.order_id, c.name_ AS customer_name,
       o.order_date, o.status
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

-- 12. LEFT JOIN: All customers including those with no orders
SELECT c.name_, c.city, o.order_id, o.status
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- 13. Products priced above the average price
SELECT name_, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- 14. Create a view: product sales summary
CREATE VIEW product_sales_summary AS
SELECT p.name_       AS product_name,
       p.category,
       SUM(oi.quantity)                  AS units_sold,
       SUM(oi.quantity * oi.unit_price)  AS total_revenue
FROM products p
INNER JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name_, p.category;

-- 15. Query the view
SELECT * FROM product_sales_summary ORDER BY total_revenue DESC;


  
  