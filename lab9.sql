CREATE DATABASE lab9;

--1
CREATE OR REPLACE FUNCTION increase_value(input_value INT, OUT increased_value INT )
RETURNS INT AS
$$

BEGIN
    -- Increase the input value by 10
    increased_value = input_value + 10;
END;
$$
LANGUAGE PLPGSQL;

SELECT increase_value(5);

--2
CREATE OR REPLACE FUNCTION compare_numbers(
    num1 INT,
    num2 INT
)
RETURNS VARCHAR(10)
AS $$
DECLARE
    result_text VARCHAR(10);
BEGIN
    IF num1 > num2 THEN
        result_text = 'Greater';
    ELSIF num1 = num2 THEN
        result_text = 'Equal';
    ELSE
        result_text = 'Lesser';
    END IF;

    RETURN result_text;
END;
$$
LANGUAGE PLPGSQL;

-- Example call
SELECT compare_numbers(10, 5) AS result_text;

--3
CREATE OR REPLACE FUNCTION number_series(
    n INTEGER
)
RETURNS SETOF INTEGER AS $$
DECLARE
    i INTEGER;
BEGIN
    FOR i IN 1..n LOOP
        RETURN NEXT i;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Example usage
SELECT * FROM number_series(5);  -- This would return a result set: 1, 2, 3, 4, 5

--4
CREATE OR REPLACE FUNCTION find_employee(
    emp_name VARCHAR
)
RETURNS TABLE (
    employee_id INTEGER,
    employee_name VARCHAR,
    department VARCHAR
    -- Add other relevant columns based on your employee details
)
AS $$
BEGIN
    RETURN QUERY SELECT * FROM employees WHERE employee_name = emp_name;
END;
$$ LANGUAGE plpgsql;

-- Create the employees table
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50)
    -- Add other relevant columns based on your employee details
);

-- Insert some sample data
INSERT INTO employees (employee_name, department) VALUES
    ('John Doe', 'IT'),
    ('Jane Smith', 'HR'),
    ('Bob Johnson', 'Finance');

-- Example usage
SELECT * FROM find_employee('John Doe');
--5
CREATE OR REPLACE FUNCTION list_products(
    category_id INTEGER
)
RETURNS TABLE (
    product_id INTEGER,
    product_name VARCHAR,
    price DECIMAL(10, 2)
    -- Add other relevant columns based on your product details
)
AS $$
BEGIN
    RETURN QUERY SELECT * FROM products;
END;
$$ LANGUAGE plpgsql;
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    category_id INTEGER NOT NULL
    -- Add other relevant columns based on your product details
);

INSERT INTO products (product_name, price, category_id) VALUES
('Product A', 19.99, 1),
('Product B', 29.99, 2),
('Product C', 39.99, 1)
-- Add more sample data as needed
;
-- Example usage
SELECT * FROM list_products(1);


--6
-- Create the employees table with a salary column
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10, 2) DEFAULT 0.00
    -- Add other relevant columns based on your employee details
);

-- Insert some sample data
INSERT INTO employees (employee_name, department) VALUES
    ('John Doe', 'IT'),
    ('Jane Smith', 'HR'),
    ('Bob Johnson', 'Finance');

-- Function to calculate bonus
CREATE OR REPLACE FUNCTION calculate_bonus(
    emp_id INTEGER,
    OUT bonus DECIMAL(10, 2)
)
RETURNS VOID AS $$
BEGIN
    -- Your bonus calculation logic here
    -- For demonstration purposes, let's assume a fixed bonus amount
    bonus := 500.00;
END;
$$ LANGUAGE plpgsql;

-- Function to update salary using calculate_bonus
CREATE OR REPLACE FUNCTION update_salary(
    emp_id INTEGER
)
RETURNS VOID AS $$
DECLARE
    emp_bonus DECIMAL(10, 2);
BEGIN
    -- Call calculate_bonus to get the bonus
    PERFORM calculate_bonus(emp_id, emp_bonus);

    -- Your salary update logic using the calculated bonus
    UPDATE employees SET salary = salary + emp_bonus WHERE employee_id = emp_id;
END;
$$ LANGUAGE plpgsql;

-- Example usage
SELECT * FROM calculate_bonus(1); -- This would calculate the bonus for employee with ID 1

-- Example usage
SELECT * FROM update_salary(1); -- This would update the salary for employee with ID 1 using the calculated bonus
CREATE OR REPLACE FUNCTION complex_calculation(
    param1 INTEGER,
    param2 VARCHAR,
    OUT result VARCHAR
)
RETURNS VOID AS $$
DECLARE
    -- Variables for subblock 1 (String manipulation)
    subblock1_result VARCHAR;

    -- Variables for subblock 2 (Numeric computation)
    subblock2_result INTEGER;
BEGIN
    -- Main block
    <<main_block>>
    BEGIN
        -- Subblock 1: String manipulation
        <<subblock1>>
        BEGIN
            -- Your string manipulation logic here
            subblock1_result := 'StringManipulation_' || param2;
        END subblock1;

        -- Subblock 2: Numeric computation
        <<subblock2>>
        BEGIN
            -- Your numeric computation logic here
            subblock2_result := param1 * 2;
        END subblock2;

        -- Combine results from subblocks
    END main_block;
END;
$$ LANGUAGE plpgsql;

-- Example usage
SELECT * FROM complex_calculation(5, 'Hello'); -- This would return a result based on the specified operations