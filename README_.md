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

```
customers     — stores customer profile information
products      — stores product catalog with pricing and stock
orders        — stores order headers linked to customers
order_items   — stores line items linking orders to products
```

### Table Relationships

```
customers  (1) ──── (M)  orders
orders     (1) ──── (M)  order_items
products   (1) ──── (M)  order_items
```

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
- Sorted products by price descending
- Grouped orders by customer and products by category
- Used `HAVING` to filter aggregated groups

### 2. Aggregate Functions — SUM, AVG, MIN, MAX
- Calculated total revenue from all order items
- Computed average order value per order
- Found average, min, and max price per product category
- Ranked products by total quantity sold

### 3. JOINs — INNER JOIN, LEFT JOIN
- Joined `orders` with `customers` to display customer names on orders
- Used LEFT JOIN to list all customers including those with no orders
- Multi-table JOIN across all 4 tables for a full order breakdown

### 4. Subqueries
- Identified products priced above the overall average
- Used correlated subqueries to find the most expensive product per category

### 5. Views
- Created `product_sales_summary` view for reusable revenue analysis
- Queried the view to rank products by total revenue

---

## Sample Queries

**Total revenue:**
```sql
SELECT SUM(quantity * unit_price) AS total_revenue
FROM order_items;
```

**Top customers by spending:**
```sql
SELECT c.name_, SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;
```

**Products above average price:**
```sql
SELECT name_, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);
```

---

## Key Insights

- **Laptop Pro** generates the highest individual revenue at ₹75,000 per unit
- **Electronics** is the dominant category with 3 out of 5 products
- **Priya Sharma** is the top customer with 2 delivered orders
- Total dataset revenue across all orders is **₹93,950**
- 4 out of 5 customers have placed at least one order

---

## How to Run

```bash
# 1. Log into MySQL
mysql -u root -p

# 2. Run the SQL file
source analysis.sql;

# 3. Or import via MySQL Workbench:
#    File > Open SQL Script > analysis.sql > Execute
```

---

## Author

**[Your Name]**  
Data Analyst Intern — Elevate Labs  
Task 3: SQL for Data Analysis
