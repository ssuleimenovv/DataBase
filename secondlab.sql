/* #1 Create database called "lab2"*/
CREATE DATABASE lab2;
/* #2 Create the "countries" table*/
CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(255),
    region_id INTEGER,
    population INTEGER
);
/* #3 Insert a row with data into the "countries" table */
INSERT INTO countries (country_name, region_id, population) VALUES ('Italy',1, 58900000);
/* #4 Insert one row into the "countries" table with country_id and country_name */
INSERT INTO countries (country_id, country_name) VALUES (2,'Canada');
/* #5 Insert NULL value into the region_id column for a row*/
INSERT INTO countries (country_name, region_id, population) VALUES ('Ghana', NULL, 34000000);
/* #6 Insert 3 rows with a single INSERT statement*/
INSERT INTO countries (country_name, region_id, population)
VALUES
    ('Germany', 1, 83300000),
    ('France', 2, 64700000),
    ('Switzerland', 3, 8800000);
/* #7 Set default value 'Kazakhstan' to the country_name column*/
ALTER TABLE countries ALTER COLUMN country_name SET DEFAULT 'Kazakhstan';
/* #8 Insert default value to country_name column for a row of countries table*/
INSERT INTO countries (region_id, population) VALUES (4, 600000);
/* #9 Insert only default values into all columns of the "countries" table*/
INSERT INTO countries DEFAULT VALUES;
/* #10 Create duplicate of countries table named countries _new with all structure using LIKE keyword*/
CREATE TABLE countries_new (LIKE countries INCLUDING ALL);
/* #11 Insert all rows from countries table to countries_new table*/
INSERT INTO countries_new SELECT * FROM countries;
/* #12 Change region_id of country to "1" if it equals NULL.(Use WHERE clause and IS NULL operator)*/
UPDATE countries SET region_id = 1 WHERE region_id IS NULL;
/* #13 Increase population of each country by 10% and return country_name and updated population column with the alias "New Population"*/
UPDATE countries
SET population = population * 1.10
RETURNING country_name, population AS "New Population";
/* #14 Remove all rows from the countries table with less than 100k population and return the deleted data*/
DELETE FROM countries
WHERE population < 100000
RETURNING *;
/* #15 Remove all rows from the "countries_new" table where country_id exists in the "countries" table and return the deleted data*/
DELETE FROM countries_new
WHERE country_id IN (SELECT country_id FROM countries)
RETURNING *;
/* #16 Remove all rows from the "countries" table and return the deleted data*/
DELETE FROM countries
RETURNING *;