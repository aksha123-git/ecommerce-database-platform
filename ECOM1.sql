CREATE TABLE Products (
  ProductID SERIAL PRIMARY KEY,
  ProductName VARCHAR(100) NOT NULL,
  Description TEXT,
  Price DECIMAL(10, 2) NOT NULL,
  QuantityInStock INT NOT NULL,
  Category VARCHAR(50)
);


CREATE TABLE Customers (
  CustomerID SERIAL PRIMARY KEY,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  Email VARCHAR(100) NOT NULL,
  Address VARCHAR(200),
  City VARCHAR(50),
  Country VARCHAR(50)
);

CREATE TABLE Orders (
  OrderID SERIAL PRIMARY KEY,
  CustomerID INT,
  OrderDate DATE NOT NULL,
  TotalAmount DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderItems (
  OrderItemID SERIAL PRIMARY KEY,
  OrderID INT,
  ProductID INT,
  Quantity INT NOT NULL,
  Subtotal DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Payments (
  PaymentID SERIAL PRIMARY KEY,
  OrderID INT,
  PaymentDate DATE NOT NULL,
  Amount DECIMAL(10, 2) NOT NULL,
  PaymentMethod VARCHAR(50),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE ShippingDetails (
  ShippingID SERIAL PRIMARY KEY,
  OrderID INT,
  ShippingAddress VARCHAR(200) NOT NULL,
  City VARCHAR(50) NOT NULL,
  Country VARCHAR(50) NOT NULL,
  DeliveryDate DATE,
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE OR REPLACE VIEW CustomerLoyalty AS
SELECT
  C.CustomerID,
  C.FirstName,
  C.LastName,
  COUNT(O.OrderID) AS NumberOfOrders,
  STRING_AGG(P.ProductName, ', ') AS PurchasedProducts
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderItems OI ON O.OrderID = OI.OrderID
JOIN Products P ON OI.ProductID = P.ProductID
GROUP BY C.CustomerID, C.FirstName, C.LastName
HAVING COUNT(O.OrderID) > 1;


-- Insert more data into the Products table
INSERT INTO Products (ProductID, ProductName, Description, Price, QuantityInStock, Category)
VALUES
    (4, 'Product 4', 'Description for Product 4', 39.99, 75, 'Category B'),
    (5, 'Product 5', 'Description for Product 5', 14.99, 150, 'Category A'),
    (6, 'Product 6', 'Description for Product 6', 24.99, 100, 'Category C');

-- Insert more data into the Customers table
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Address, City, Country)
VALUES
    (4, 'Mary', 'Johnson', 'mary@example.com', '101 Pine St', 'San Francisco', 'USA'),
    (5, 'David', 'Wilson', 'david@example.com', '202 Oak St', 'Miami', 'USA'),
    (6, 'Sarah', 'Lee', 'sarah@example.com', '303 Maple St', 'Boston', 'USA');

-- Insert more data into the Orders table
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
    (4, 4, '2023-10-04', 74.97),
    (5, 5, '2023-10-05', 29.97),
    (6, 6, '2023-10-06', 49.98);

-- Insert more data into the OrderItems table
INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, Subtotal)
VALUES
    (5, 4, 4, 3, 119.97),
    (6, 5, 5, 2, 29.98),
    (7, 6, 6, 4, 99.96),
    (8, 6, 4, 2, 79.98);

-- Insert more data into the Payments table
INSERT INTO Payments (PaymentID, OrderID, PaymentDate, Amount, PaymentMethod)
VALUES
    (4, 4, '2023-10-04', 74.97, 'Credit Card'),
    (5, 5, '2023-10-05', 29.97, 'PayPal'),
    (6, 6, '2023-10-06', 49.98, 'Credit Card');

-- Insert more data into the ShippingDetails table
INSERT INTO ShippingDetails (ShippingID, OrderID, ShippingAddress, City, Country, DeliveryDate)
VALUES
    (4, 4, '101 Pine St', 'San Francisco', 'USA', '2023-10-08'),
    (5, 5, '202 Oak St', 'Miami', 'USA', '2023-10-09'),
    (6, 6, '303 Maple St', 'Boston', 'USA', '2023-10-10');
	
	
	
-- Insert data into the Products table
INSERT INTO Products (ProductID, ProductName, Description, Price, QuantityInStock, Category)
VALUES
    (1, 'Product 1', 'Description for Product 1', 19.99, 100, 'Category A'),
    (2, 'Product 2', 'Description for Product 2', 29.99, 50, 'Category B'),
    (3, 'Product 3', 'Description for Product 3', 9.99, 200, 'Category A');

-- Insert data into the Customers table
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Address, City, Country)
VALUES
    (1, 'John', 'Doe', 'john@example.com', '123 Main St', 'New York', 'USA'),
    (2, 'Jane', 'Smith', 'jane@example.com', '456 Elm St', 'Los Angeles', 'USA'),
    (3, 'Bob', 'Johnson', 'bob@example.com', '789 Oak St', 'Chicago', 'USA');

-- Insert data into the Orders table
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
    (1, 1, '2023-10-01', 49.98),
    (2, 2, '2023-10-02', 59.98),
    (3, 1, '2023-10-03', 19.99);

-- Insert data into the OrderItems table
INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, Subtotal)
VALUES
    (1, 1, 1, 2, 39.98),
    (2, 2, 2, 1, 29.99),
    (3, 2, 3, 3, 29.97),
    (4, 3, 1, 1, 19.99);

-- Insert data into the Payments table
INSERT INTO Payments (PaymentID, OrderID, PaymentDate, Amount, PaymentMethod)
VALUES
    (1, 1, '2023-10-01', 49.98, 'Credit Card'),
    (2, 2, '2023-10-02', 59.98, 'PayPal'),
    (3, 3, '2023-10-03', 19.99, 'Credit Card');

-- Insert data into the ShippingDetails table
INSERT INTO ShippingDetails (ShippingID, OrderID, ShippingAddress, City, Country, DeliveryDate)
VALUES
    (1, 1, '123 Main St', 'New York', 'USA', '2023-10-05'),
    (2, 2, '456 Elm St', 'Los Angeles', 'USA', '2023-10-06'),
    (3, 3, '123 Main St', 'New York', 'USA', '2023-10-07');


--QUERY BASED OF ABOVE PROJECT
--Query: Retrieve the names and quantities in stock for all products in Category A.
SELECT ProductName, QuantityInStock
FROM Products
WHERE Category = 'Category A';

--Query: Find the total amount spent by each customer.
SELECT C.CustomerID, C.FirstName, C.LastName, SUM(O.TotalAmount) AS TotalSpent
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName;

--Query: List all orders with their respective order items.
SELECT O.OrderID, O.OrderDate, O.TotalAmount, P.ProductName, OI.Quantity, OI.Subtotal
FROM Orders O
JOIN OrderItems OI ON O.OrderID = OI.OrderID
JOIN Products P ON OI.ProductID = P.ProductID;

--Query: Calculate the average order total amount.
SELECT AVG(TotalAmount) AS AverageOrderTotal
FROM Orders;

--Query: Find the customers who have made more than three orders and their loyalty information.
SELECT C.CustomerID, C.FirstName, C.LastName, COUNT(O.OrderID) AS NumberOfOrders, STRING_AGG(P.ProductName, ', ') AS PurchasedProducts
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderItems OI ON O.OrderID = OI.OrderID
JOIN Products P ON OI.ProductID = P.ProductID
GROUP BY C.CustomerID, C.FirstName, C.LastName
HAVING COUNT(O.OrderID) > 3;

--Query: Retrieve all payments made via PayPal.
SELECT *
FROM Payments
WHERE PaymentMethod = 'PayPal';

--Query: List all orders with their shipping details.
SELECT O.OrderID, O.OrderDate, O.TotalAmount, SD.ShippingAddress, SD.City, SD.Country, SD.DeliveryDate
FROM Orders O
JOIN ShippingDetails SD ON O.OrderID = SD.OrderID;

--Query: Find the products that have a quantity in stock below 50.
SELECT ProductName, QuantityInStock
FROM Products
WHERE QuantityInStock < 50;

--Query: Retrieve the total revenue for a specific category (e.g., 'Category B').
SELECT SUM(OI.Subtotal) AS TotalRevenue
FROM OrderItems OI
JOIN Products P ON OI.ProductID = P.ProductID
WHERE P.Category = 'Category B';

--Query: Find the customer who has spent the most.
SELECT C.CustomerID, C.FirstName, C.LastName, SUM(O.TotalAmount) AS TotalSpent
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
ORDER BY TotalSpent DESC
LIMIT 1;






--Query: Find the top 5 customers with the highest total spending, and list their order details.

WITH CustomerSpending AS (
    SELECT C.CustomerID, C.FirstName, C.LastName, SUM(O.TotalAmount) AS TotalSpent
    FROM Customers C
    JOIN Orders O ON C.CustomerID = O.CustomerID
    GROUP BY C.CustomerID, C.FirstName, C.LastName
)
SELECT CS.CustomerID, CS.FirstName, CS.LastName, CS.TotalSpent, O.OrderID, O.OrderDate, O.TotalAmount
FROM CustomerSpending CS
JOIN Orders O ON CS.CustomerID = O.CustomerID
ORDER BY TotalSpent DESC
LIMIT 5;

--Query: Retrieve the products that have been ordered the most (top 5) and display 
--the total quantity ordered for each.
SELECT P.ProductID, P.ProductName, SUM(OI.Quantity) AS TotalQuantityOrdered
FROM Products P
JOIN OrderItems OI ON P.ProductID = OI.ProductID
GROUP BY P.ProductID, P.ProductName
ORDER BY TotalQuantityOrdered DESC
LIMIT 5;

--Query: List the products that have not been ordered by any customer.
SELECT P.ProductID, P.ProductName
FROM Products P
LEFT JOIN OrderItems OI ON P.ProductID = OI.ProductID
WHERE OI.ProductID IS NULL;

--Query: Find the customers who have made the most purchases in a specific category (e.g., 'Category A').
SELECT C.CustomerID, C.FirstName, C.LastName, COUNT(O.OrderID) AS NumberOfOrders
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderItems OI ON O.OrderID = OI.OrderID
JOIN Products P ON OI.ProductID = P.ProductID
WHERE P.Category = 'Category A'
GROUP BY C.CustomerID, C.FirstName, C.LastName
ORDER BY NumberOfOrders DESC
LIMIT 1;

CREATE VIEW ShippingPerformance AS
SELECT
  O.OrderID,
  O.OrderDate,
  SD.ShippingAddress,
  SD.City,
  SD.Country,
  SD.DeliveryDate,
  (SD.DeliveryDate - O.OrderDate)::integer AS DeliveryTimeInDays,
  CASE WHEN SD.DeliveryDate <= O.OrderDate THEN 'Delayed' ELSE 'On Time' END AS DeliveryStatus
FROM Orders O
JOIN ShippingDetails SD ON O.OrderID = SD.OrderID;
--*Monthly Sales View
CREATE VIEW MonthlySales AS
SELECT
  EXTRACT(YEAR FROM O.OrderDate) AS Year,
  EXTRACT(MONTH FROM O.OrderDate) AS Month,
  SUM(O.TotalAmount) AS Revenue,
  COUNT(O.OrderID) AS NumberOfOrders,
  STRING_AGG(P.ProductName, ', ' ORDER BY O.OrderID) AS TopSellingProducts
FROM Orders O
JOIN OrderItems OI ON O.OrderID = OI.OrderID
JOIN Products P ON OI.ProductID = P.ProductID
GROUP BY EXTRACT(YEAR FROM O.OrderDate), EXTRACT(MONTH FROM O.OrderDate);





-- Insert data into Products
INSERT INTO Products (ProductName, Description, Price, QuantityInStock, Category) VALUES
('Sunsilk Shampoo', 'A body product', 78.6, 100, 'personal care'),
('Dove Soap', 'A gentle soap for sensitive skin', 45.99, 50, 'personal care'),
('Colgate Toothpaste', 'Fights cavities and freshens breath', 25.75, 80, 'personal care'),
('HP Laptop', '15.6" Full HD, 8GB RAM, 256GB SSD', 899.99, 15, 'electronics'),
('Samsung Galaxy S21', '6.2" 128GB 5G Smartphone', 999.00, 30, 'electronics');



-- Insert data into Customers
INSERT INTO Customers (FirstName, LastName, Email, Address, City, Country) VALUES
('John', 'Doe', 'john.doe@example.com', '123 Main St', 'New York', 'USA'),
('Jane', 'Smith', 'jane.smith@example.com', '456 Elm Ave', 'Los Angeles', 'USA'),
('Michael', 'Johnson', 'michael.johnson@example.com', '789 Oak Rd', 'Chicago', 'USA'),
('Emily', 'Brown', 'emily.brown@example.com', '101 Pine Dr', 'Houston', 'USA'),
('William', 'Lee', 'william.lee@example.com', '222 Maple Ln', 'San Francisco', 'USA');



-- Insert data into Orders
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2023-08-01', 150.50),
(3, '2023-08-02', 75.99),
(2, '2023-08-03', 200.00),
(4, '2023-08-04', 50.25),
(5, '2023-08-05', 300.75);



-- Insert data into OrderItems
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Subtotal) VALUES
(1, 1, 2, 157.20),
(1, 3, 1, 25.75),
(2, 4, 3, 2699.97),
(3, 2, 2, 91.98),
(4, 5, 1, 999.00),
(5, 3, 4, 103.00);



-- Insert data into Payments
INSERT INTO Payments (OrderID, PaymentDate, Amount, PaymentMethod) VALUES
(11, '2023-08-01', 150.50, 'Credit Card'),
(31, '2023-08-02', 75.99, 'PayPal'),
(211, '2023-08-03', 200.00, 'Cash'),
(41, '2023-08-04', 50.25, 'Credit Card'),
(51, '2023-08-05', 300.75, 'Bank Transfer');



-- Insert data into ShippingDetails
INSERT INTO ShippingDetails (OrderID, ShippingAddress, City, Country, DeliveryDate) VALUES
(11, '123 Main St', 'New York', 'USA', '2023-08-10'),
(31, '456 Elm Ave', 'Los Angeles', 'USA', '2023-08-11'),
(21, '789 Oak Rd', 'Chicago', 'USA', '2023-08-12'),
(41, '101 Pine Dr', 'Houston', 'USA', '2023-08-13'),
(51, '222 Maple Ln', 'San Francisco', 'USA','2023-08-14');

--Create (Insert) Operation:

INSERT INTO Products (ProductID, ProductName, Description, Price, QuantityInStock,
Category)
VALUES (78, 'Sample Product', 'This is a sample product description.', 19.99, 100, 'Sample
Category');

--Read (Select) Operation:
SELECT * FROM Products;

SELECT * FROM Products WHERE Category = 'Electronics';

SELECT * FROM Products WHERE ProductID = 1;
--update
UPDATE Products
SET Price = 24.99,
QuantityInStock = 150
WHERE ProductID = 1;

--Delete
-- Delete related records in OrderItems
DELETE FROM OrderItems WHERE ProductID = 1;
DELETE FROM Products WHERE ProductID = 1;



--6. Data Analysis:

---- Query for Most Popular Product Categories
SELECT
Category,
SUM(Quantity) AS TotalQuantitySold
FROM
Products
JOIN
OrderItems ON Products.ProductID = OrderItems.ProductID
GROUP BY
Category
ORDER BY
TotalQuantitySold DESC;

-- Query for Regions with Highest Sales
SELECT
City,
Country,
SUM(TotalAmount) AS TotalSalesAmount
FROM
Orders
JOIN
Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY
City, Country
ORDER BY
TotalSalesAmount DESC;

---- Query for Customer Purchase Patterns
SELECT
CustomerType,
COUNT(*) AS NumberOfCustomers
FROM (
SELECT
CustomerID,
CASE
WHEN COUNT(OrderID) > 1 THEN 'Repeat Customer'
ELSE 'One-Time Buyer'
END AS CustomerType
FROM
Orders
GROUP BY
CustomerID
) AS CustomerBehavior
GROUP BY
CustomerType;

---- Query for Average Order Value Over Time
-- Calculate the average order value for each month over time
SELECT
  EXTRACT(YEAR FROM OrderDate) AS OrderYear,
  EXTRACT(MONTH FROM OrderDate) AS OrderMonth,
  AVG(TotalAmount) AS AvgOrderValue
FROM
  Orders
GROUP BY
  EXTRACT(YEAR FROM OrderDate), EXTRACT(MONTH FROM OrderDate)
ORDER BY
  OrderYear, OrderMonth;

---- Query for Best Selling Products
SELECT
ProductName,
SUM(Quantity) AS TotalQuantitySold
FROM
Products
JOIN
OrderItems ON Products.ProductID = OrderItems.ProductID
GROUP BY
ProductName
ORDER BY
TotalQuantitySold DESC;

--4. Advanced Queries:
--Query for Finding Products with the Highest Sales (Top 10):
SELECT p.ProductName, SUM(oi.Quantity) AS TotalSales
FROM Products p
JOIN OrderItems oi ON p.ProductID = oi.ProductID
GROUP BY p.ProductName
ORDER BY TotalSales DESC
LIMIT 10;

--Query for Identifying the Most Active Customers (Top 10):
SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(o.OrderID) AS OrderCount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY OrderCount DESC
LIMIT 10;

--Query for Calculating the Total Revenue for a Specific Time Period:
SELECT SUM(oi.Subtotal) AS TotalRevenue
FROM Orders o
JOIN OrderItems oi ON o.OrderID = oi.OrderID
WHERE o.OrderDate BETWEEN '2023-01-01' AND '2023-12-31';

-- Create a security policy to restrict access to Orders based on CustomerID
CREATE POLICY OrdersPolicy
  USING (CustomerID = current_user)
  ON Orders
  FOR ALL
  USING (CustomerID = current_user);

-- Assign the policy to a role (restricted_role) that you want to restrict
GRANT SELECT ON Orders TO restricted_role;

-- Insert new order
INSERT INTO Products (ProductID, ProductName, Description, Price, QuantityInStock, Category)
VALUES (101, 'Product101', 'Description for Product101', 10.99, 50, 'Category101');

-- Insert order items
INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, Subtotal)
VALUES (187, 1, 101, 2, 50.00),
(256, 1, 101, 1, 30.00);
-- Try to insert payment
-- Let's assume there's an issue here, for example, the payment amount is negative
INSERT INTO Payments (PaymentID, OrderID, PaymentDate, Amount,PaymentMethod)
VALUES (109, 1, '2023-08-04', -150.00, 'Credit Card');
-- If there's an issue, roll back the transaction
ROLLBACK;
-- If everything is successful, commit the transaction
COMMIT;


