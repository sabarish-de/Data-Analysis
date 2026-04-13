# Task 3 — SQL for Data Analysis

**Elevate Labs Data Analyst Internship**

---

## Objective

Use SQL queries to extract and analyze data from a relational ecommerce database, demonstrating proficiency in querying, aggregation, joins, subqueries, views, and indexing.

---

## Tools Used

- **Database:** MySQL
- **Interface:** MySQL Workbench

---

## Database Schema

The database `ecommerce_db` consists of 4 tables:


customers     — stores customer profile information
products      — stores product catalog with pricing and stock
orders        — stores order headers linked to customers
order_items   — stores line items linking orders to products


### Table Relationships

customers  (1) ──── (M)  orders
orders     (1) ──── (M)  order_items
products   (1) ──── (M)  order_items


---

## Files in This Repository

| File | Description |
|------|-------------|
| `analysis.sql` | All SQL queries covering schema creation, data insertion, and analysis |
| `README.md` | Project documentation |

---

## Concepts Demonstrated

### 1. SELECT, WHERE, ORDER BY, GROUP BY
- Retrieved all customers and filtered products by category
  <img width="498" height="160" alt="Screenshot 2026-04-13 203506" src="https://github.com/user-attachments/assets/f15ce55e-db80-4b93-8622-439e0c2f3a33" />

- Sorted products by price descending
  <img width="362" height="123" alt="Screenshot 2026-04-13 203528" src="https://github.com/user-attachments/assets/e0a01848-e467-4fbc-bc97-64c26e52ef12" />

- Grouped orders by customer and products by category
  <img width="235" height="106" alt="Screenshot 2026-04-13 203559" src="https://github.com/user-attachments/assets/17dedb8b-1705-4b64-933e-10470fde60e1" />

- Used `HAVING` to filter aggregated groups
  <img width="196" height="134" alt="Screenshot 2026-04-13 203945" src="https://github.com/user-attachments/assets/2a7e5fa6-8952-41b6-8d54-ab4abdb6cfd2" />


### 2. Aggregate Functions — SUM, AVG, MIN, MAX
- Calculated total revenue from all order items
  <img width="199" height="115" alt="Screenshot 2026-04-13 204004" src="https://github.com/user-attachments/assets/716b856e-083e-4f7b-aadb-7b153739b990" />

- Computed average order value per order
  <img width="190" height="77" alt="Screenshot 2026-04-13 204020" src="https://github.com/user-attachments/assets/00a5967e-60d4-4c15-94ad-71d83fb6f905" />

- Found average, min, and max price per product category
  <img width="123" height="70" alt="Screenshot 2026-04-13 204049" src="https://github.com/user-attachments/assets/7e91f38b-e225-41eb-8e1b-2a4ea8bf9b07" />

- Ranked products by total quantity sold
  <img width="162" height="122" alt="Screenshot 2026-04-13 204109" src="https://github.com/user-attachments/assets/0ef78043-de25-45a5-9b4f-7f652cba683c" />


### 3. JOINs — INNER JOIN, LEFT JOIN
- Joined `orders` with `customers` to display customer names on orders
 <img width="320" height="119" alt="Screenshot 2026-04-13 204223" src="https://github.com/user-attachments/assets/a2dfb8cc-41f4-4a9e-87d2-9db75905ff45" />

- Used LEFT JOIN to list all customers including those with no orders
<img width="292" height="129" alt="Screenshot 2026-04-13 204341" src="https://github.com/user-attachments/assets/c3cc98de-2ced-411e-9901-a633f4672e38" />


### 4. Subqueries

- Used correlated subqueries to find the most expensive product per category
  <img width="167" height="47" alt="Screenshot 2026-04-13 204402" src="https://github.com/user-attachments/assets/f186c68c-7d1d-4748-ba49-45e156082315" />


### 5. Views
- Created `product_sales_summary` view for reusable revenue analysis
- Queried the view to rank products by total revenue
  <img width="351" height="125" alt="Screenshot 2026-04-13 204448" src="https://github.com/user-attachments/assets/44ccc217-e3d3-4a5d-be73-6f622168b2fa" />


---

## Sample Queries

**Total revenue:**
 sql
SELECT SUM(quantity * unit_price) AS total_revenue
FROM order_items;


**Top customers by spending:**
 sql
SELECT c.name_, SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;


**Products above average price:**
sql
SELECT name_, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);


---

## Key Insights

- **Laptop Pro** generates the highest individual revenue at ₹75,000 per unit
- **Electronics** is the dominant category with 3 out of 5 products
- **Priya Sharma** is the top customer with 2 delivered orders
- Total dataset revenue across all orders is **₹93,950**
- 4 out of 5 customers have placed at least one order

---

## How to Run

bash
# 1. Log into MySQL
mysql -u root -p

# 2. Run the SQL file
source analysis.sql;

# 3. Or import via MySQL Workbench:
#    File > Open SQL Script > analysis.sql > Execute


---

## Author

**[Sabarish P]**  
Data Analyst Intern — Elevate Labs  
Task 3: SQL for Data Analysis
