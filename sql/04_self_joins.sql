-- =====================================
-- Self Join Examples
-- Queries joining a table to itself
-- Useful for hierarchical data, comparisons
-- =====================================

-- 1. Find employees and their managers
-- Joining the employees table to itself
SELECT e.name AS employee_name, m.name AS manager_name
FROM employees e
JOIN employees m
  ON e.manager_id = m.employee_id;

-- 2. Find pairs of employees in the same department
-- Joining the employees table to itself to compare department_id
SELECT e1.name AS employee1, e2.name AS employee2, e1.department_id
FROM employees e1
JOIN employees e2
  ON e1.department_id = e2.department_id
 AND e1.employee_id < e2.employee_id;

-- 3. Find products that have the same price
-- Joining the products table to itself to find duplicates by price
SELECT p1.product_name AS product1, p2.product_name AS product2, p1.price
FROM products p1
JOIN products p2
  ON p1.price = p2.price
 AND p1.product_id < p2.product_id;

-- 4. Find employees who joined the company on the same date
-- Useful for finding cohorts
SELECT e1.name AS employee1, e2.name AS employee2, e1.hire_date
FROM employees e1
JOIN employees e2
  ON e1.hire_date = e2.hire_date
 AND e1.employee_id < e2.employee_id;

 -- 5. Find orders placed on the same day
-- Joining orders table to itself to find orders with the same order_date
SELECT o1.order_id AS order1, o2.order_id AS order2, o1.order_date
FROM orders o1
JOIN orders o2
  ON o1.order_date = o2.order_date
 AND o1.order_id < o2.order_id;

 