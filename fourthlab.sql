-- Task 1: Create a database called "lab4"
CREATE DATABASE lab4;

-- Task 2: Create "Warehouses" and "Boxes" tables
-- (Make sure you are connected to the "lab4" database)
CREATE TABLE Warehouses (
    WarehouseCode SERIAL PRIMARY KEY,
    Location VARCHAR(50),
    Capacity INT
);

CREATE TABLE Boxes (
    BoxCode CHAR(4) PRIMARY KEY,
    Contents VARCHAR(50),
    Value DECIMAL(10, 2),
    WarehouseCode INT,
    FOREIGN KEY (WarehouseCode) REFERENCES Warehouses(WarehouseCode)
);

-- Task 3: Download lab4.sql file from the intranet and run it

-- Task 4: Select all warehouses with all columns
SELECT * FROM Warehouses;

-- Task 5: Select all boxes with a value larger than $150
SELECT * FROM Boxes WHERE Value > 150;

-- Task 6: Select all distinct boxes by contents
SELECT DISTINCT Contents FROM Boxes;

-- Task 7: Select the warehouse code and the number of boxes in each warehouse
SELECT WarehouseCode, COUNT(*) AS NumberOfBoxes FROM Boxes GROUP BY WarehouseCode;

-- Task 8: Select only those warehouses where the number of boxes is greater than 2
SELECT WarehouseCode, COUNT(*) AS NumberOfBoxes
FROM Boxes
GROUP BY WarehouseCode
HAVING NumberOfBoxes > 2;

-- Task 9: Create a new warehouse in New York with a capacity for 3 boxes
INSERT INTO Warehouses (Location, Capacity)
VALUES ('New York', 3);

-- Task 10: Create a new box in warehouse 2
INSERT INTO Boxes (BoxCode, Contents, Value, WarehouseCode)
VALUES ('H5RT', 'Papers', 200, 2);

-- Task 11: Reduce the value of the third largest box by 15%
UPDATE Boxes
SET Value = Value * 0.85
WHERE BoxCode = (
    SELECT BoxCode
    FROM Boxes
    ORDER BY Value DESC
    OFFSET 2 LIMIT 1
);

-- Task 12: Remove all boxes with a value lower than $150
DELETE FROM Boxes WHERE Value < 150;

-- Task 13: Remove all boxes located in New York and return deleted data
WITH DeletedData AS (
    DELETE FROM Boxes
    WHERE WarehouseCode = (SELECT WarehouseCode FROM Warehouses WHERE Location = 'New York')
    RETURNING *
)
SELECT * FROM DeletedData;