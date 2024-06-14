--QUESTION 1

create database for_employees;
use for_employees;

--showing the tables in the database

SELECT * FROM INFORMATION_SCHEMA.TABLES ;
GO

SELECT * FROM Sys.Tables
GO

SELECT name, database_id, create_date  
FROM sys.databases;  
GO

USE [for_employees];
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';
GO

USE [for_employees];
GO
SELECT * FROM [employees];
GO



select * from employees;
GO

insert into employees(employee_id, employee_name, department_id,salary) values(1, 'John Doe', 1, 100000);
insert into employees(employee_id, employee_name, department_id,salary) values(2, 'Jane smith', 1, 95000);
select *from employees;
insert into employees(employee_id, employee_name, department_id,salary) values(3, 'Alice Brown', 2, 120000);
insert into employees(employee_id, employee_name, department_id,salary) values(4, 'Bob Johnson', 2, 110000);
insert into employees(employee_id, employee_name, department_id,salary) values(5, 'Charlie Black', 3, 80000);

-- Write a query that delivers the names of all employees who
--work in the same department as the employee with the highest salary.

SELECT employee_name
FROM employees
WHERE department_id = (
    SELECT TOP 1 department_id
    FROM employees
    ORDER BY salary DESC
);


--QUESTION 2
CREATE DATABASE for_products;
USE for_products;
CREATE TABLE sales (sales_id INT NOT NULL PRIMARY KEY, product_id INT NOT NULL, sale_date DATETIME NOT NULL, sales_amount INT NOT NULL );

INSERT INTO sales (sales_id, product_id, sale_date, sales_amount) VALUES(1,1,2023-06-01,100);
INSERT INTO sales (sales_id, product_id, sale_date, sales_amount) VALUES(2,1,2023-06-02,150);
INSERT INTO sales (sales_id, product_id, sale_date, sales_amount) VALUES(3,1,2023-06-03,200);
INSERT INTO sales (sales_id, product_id, sale_date, sales_amount) VALUES(4,1,2023-06-04,250);
INSERT INTO sales (sales_id, product_id, sale_date, sales_amount) VALUES(5,1,2023-06-05,300);
INSERT INTO sales (sales_id, product_id, sale_date, sales_amount) VALUES(6,1,2023-06-06,350);
INSERT INTO sales (sales_id, product_id, sale_date, sales_amount) VALUES(7,2,2023-06-07,400);
INSERT INTO sales (sales_id, product_id, sale_date, sales_amount) VALUES(8,2,2023-06-08,450);

SELECT * FROM sales;

--Write a query to calculate the 7-day moving average of sales for each product in a given range using SQL window functions.
SELECT 
    product_id,
    sale_date,
    AVG(sales_amount) OVER (
        PARTITION BY product_id 
        ORDER BY sale_date 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS moving_avg
FROM sales;

--QUESTION 3
CREATE DATABASE for_customers;
USE for_customers;

CREATE TABLE customers(customer_id INT UNIQUE, customer_name VARCHAR(50) NOT NULL);
INSERT INTO customers(customer_id, customer_name)VALUES(1,'Alice');
INSERT INTO customers(customer_id, customer_name)VALUES(2,'Bob');
INSERT INTO customers(customer_id, customer_name)VALUES(3,'Charlie');



CREATE TABLE categories(category_id INT UNIQUE, category_name VARCHAR(50) NOT NULL);
INSERT INTO categories(category_id, category_name)VALUES(1,'Electronics');
INSERT INTO categories(category_id, category_name)VALUES(2,'Clothing');
INSERT INTO categories(category_id, category_name)VALUES(3,'Groceries');
SELECT * FROM categories;



CREATE TABLE purchase(purchase_id INT UNIQUE, customer_id INT NOT NULL, category_id INT NOT NULL);

INSERT INTO purchase(purchase_id, customer_id, category_id) VALUES (1,1,1);
INSERT INTO purchase(purchase_id, customer_id, category_id) VALUES (2,1,2);
INSERT INTO purchase(purchase_id, customer_id, category_id) VALUES (3,1,3);
INSERT INTO purchase(purchase_id, customer_id, category_id) VALUES (4,2,1);
INSERT INTO purchase(purchase_id, customer_id, category_id) VALUES (5,2,2);

SELECT *FROM purchase;
--3. Write a query to find the names of any customers who have made a purchase in all categories.
SELECT customer_name
FROM customers c
WHERE NOT EXISTS (
    SELECT *
    FROM categories cat
    WHERE NOT EXISTS (
        SELECT *
        FROM purchase p
        WHERE p.customer_id = c.customer_id
          AND p.category_id = cat.category_id
    )
);


--QUESTION 4
CREATE TABLE products(product_id INT UNIQUE, product_name VARCHAR(50) NOT NULL, price INT NOT NULL);

INSERT INTO products(product_id, product_name, price) VALUES (1,'Laptop',1000);
INSERT INTO products(product_id, product_name, price) VALUES (2,'Laptop',1200);
INSERT INTO products(product_id, product_name, price) VALUES (3,'Phone',800);
INSERT INTO products(product_id, product_name, price) VALUES (4,'Tablet',600);
INSERT INTO products(product_id, product_name, price) VALUES (5,'Tablet',650);

--. Write a query that retrieves products with the same name but different prices.
SELECT product_name
FROM products
GROUP BY product_name
HAVING COUNT(DISTINCT price) > 1;

--QUESTION 5

CREATE TABLE employees(employee_id INT UNIQUE, employee_name VARCHAR(50) NOT NULL, department_id INT NOT NULL, salary INT NOT NULL);

INSERT INTO employees(employee_id,employee_name, department_id, salary) VALUES (1,'John Doe',1,100000);
INSERT INTO employees(employee_id, employee_name, department_id, salary) VALUES (2,'Jane Smith',1,95000);
INSERT INTO employees(employee_id, employee_name, department_id, salary) VALUES (3,'Alice Brown',2,120000);
INSERT INTO employees(employee_id, employee_name, department_id, salary) VALUES (4,'Bob Johnson',2,110000);
INSERT INTO employees(employee_id, employee_name, department_id, salary) VALUES (5,'Charlie Black',3,80000);

SELECT *FROM employees;

--Write a query that delivers the second-highest salary in an "employees" table.
SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);


SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'sales';
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'customers';


create database customersDb;
use customersDb;
--QUESTION 6
CREATE TABLE customers (
    customer_id INT UNIQUE, 
    customer_name VARCHAR(50) NOT NULL
);

INSERT INTO customers (customer_id, customer_name) VALUES (1, 'Alice');
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'Bob');
INSERT INTO customers (customer_id, customer_name) VALUES (3, 'Charlie');

CREATE TABLE sales (
    sales_id INT NOT NULL PRIMARY KEY, 
    customer_id INT NOT NULL, 
    product_id INT NOT NULL, 
    sale_date DATETIME NOT NULL, 
    sales_amount INT NOT NULL
);

INSERT INTO sales (sales_id, customer_id, product_id, sale_date, sales_amount) VALUES (1, 1, 1, '2023-06-01', 100);
INSERT INTO sales (sales_id, customer_id, product_id, sale_date, sales_amount) VALUES (2, 1, 1, '2023-06-02', 150);
INSERT INTO sales (sales_id, customer_id, product_id, sale_date, sales_amount) VALUES (3, 2, 2, '2023-06-07', 400);
INSERT INTO sales (sales_id, customer_id, product_id, sale_date, sales_amount) VALUES (4, 2, 2, '2023-06-08', 450);




SELECT 
    c.customer_name, 
    COALESCE(SUM(s.sales_amount), 0) AS total_sales
FROM 
    customers c
LEFT JOIN 
    sales s ON c.customer_id = s.customer_id
GROUP BY 
    c.customer_id, c.customer_name;

	--QUESTION 7
CREATE TABLE employees(employee_id INT UNIQUE, employee_name VARCHAR(50) NOT NULL, department_id INT NOT NULL, salary INT NOT NULL);

INSERT INTO employees(employee_id,employee_name, department_id, salary) VALUES (1,'John Doe',1,100000);
INSERT INTO employees(employee_id, employee_name, department_id, salary) VALUES (2,'Jane Smith',1,95000);
INSERT INTO employees(employee_id, employee_name, department_id, salary) VALUES (3,'Alice Brown',1,90000);
INSERT INTO employees(employee_id, employee_name, department_id, salary) VALUES (4,'Bob Johnson',1,85000);
INSERT INTO employees(employee_id, employee_name, department_id, salary) VALUES (5,'Charlie Black',1,80000);
INSERT INTO employees(employee_id, employee_name, department_id, salary) VALUES (6,'David Green',1,75000);
INSERT INTO employees(employee_id, employee_name, department_id, salary) VALUES (7,'Eve White',2,110000);

CREATE TABLE departments(department_id INT NOT NULL, department_name VARCHAR(20) NOT NULL);
INSERT INTO departments(department_id, department_name)VALUES(1,'HR');
INSERT INTO departments(department_id, department_name)VALUES(2,'Finance');


--Write a query that delivers the name of any department with more than five employees, along with the average salary of these employees.
SELECT d.department_name, AVG(e.salary) AS average_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(e.employee_id) > 5;


create database employee_manager;
use employee_manager;

	--QUESTION 8

CREATE TABLE employees(employee_id INT UNIQUE, employee_name VARCHAR(50) NOT NULL, manager_id INT );

INSERT INTO employees(employee_id,employee_name, manager_id) VALUES (1,'John Doe',NULL);
INSERT INTO employees(employee_id, employee_name, manager_id) VALUES (2,'Jane Smith',1);
INSERT INTO employees(employee_id, employee_name, manager_id) VALUES (3,'Alice Brown',1);
INSERT INTO employees(employee_id, employee_name, manager_id) VALUES (4,'Bob Johnson',2);
INSERT INTO employees(employee_id, employee_name, manager_id) VALUES (5,'Charlie Black', NULL);
--select *from employees
--Write a query that delivers a list of employees without an assigned manager.
SELECT employee_name FROM employees WHERE manager_id IS NULL;


--QUESTION 9
CREATE TABLE orders(
    order_id INT NOT NULL PRIMARY KEY, 
    customer_id INT NOT NULL, 
    order_date DATE NOT NULL
);

INSERT INTO orders(order_id, customer_id, order_date) 
VALUES(2043, 1, '2023-06-01');

INSERT INTO orders(order_id, customer_id, order_date) 
VALUES(2044, 2, '2023-06-02');

INSERT INTO orders(order_id, customer_id, order_date) 
VALUES(2045, 3, '2023-06-03');

INSERT INTO orders(order_id, customer_id, order_date) 
VALUES(2046, 1, '2023-06-04');

BEGIN TRANSACTION;     

UPDATE orders  
SET order_date = CAST('2023-07-23' AS DATE)  
WHERE order_id = 2045; 

COMMIT;






