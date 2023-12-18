-- Task #1
CREATE DATABASE lab5;
-- Task #2
CREATE TABLE customers(
    customer_id integer primary key,
    cust_name varchar(50),
    city varchar(50),
    grade integer,
    salesman_id integer
);

CREATE TABLE salesman(
    salesman_id integer primary key,
    name varchar(50),
    city varchar(50),
    commission float
);

CREATE TABLE orders(
    ord_no bigint,
    purch_amt decimal(10, 2),
    ord_date date,
    customer_id integer,
    salesman_id integer,
    foreign key (customer_id) references customers(customer_id),
    foreign key (salesman_id) references salesman(salesman_id)
);

INSERT INTO salesman(salesman_id, name, city, commission) values
    (5001, 'James Hoog', 'NewYork', 0.15),
    (5002, 'Nail Knite', 'Paris', 0.13),
    (5005, 'Pit Alex', 'London', 0.11),
    (5006, 'Mc Lyon', 'Paris', 0.14),
    (5003, 'Lauson Hen', null, 0.12),
    (5007, 'Paul Adam', 'Rome', 0.13);

INSERT INTO customers(customer_id, cust_name, city, grade, salesman_id) values
    (3002, 'Nick Rimando', 'New York', 100, 5001),
    (3005, 'Graham Zusi', 'California', 200, 5002),
    (3001, 'Brad Guzan', 'London', null, 5005),
    (3004, 'Fabian Johns', 'Paris', 300, 5006),
    (3007, 'Brad Davis', 'New York', 200, 5001),
    (3009, 'Geoff Camero', 'Berlin', 100, 5003),
    (3008, 'Julian Green', 'London', 300, 5002);

INSERT INTO orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
    (70001, 150.5, '2012-10-05', 3005, 5002),
    (70009, 270.65, '2012-09-10', 3001, 5005),
    (70002, 65.26, '2012-10-05', 3002, 5001),
    (70004, 110.5, '2012-08-17', 3009, 5003),
    (70007, 948.5, '2012-09-10', 3005, 5002),
    (70005, 2400.6, '2012-07-27', 3007, 5001),
    (70008, 5760, '2012-09-10', 3002, 5001);
-- Task #3
SELECT SUM(purch_amt) FROM orders; -- 3
-- Task #4
SELECT AVG(purch_amt) FROM orders; -- 4
-- Task #5
SELECT COUNT(cust_name) FROM customers; -- 5
-- Task #6
SELECT MIN(purch_amt) FROM orders; -- 6.1
SELECT purch_amt FROM orders ORDER BY purch_amt LIMIT 1; -- 6.2
-- Task #7
SELECT * FROM customers
         WHERE cust_name LIKE '%b'; -- 7
-- Task #8
SELECT * FROM orders
         WHERE customer_id IN (SELECT customer_id FROM customers WHERE city = 'New York'); -- 8
-- Task #9
SELECT * FROM customers
         WHERE customer_id IN (SELECT customer_id FROM orders WHERE purch_amt > 10); -- 9
-- Task #10
SELECT SUM(grade) FROM customers; -- 10
-- Task #11
SELECT * FROM customers WHERE cust_name <> 'Julian Green'; -- 11
-- Task #12
SELECT * FROM customers WHERE grade = (SELECT MAX(grade) FROM customers); --12.1
SELECT * FROM customers ORDER BY grade DESC LIMIT 2 OFFSET 1; --12.2

DROP TABLE salesman, customers, orders;
DROP DATABASE lab5;