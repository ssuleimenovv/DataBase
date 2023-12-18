-- subTask #1
CREATE DATABASE lab7;
-- subTask #2
CREATE TABLE countries(
    location_id SERIAL PRIMARY KEY,
    street_address VARCHAR(25),
    postal_code VARCHAR(12),
    city VARCHAR(30),
    state_province VARCHAR(12)
);

CREATE TABLE departments(
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE,
    budget INTEGER,
    location_id INTEGER REFERENCES countries
);

CREATE TABLE employee(
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(20),
    salary INTEGER,
    department_id INTEGER REFERENCES departments
);
-- subTask #3
INSERT INTO countries(location_id, street_address, postal_code, city, state_province) VALUES (5001, '201 Kulikov St', '992364', 'Moscow', 'Russia');
INSERT INTO countries(location_id, street_address, postal_code, city, state_province) VALUES (1001, '6092 Boxwood St', '490231', 'Munich', 'Bavaria');
INSERT INTO countries(location_id, street_address, postal_code, city, state_province) VALUES (2001, '147 Spadina Ave', '560131', 'Toronto', 'Ontario');
INSERT INTO countries(location_id, street_address, postal_code, city, state_province) VALUES (3001, '2004 Charade Rd', '151515', 'Seattle', 'Washington');
INSERT INTO countries(location_id, street_address, postal_code, city, state_province) VALUES (4001, '2007 Zagora St', '500900', 'South Brunswick', 'New Jersey');

INSERT INTO departments(department_id, department_name, budget, location_id) VALUES (70, 'Benefits', 121, 4001);
INSERT INTO departments(department_id, department_name, budget, location_id) VALUES (30, 'Purchasing', 115, 1001);
INSERT INTO departments(department_id, department_name, budget, location_id) VALUES (50, 'Finance', 107, 2001);
INSERT INTO departments(department_id, department_name, budget, location_id) VALUES (60, 'Accounting', 214, 3001);
INSERT INTO departments(department_id, department_name, budget, location_id) VALUES (80, 'Control and Credit', 205, 5001);

INSERT INTO employee(employee_id, first_name, last_name, email, phone_number, salary, department_id) VALUES (106, 'Kate', 'Gilbert', 'kate@gmail.com', '87012334812', 6000, 80);
INSERT INTO employee(employee_id, first_name, last_name, email, phone_number, salary, department_id) VALUES (102, 'Bruce', 'Hunold', 'bruce@gmail.com', '87017294812', 6000, 30);
INSERT INTO employee(employee_id, first_name, last_name, email, phone_number, salary, department_id) VALUES (103, 'Bob', 'Coronel', 'bob@gmail.com', '87471527606', 7500, 30);
INSERT INTO employee(employee_id, first_name, last_name, email, phone_number, salary, department_id) VALUES (104, 'Diana', 'Lorentz', 'diana@gmail.com', '87752028767', 4800, 50);
INSERT INTO employee(employee_id, first_name, last_name, email, phone_number, salary, department_id) VALUES (105, 'Lili', 'Salvatore', 'lili@gmail.com', '87017223812', 500, NULL);
-- Task #1
CREATE INDEX idx_countries_name ON countries(city);
-- Task #2
CREATE INDEX idx_employees_name_surname ON employee(first_name, last_name);
-- Task #3
CREATE UNIQUE INDEX idx_employees_salary_range ON employee(salary);
-- Task #4
CREATE INDEX idx_employees_name_substr ON employee((SUBSTRING(first_name FROM 1 TO 4)));
-- Task #5
CREATE INDEX idx_employees_departments_budget_salary ON employee(department_id, salary);
