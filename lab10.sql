CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(30),
    author VARCHAR(30),
    price DECIMAL,
    quantity INTEGER
);

CREATE TABLE orders(
    order_id SERIAL PRIMARY KEY,
    book_id INTEGER REFERENCES books(book_id),
    customer_id INTEGER REFERENCES customers(customer_id),
    order_date DATE,
    quantity INTEGER
);

CREATE TABLE customers(
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(30),
    email VARCHAR(30)
);

INSERT INTO books (title, author, price, quantity)
VALUES
    ('Book1', 'Author1', 19.99, 50),
    ('Book2', 'Author2', 29.99, 30),
    ('Book3', 'Author3', 14.99, 9),
    ('Book4', 'Author1', 24.99, 40),
    ('Book5', 'Author2', 9.99, 25);

INSERT INTO customers (customer_id, name, email)
VALUES
    (101, 'Customer1', 'customer1@example.com'),
    (102, 'Customer2', 'customer2@example.com'),
    (102, 'Customer3', 'customer3@example.com'),
    (104, 'Customer4', 'customer4@example.com'),
    (105, 'Customer5', 'customer5@example.com');

INSERT INTO orders (book_id, customer_id, order_date, quantity)
VALUES
    (1, 101, '2023-01-15', 2),
    (2, 103, '2023-02-20', 1),
    (3, 102, '2023-03-10', 3),
    (4, 104, '2023-04-05', 2),
    (5, 105, '2023-05-18', 1);

BEGIN;
INSERT INTO orders (book_id, customer_id, order_date, quantity)
VALUES
    (1,101,'2023-06-12',2);
UPDATE books SET quantity = quantity - 2
WHERE book_id = 1;
COMMIT;

SELECT * FROM orders;
SELECT * FROM books;

DO $$
DECLARE
    available_quantity INTEGER;
BEGIN
    INSERT INTO orders (book_id, customer_id, order_date, quantity)
    VALUES (3,102,'2023-07-12',10);

    SELECT quantity INTO available_quantity FROM books WHERE book_id = 3;

    IF available_quantity < 10 THEN
        ROLLBACK;
    ELSE
        UPDATE books SET quantity = quantity - 10
        WHERE book_id = 3;
        COMMIT;
    END IF;
END $$;

BEGIN;
    UPDATE books SET price = 18.99 WHERE book_id = 1;
COMMIT;

BEGIN;
    UPDATE customers SET email = 'Saimon@gmail.com' WHERE customer_id = 101;
COMMIT;

SELECT * FROM books;

DROP TABLE books;
DROP TABLE customers;
DROP TABLE orders;
