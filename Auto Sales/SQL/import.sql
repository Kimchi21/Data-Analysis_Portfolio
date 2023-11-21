CREATE DATABASE IF NOT EXISTS automobile;

USE automobile;

CREATE TABLE sales (
    OrderNumber INT,
    QuantityOrdered INT,
    Price DECIMAL(10, 2),
    OrderLineNumber INT,
    Sales DECIMAL(10, 2),
    OrderDate DATE,
    DaysSinceLastOrder INT,
    Status VARCHAR(50),
    ProductLine VARCHAR(50),
    MSRP INT,
    ProductCode VARCHAR(20),
    CustomerName VARCHAR(100),
    Phone VARCHAR(50),
    AddressLine VARCHAR(255),
    City VARCHAR(50),
    PostalCode VARCHAR(50),
    Country VARCHAR(50),
    ContactLastName VARCHAR(50),
    ContactFirstName VARCHAR(50),
    DealSize VARCHAR(50)
);

SELECT *
FROM automobile.sales;

-- check
SHOW VARIABLES LIKE "local_infile";

-- allow loading local data if not turned on
SET GLOBAL local_infile = true;

-- import local data
LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Data/automobile/Auto Sales data.csv' INTO TABLE sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;