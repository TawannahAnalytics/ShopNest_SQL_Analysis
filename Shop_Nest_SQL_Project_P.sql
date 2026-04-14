/* ============================================================
   SHOPNEST DATABASE SETUP
   Purpose: Create and initialize database for e-commerce analysis
   ============================================================ */

CREATE DATABASE ShopNestDB;
GO

USE ShopNestDB;
GO

/* ============================================================
   TABLE: Customers
   Purpose: Stores customer demographic, location, and signup data
   ============================================================ */

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female')),
    City VARCHAR(50),
    State VARCHAR(50),
    SignupDate DATE NOT NULL
);


/* ============================================================
   TABLE: Sellers
   Purpose: Stores seller information including category,
            location, onboarding date, and performance rating
   ============================================================ */

CREATE TABLE Sellers (
    SellerID INT PRIMARY KEY,
    SellerName NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50) NOT NULL,
    City NVARCHAR(50),
    JoinDate DATE NOT NULL,
    Rating DECIMAL(3,1) CHECK (Rating BETWEEN 1.0 AND 5.0)
);


/* ============================================================
   TABLE: Products
   Purpose: Stores product details, pricing, inventory,
            and links each product to a seller
   ============================================================ */

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(150) NOT NULL,
    Category NVARCHAR(50) NOT NULL,
    SellerID INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL CHECK (UnitPrice > 0),
    StockQuantity INT DEFAULT 0,

    FOREIGN KEY (SellerID) REFERENCES Sellers(SellerID)
);


/* ============================================================
   TABLE: Orders
   Purpose: Stores transactional data including customer orders,
            product purchases, pricing, payment, and delivery details
   ============================================================ */

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,

    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,

    OrderDate DATE NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    UnitPrice DECIMAL(10,2) NOT NULL,
    Discount DECIMAL(5,2) DEFAULT 0,
    TotalAmount DECIMAL(10,2) NOT NULL,

    PaymentMethod NVARCHAR(30)
        CHECK (PaymentMethod IN 
        ('Card', 'Bank Transfer', 'Cash on Delivery', 'Wallet', 'BNPL')),

    DeliveryStatus NVARCHAR(20)
        CHECK (DeliveryStatus IN 
        ('Delivered', 'In Transit', 'Cancelled', 'Returned')),

    DeliveryDays INT,

    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


/* ============================================================
   INSERT: Customers
   Purpose: Populate Customers table with sample user data
   ============================================================ */

INSERT INTO Customers (
    CustomerID,
    CustomerName,
    Email,
    Gender,
    City,
    State,
    SignupDate
)
VALUES
(1, 'Chinedu Okafor', 'chinedu.o@email.com', 'Male', 'Lagos', 'Lagos', '2024-01-03'),
(2, 'Aisha Bello', 'aisha.b@email.com', 'Female', 'Abuja', 'FCT', '2024-01-05'),
(3, 'Emeka Eze', 'emeka.e@email.com', 'Male', 'Enugu', 'Enugu', '2024-01-10'),
(4, 'Fatima Lawal', 'fatima.l@email.com', 'Female', 'Kano', 'Kano', '2024-01-12'),
(5, 'Tunde Adeyemi', 'tunde.a@email.com', 'Male', 'Ibadan', 'Oyo', '2024-01-15'),
(6, 'Ngozi Nwachukwu', 'ngozi.n@email.com', 'Female', 'Owerri', 'Imo', '2024-01-18'),
(7, 'Kabiru Sani', 'kabiru.s@email.com', 'Male', 'Kaduna', 'Kaduna', '2024-01-20'),
(8, 'Blessing Obi', 'blessing.o@email.com', 'Female', 'Lagos', 'Lagos', '2024-01-22'),
(9, 'Yusuf Danjuma', 'yusuf.d@email.com', 'Male', 'Abuja', 'FCT', '2024-02-01'),
(10, 'Amaka Chukwu', 'amaka.c@email.com', 'Female', 'Lagos', 'Lagos', '2024-02-05'),
(11, 'Oluwaseun Adebayo', 'seun.a@email.com', 'Male', 'Lagos', 'Lagos', '2024-02-08'),
(12, 'Halima Mohammed', 'halima.m@email.com', 'Female', 'Abuja', 'FCT', '2024-02-10'),
(13, 'Chisom Okonkwo', 'chisom.o@email.com', 'Female', 'Onitsha', 'Anambra', '2024-02-14'),
(14, 'Ahmed Musa', 'ahmed.m@email.com', 'Male', 'Kano', 'Kano', '2024-02-18'),
(15, 'Sade Fashola', 'sade.f@email.com', 'Female', 'Ibadan', 'Oyo', '2024-02-20'),
(16, 'Emeka Nnamdi', 'emeka.n@email.com', 'Male', 'Enugu', 'Enugu', '2024-03-01'),
(17, 'Zainab Garba', 'zainab.g@email.com', 'Female', 'Kano', 'Kano', '2024-03-05'),
(18, 'Funmi Adesanya', 'funmi.a@email.com', 'Female', 'Lagos', 'Lagos', '2024-03-10'),
(19, 'Ibrahim Umar', 'ibrahim.u@email.com', 'Male', 'Abuja', 'FCT', '2024-03-15'),
(20, 'Chidera Obiora', 'chidera.o@email.com', 'Male', 'Onitsha', 'Anambra', '2024-03-20');


/* ============================================================
   INSERT: Sellers
   Purpose: Populate Sellers table with marketplace vendors
   ============================================================ */

INSERT INTO Sellers (
    SellerID,
    SellerName,
    Category,
    City,
    JoinDate,
    Rating
)
VALUES
(1, 'TechZone NG', 'Electronics', 'Lagos', '2023-11-01', 4.5),
(2, 'FashionHub', 'Fashion', 'Abuja', '2023-11-15', 4.2),
(3, 'HomeGlow Interiors', 'Home & Living', 'Lagos', '2023-12-01', 3.8),
(4, 'GadgetKing', 'Electronics', 'Kano', '2023-12-10', 4.7),
(5, 'StyleFinds', 'Fashion', 'Ibadan', '2024-01-05', 3.5),
(6, 'KitchenPlus', 'Home & Living', 'Abuja', '2024-01-10', 4.0),
(7, 'SportZone', 'Sports', 'Lagos', '2024-01-20', 4.3),
(8, 'BookNest', 'Books', 'Enugu', '2024-02-01', 4.8);


/* ============================================================
   INSERT: Products
   Purpose: Populate Products table with inventory data
   ============================================================ */

INSERT INTO Products (
    ProductID,
    ProductName,
    Category,
    SellerID,
    UnitPrice,
    StockQuantity
)
VALUES
(1, 'Samsung Galaxy A54', 'Electronics', 1, 185000, 50),
(2, 'iPhone 14 Pro', 'Electronics', 4, 620000, 20),
(3, 'Ankara Maxi Dress', 'Fashion', 2, 8500, 200),
(4, 'Men''s Polo Shirt (3-Pack)', 'Fashion', 5, 12000, 150),
(5, 'Bluetooth Speaker JBL', 'Electronics', 1, 32000, 80),
(6, 'Standing Desk Lamp', 'Home & Living', 3, 7500, 100),
(7, 'Non-Stick Cookware Set', 'Home & Living', 6, 24500, 60),
(8, 'Yoga Mat Pro', 'Sports', 7, 11000, 120),
(9, 'Running Shoes Nike', 'Sports', 7, 45000, 70),
(10, 'Python for Beginners Book', 'Books', 8, 6500, 300),
(11, 'Data Analytics Handbook', 'Books', 8, 8000, 250),
(12, 'Wireless Earbuds Pro', 'Electronics', 4, 28000, 90),
(13, 'Office Chair Ergonomic', 'Home & Living', 3, 68000, 30),
(14, 'Ankara Jumpsuit', 'Fashion', 2, 11000, 180),
(15, 'Resistance Band Set', 'Sports', 7, 5500, 200);




-- ------------------------------------------------------------------------------------------------*/
-- Rebuilt the Orders table to resolve data type limitations
-- and ensure accurate storage of high-value transactions.

-- Key Improvements:
-- Increased numeric precision using DECIMAL(12,2) to prevent overflow errors
-- Maintained referential integrity through foreign key constraints
-- Implemented DROP TABLE IF EXISTS for safe and repeatable execution

-- This ensures a clean, consistent, and production-ready data structure
-- that supports reliable analytical reporting.
-- -----------------------------------------------------------------------------------------------------------*/.

   DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    OrderDate DATE NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    UnitPrice DECIMAL(12,2) NOT NULL,
    Discount DECIMAL(10,2) DEFAULT 0,
    TotalAmount DECIMAL(12,2) NOT NULL,
    PaymentMethod VARCHAR(30),
    DeliveryStatus VARCHAR(20),
    DeliveryDays INT,

    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);



INSERT INTO Orders (
    OrderID,
    CustomerID,
    ProductID,
    OrderDate,
    Quantity,
    UnitPrice,
    Discount,
    TotalAmount,
    PaymentMethod,
    DeliveryStatus,
    DeliveryDays
)
VALUES
(1, 1, 1, '2024-01-10', 1, 185000, 0, 185000, 'Card', 'Delivered', 3),
(2, 2, 3, '2024-01-11', 2, 8500, 0, 17000, 'Wallet', 'Delivered', 2),
(3, 3, 10, '2024-01-12', 1, 6500, 0, 6500, 'Bank Transfer', 'Delivered', 5),
(4, 4, 4, '2024-01-13', 3, 12000, 500, 35500, 'Cash on Delivery', 'Delivered', 4),
(5, 5, 8, '2024-01-14', 2, 11000, 0, 22000, 'Card', 'Delivered', 3),
(6, 6, 6, '2024-01-15', 1, 7500, 0, 7500, 'Wallet', 'Delivered', 2),
(7, 7, 12, '2024-01-16', 1, 28000, 0, 28000, 'Card', 'In Transit', 6),
(8,  8,  2,  '2024-01-17', 1, 620000, 20000, 600000, 'Bank Transfer',    'Delivered',  4),
(9,  9,  5,  '2024-01-18', 1, 32000,  0,     32000,  'Card',             'Delivered',  3),
(10, 10, 7,  '2024-01-19', 2, 24500,  0,     49000,  'BNPL',             'Delivered',  5),
(11, 1,  5,  '2024-01-22', 2, 32000,  0,     64000,  'Card',             'Delivered',  3),
(12, 2,  11, '2024-01-23', 1, 8000,   0,     8000,   'Wallet',           'Delivered',  2),
(13, 3,  9,  '2024-01-24', 1, 45000,  0,     45000,  'Bank Transfer',    'Cancelled',  NULL),
(14, 4,  13, '2024-01-25', 1, 68000,  5000,  63000,  'BNPL',             'Delivered',  7),
(15, 5,  15, '2024-01-26', 3, 5500,   0,     16500,  'Card',             'Delivered',  3),
(16, 6,  3,  '2024-01-28', 2, 8500,   0,     17000,  'Wallet',           'Delivered',  2),
(17, 7,  1,  '2024-01-29', 1, 185000, 10000, 175000, 'Card',             'Delivered',  4),
(18, 8,  8,  '2024-01-30', 1, 11000,  0,     11000,  'Cash on Delivery', 'Returned',   8),
(19, 9,  10, '2024-02-01', 2, 6500,   0,     13000,  'Wallet',           'Delivered',  3),
(20, 10, 4,  '2024-02-02', 2, 12000,  1000,  23000,  'Card',             'Delivered',  3),
(21, 11, 2,  '2024-02-03', 1, 620000, 25000, 595000, 'Bank Transfer',    'Delivered',  5),
(22, 12, 6,  '2024-02-04', 2, 7500,   0,     15000,  'Wallet',           'Delivered',  2),
(23, 13, 7,  '2024-02-05', 1, 24500,  0,     24500,  'BNPL',             'Delivered',  6),
(24, 14, 3,  '2024-02-06', 4, 8500,   0,     34000,  'Cash on Delivery', 'Delivered',  4),
(25, 15, 12, '2024-02-07', 2, 28000,  0,     56000,  'Card',             'Delivered',  3),
(26, 16, 9,  '2024-02-08', 1, 45000,  0,     45000,  'Bank Transfer',    'In Transit', 7),
(27, 17, 5,  '2024-02-09', 1, 32000,  0,     32000,  'Card',             'Delivered',  3),
(28, 18, 11, '2024-02-10', 2, 8000,   500,   15500,  'Wallet',           'Delivered',  2),
(29, 19, 15, '2024-02-11', 5, 5500,   0,     27500,  'Card',             'Delivered',  3),
(30, 20, 1,  '2024-02-12', 1, 185000, 0,     185000, 'BNPL',             'Delivered',  5),
(31, 1,  13, '2024-02-14', 1, 68000,  0,     68000,  'Card',             'Delivered',  6),
(32, 2,  9,  '2024-02-15', 1, 45000,  0,     45000,  'Bank Transfer',    'Cancelled',  NULL),
(33, 3,  4,  '2024-02-16', 2, 12000,  0,     24000,  'Wallet',           'Delivered',  4),
(34, 4,  8,  '2024-02-17', 2, 11000,  0,     22000,  'Card',             'Delivered',  3),
(35, 5,  2,  '2024-02-18', 1, 620000, 30000, 590000, 'BNPL',             'Delivered',  6),
(36, 6,  14, '2024-02-19', 2, 11000,  0,     22000,  'Cash on Delivery', 'Delivered',  4),
(37, 7,  10, '2024-02-20', 3, 6500,   0,     19500,  'Card',             'Delivered',  3),
(38, 8,  5,  '2024-02-21', 1, 32000,  2000,  30000,  'Wallet',           'Returned',   9),
(39, 9,  7,  '2024-02-22', 1, 24500,  0,     24500,  'Card',             'Delivered',  4),
(40, 10, 12, '2024-02-23', 2, 28000,  0,     56000,  'Bank Transfer',    'Delivered',  3),
(41, 11, 6,  '2024-02-25', 3, 7500,   0,     22500,  'Wallet',           'Delivered',  2),
(42, 12, 3,  '2024-02-26', 3, 8500,   0,     25500,  'Card',             'Delivered',  3),
(43, 13, 15, '2024-02-27', 4, 5500,   0,     22000,  'Cash on Delivery', 'Delivered',  3),
(44, 14, 11, '2024-02-28', 1, 8000,   0,     8000,   'BNPL',             'Delivered',  4),
(45, 15, 1,  '2024-03-01', 1, 185000, 10000, 175000, 'Card',             'Delivered',  4),
(46, 16, 4,  '2024-03-02', 2, 12000,  0,     24000,  'Bank Transfer',    'Delivered',  3),
(47, 17, 8,  '2024-03-03', 2, 11000,  0,     22000,  'Wallet',           'Delivered',  2),
(48, 18, 2,  '2024-03-04', 1, 620000, 20000, 600000, 'Card',             'Delivered',  5),
(49, 19, 9,  '2024-03-05', 1, 45000,  0,     45000,  'BNPL',             'In Transit', 8),
(50, 20, 14, '2024-03-06', 3, 11000,  0,     33000,  'Cash on Delivery', 'Delivered',  4),
(51, 1,  7,  '2024-03-08', 1, 24500,  0,     24500,  'Card',             'Delivered',  3),
(52, 2,  5,  '2024-03-09', 2, 32000,  2500,  61500,  'Wallet',           'Delivered',  3),
(53, 3,  12, '2024-03-10', 1, 28000,  0,     28000,  'Bank Transfer',    'Delivered',  4),
(54, 4,  6,  '2024-03-11', 2, 7500,   0,     15000,  'Card',             'Delivered',  2),
(55, 5,  13, '2024-03-12', 1, 68000,  5000,  63000,  'BNPL',             'Delivered',  7),
(56, 6,  10, '2024-03-13', 2, 6500,   0,     13000,  'Wallet',           'Delivered',  3),
(57, 7,  15, '2024-03-14', 3, 5500,   0,     16500,  'Card',             'Delivered',  2),
(58, 8,  11, '2024-03-15', 1, 8000,   0,     8000,   'Card',             'Cancelled',  NULL),
(59, 9,  3,  '2024-03-16', 3, 8500,   0,     25500,  'Cash on Delivery', 'Delivered',  4),
(60, 10, 1,  '2024-03-17', 1, 185000, 0,     185000, 'Bank Transfer',    'Delivered',  3),
(61, 11, 4,  '2024-03-18', 4, 12000,  2000,  46000,  'Card',             'Delivered',  3),
(62, 12, 8,  '2024-03-19', 1, 11000,  0,     11000,  'Wallet',           'Delivered',  2),
(63, 13, 9,  '2024-03-20', 1, 45000,  0,     45000,  'BNPL',             'Returned',   10),
(64, 14, 2,  '2024-03-21', 1, 620000, 30000, 590000, 'Bank Transfer',    'Delivered',  6),
(65, 15, 5,  '2024-03-22', 2, 32000,  0,     64000,  'Card',             'Delivered',  3),
(66, 16, 7,  '2024-03-23', 2, 24500,  0,     49000,  'Wallet',           'Delivered',  4),
(67, 17, 12, '2024-03-24', 1, 28000,  0,     28000,  'Cash on Delivery', 'Delivered',  3),
(68, 18, 14, '2024-03-25', 2, 11000,  1000,  21000,  'Card',             'Delivered',  3),
(69, 19, 6,  '2024-03-26', 1, 7500,   0,     7500,   'BNPL',             'Delivered',  2),
(70, 20, 11, '2024-03-27', 2, 8000,   0,     16000,  'Wallet',           'Delivered',  3),
(71, 1,  2,  '2024-04-01', 1, 620000, 25000, 595000, 'Card',             'Delivered',  5),
(72, 2,  15, '2024-04-02', 5, 5500,   0,     27500,  'Cash on Delivery', 'Delivered',  3),
(73, 3,  13, '2024-04-03', 1, 68000,  0,     68000,  'Bank Transfer',    'In Transit', 9),
(74, 4,  10, '2024-04-04', 2, 6500,   0,     13000,  'Wallet',           'Delivered',  3),
(75, 5,  4,  '2024-04-05', 3, 12000,  1500,  34500,  'Card',             'Delivered',  3),
(76, 6,  1,  '2024-04-06', 1, 185000, 0,     185000, 'BNPL',             'Delivered',  4),
(77, 7,  8,  '2024-04-07', 3, 11000,  0,     33000,  'Card',             'Delivered',  2),
(78, 8,  3,  '2024-04-08', 2, 8500,   0,     17000,  'Wallet',           'Returned',   7),
(79, 9,  5,  '2024-04-09', 1, 32000,  2000,  30000,  'Bank Transfer',    'Delivered',  3),
(80, 10, 9,  '2024-04-10', 1, 45000,  0,     45000,  'Card',             'Delivered',  4),
(81, 11, 12, '2024-04-11', 2, 28000,  0,     56000,  'BNPL',             'Delivered',  3),
(82, 12, 7,  '2024-04-12', 1, 24500,  0,     24500,  'Wallet',           'Cancelled',  NULL),
(83, 13, 11, '2024-04-13', 3, 8000,   0,     24000,  'Card',             'Delivered',  3),
(84, 14, 6,  '2024-04-14', 2, 7500,   0,     15000,  'Cash on Delivery', 'Delivered',  2),
(85, 15, 2,  '2024-04-15', 1, 620000, 20000, 600000, 'Bank Transfer',    'Delivered',  5),
(86, 16, 14, '2024-04-16', 3, 11000,  0,     33000,  'Card',             'Delivered',  3),
(87, 17, 3,  '2024-04-17', 2, 8500,   0,     17000,  'Wallet',           'Delivered',  2),
(88, 18, 9,  '2024-04-18', 1, 45000,  3000,  42000,  'BNPL',             'Delivered',  4),
(89, 19, 15, '2024-04-19', 4, 5500,   0,     22000,  'Card',             'Delivered',  3),
(90, 20, 12, '2024-04-20', 2, 28000,  0,     56000,  'Bank Transfer',    'Delivered',  4),
(91, 1,  8,  '2024-04-22', 2, 11000,  0,     22000,  'Card',             'Delivered',  3),
(92, 2,  1,  '2024-04-23', 1, 185000, 0,     185000, 'Wallet',           'In Transit', 6),
(93, 3,  4,  '2024-04-24', 2, 12000,  1000,  23000,  'Card',             'Delivered',  3),
(94, 4,  5,  '2024-04-25', 1, 32000,  0,     32000,  'BNPL',             'Delivered',  3),
(95, 5,  11, '2024-04-26', 2, 8000,   0,     16000,  'Bank Transfer',    'Delivered',  2),
(96, 6,  13, '2024-04-27', 1, 68000,  5000,  63000,  'Card',             'Delivered',  6),
(97, 7,  7,  '2024-04-28', 2, 24500,  0,     49000,  'Cash on Delivery', 'Delivered',  4),
(98, 8,  10, '2024-04-29', 3, 6500,   0,     19500,  'Wallet',           'Delivered',  3),
(99, 9,  2,  '2024-04-30', 1, 620000, 25000, 595000, 'Card',             'Delivered',  5),
(100,10, 14, '2024-04-30', 2, 11000,  0,     22000,  'BNPL',             'Returned',   8);







/* ============================================================
   SECTION B: KPI SUMMARY DASHBOARD (20 Marks)
   ============================================================
   The Head of Analytics needs a one-page KPI summary.
   Write ONE query for EACH KPI below.
   Each query should return a single, clearly labelled result.
   ============================================================ */

-- Question 1
-- What is the Total Revenue generated by ShopNest
-- across all delivered orders?
-- Label the result as: TotalRevenue

SELECT 
SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE DeliveryStatus = 'Delivered';

-- ---------------------------------------------------------------------------------------------------------------------------
-- This query calculates the total revenue generated from all orders in the Orders table.( 7,988,500)
-- It only includes orders where the DeliveryStatus is 'Delivered'.
-- The result represents the total amount of money successfully earned by ShopNest.
-- ---------------------------------------------------------------------------------------------------------------------------*/


-- Question 2
-- How many unique customers placed at least one order?

SELECT
(COUNT(DISTINCT CustomerID)) AS   ActiveCustomers
FROM Orders;
-- ----------------------------------------------------------------------------------------------------------
-- This query calculates the number of unique customers who have placed at least one order.
-- By using COUNT(DISTINCT CustomerID) on the Orders table, it ensures each customer is only counted once,
-- regardless of how many orders they have made.
-- The result shows that 20 unique customers have made purchases, indicating that all customers
-- in the dataset are active and have completed at least one transaction.
-- --------------------------------------------------------------------------------------------------------------*/

-- Question 3
-- What is the Average Order Value (AOV) per month?
-- Show: OrderMonth, TotalOrders, TotalRevenue, AOV

SELECT 
DATENAME(MONTH,OrderDate)   AS OrderMonth,
COUNT(DISTINCT OrderID) AS TotalOrders,
SUM(TotalAmount)   AS TotalRevenue,
AVG(TotalAmount)  AS AOV
FROM Orders
GROUP BY
YEAR(Orderdate),
MONTH(OrderDate),
DATENAME(MONTH,OrderDate)
ORDER BY 
YEAR(OrderDate),
MONTH(OrderDate);

-- -------------------------------------------------------------------------------------------------
-- This query calculates the Average Order Value (AOV) per month.
-- It returns the total number of orders, total revenue, and average order value for each month.

-- DATENAME(MONTH, OrderDate) is used to display readable month names (e.g., January, February).
-- MONTH(OrderDate) is used to ensure correct chronological ordering (1–12).
-- YEAR(OrderDate) is included to prevent mixing data from different years (important for scalability).

-- GROUP BY includes YEAR, MONTH, and DATENAME to ensure accurate aggregation at a monthly level.
-- ORDER BY uses YEAR and MONTH to maintain proper time sequence rather than alphabetical sorting.
-- --------------------------------------------------------------------------------------------------------------------*/

-- Question 4
-- What is the cancellation and return rate?
-- Show: TotalOrders, Delivered, Cancelled, Returned,

SELECT
COUNT (*) AS TotalOrders,
    COUNT(CASE WHEN DeliveryStatus = 'Delivered' THEN 1 END) AS Delivered,
    COUNT(CASE WHEN DeliveryStatus = 'Cancelled' THEN 1 END) AS Cancelled,
    COUNT(CASE WHEN DeliveryStatus = 'Returned' THEN 1 END) AS Returned,
    CAST(ROUND(COUNT(CASE WHEN DeliveryStatus = 'Cancelled' THEN 1 END) * 100.0 / COUNT(*), 2) AS DECIMAL(5,2)) AS CancellationRate,
    CAST(ROUND(COUNT(CASE WHEN DeliveryStatus = 'Returned' THEN 1 END) * 100.0 /COUNT (*),2) AS DECIMAL(5,2)) AS ReturnRate
FROM Orders;

-- ---------------------------------------------------------------------------------------------------------------
-- This query calculates key operational KPIs related to order fulfilment performance.
-- It returns the total number of orders alongside the number of delivered, cancelled, and returned orders.
-- Conditional aggregation using CASE statements is applied to segment orders by their delivery status.

-- CancellationRate and ReturnRate are calculated as percentages of total orders,
-- using COUNT with conditional logic divided by the total order count.
-- The results are rounded and cast to DECIMAL(5,2) to ensure consistent formatting.

-- This approach provides a clear breakdown of order outcomes and helps assess
-- operational efficiency, customer satisfaction, and potential issues in the fulfilment process.
-- ---------------------------------------------------------------------------------------------------*/

-- Question 5
-- What is the revenue breakdown by product category?
-- Show: Category, TotalOrders, TotalRevenue, AvgOrderValue,
--       RevenueShare (% of grand total)

WITH ProductCategory AS (
SELECT Category,
COUNT(DISTINCT OrderID) AS TotalOrders,
SUM(TotalAmount)   AS TotalRevenue,
AVG(TotalAmount)  AS AOV
FROM Orders
INNER JOIN Products ON Orders.ProductID = Products.ProductID
GROUP BY Category)


SELECT 
Category,
TotalOrders,
TotalRevenue,
AOV,
  -- Revenue share calculation
CAST(
     (TotalRevenue * 100.0) / SUM(TotalRevenue) OVER () AS DECIMAL (5,2) 
   )  AS RevenueShare
   FROM ProductCategory
   ORDER BY TotalRevenue DESC;

   -- =---------------------------------------------------------------------------------------------------

   -- This query analyzes revenue performance across product categories by calculating  
-- total orders, total revenue, and average order value (AOV) for each category.  

-- A Common Table Expression (CTE) is used to first aggregate the data at the category level,  
-- ensuring accurate calculations before deriving additional insights.  

-- The RevenueShare metric represents the percentage contribution of each category  
-- to the overall revenue, calculated using a window function (SUM() OVER()).  
-- This allows comparison of each category against the total revenue without collapsing the dataset.  

-- Results show that the Electronics category dominates revenue contribution (~77.77%),  
-- indicating it is the primary driver of business performance.  
-- Other categories such as Home, Sports, and Fashion contribute moderately,  
-- while Books has minimal impact (~2.09%).  

-- This insight helps assess business dependency on specific categories,  
-- identify growth opportunities, and highlight potential risks due to over-reliance  
-- on a single high-performing category.
-- ------------------------------------------------------------------------------------------------------------------------*/

-- Question 6
-- Which are the TOP 5 products by total revenue?
-- Show: ProductName, Category, SellerName, TotalOrders,
--       TotalRevenue, TotalDiscountGiven
-- Order by TotalRevenue DESC

SELECT TOP 5
Products.ProductName,
Products.Category,
Sellers.SellerName,
COUNT(DISTINCT OrderID) AS TotalOrders,
SUM(TotalAmount)   AS TotalRevenue,
SUM(Discount) AS TotalDiscountGiven
FROM Products
INNER JOIN Orders ON Products.ProductID = Orders.ProductID
INNER JOIN Sellers ON Products.SellerID = Sellers.SellerID
GROUP BY Products.ProductName,
Products.Category,
Sellers.SellerName
ORDER BY TotalRevenue DESC;

-- --------------------------------------------------------------------------------------------------------------
-- This query identifies the top 5 best-performing products based on total revenue.  
-- It combines data from Products, Orders, and Sellers to show product performance alongside seller contribution.  

-- The results reveal that high-value electronic products dominate the top positions,  
-- with items like iPhone 14 Pro and Samsung Galaxy A54 generating the highest revenue.  

-- This indicates strong customer demand for electronics and highlights key products  
-- and sellers driving overall business performance.
-- -------------------------------------------------------------------------------------------------------------*/


-- Question 7
-- Which payment method generates the most revenue?
-- Show: PaymentMethod, TotalOrders, TotalRevenue,
--       AvgOrderValue, RevenueShare (%)
-- Order by TotalRevenue DESC

SELECT PaymentMethod,
       COUNT(DISTINCT OrderID) AS TotalOrders,
       SUM(TotalAmount)   AS TotalRevenue,
       AVG(TotalAmount)  AS AOV,
       CAST(
    SUM(TotalAmount) * 100.0 /  SUM(SUM(TotalAmount)) OVER() 
    AS DECIMAL (5,2)) AS RevenueShare
FROM Orders
GROUP BY PaymentMethod
ORDER BY TotalRevenue DESC;

-- ------------------------------------------------------------------------------------------------------------
-- This query analyzes revenue performance by payment method, showing total orders,
-- total revenue, average order value (AOV), and each method’s contribution to overall revenue.

-- Results show that Card payments generate the highest revenue (~38%), followed by Bank Transfer (~34%),
-- indicating that digital payment methods dominate sales performance.
-- Wallet and BNPL contribute moderately, while Cash on Delivery has the lowest revenue share (~3.5%).

-- This insight helps identify the most valuable payment channels and supports decisions
-- around optimizing payment options and improving customer experience.
-- --------------------------------------------------------------------------------------------------------------*/

-- Question 8
-- Build a monthly revenue trend report showing
-- month-over-month growth.
-- Show: OrderMonth, TotalRevenue, PreviousMonthRevenue,
--       RevenueGrowth (₦), GrowthRate (%)


SELECT 
    FORMAT(OrderDate, 'yyyy-MM') AS OrderMonth,
    COUNT(DISTINCT OrderID) AS TotalOrders,
    SUM(TotalAmount) AS TotalRevenue,
    LAG(SUM(TotalAmount)) OVER (ORDER BY MIN(OrderDate)) AS PreviousMonthRevenue,
    SUM(TotalAmount) - LAG(SUM(TotalAmount)) OVER (ORDER BY MIN(OrderDate)) AS RevenueGrowth,
    CAST(
        (SUM(TotalAmount) - LAG(SUM(TotalAmount)) OVER (ORDER BY MIN(OrderDate))) 
        * 100.0 / LAG(SUM(TotalAmount)) OVER (ORDER BY MIN(OrderDate))
    AS DECIMAL(5,2)) AS GrowthRate
FROM Orders
GROUP BY FORMAT(OrderDate, 'yyyy-MM')
ORDER BY MIN(OrderDate);

-- -------------------------------------------------------------------------------------------------------------
-- This query analyzes monthly revenue trends by calculating total revenue,
-- previous month revenue, absolute growth, and percentage growth.

-- Results show strong growth in February (+47.94%), followed by slower growth in March,
-- and a significant increase again in April (+33.72%), indicating fluctuating but overall upward performance.
-- ShopNest revenue grew consistently across all four months, from ₦1.38M in January to
-- ₦2.96M in April. February saw the highest growth rate at 47.94%, likely driven by early
-- customer acquisition. Growth slowed in March to 8.41% before recovering strongly in April
-- at 33.72%, suggesting seasonal demand patterns or successful promotional activity
-- --------------------------------------------------------------------------------------------------------------------------*/



-- Question 9
-- Identify customers who have placed MORE THAN 3 orders.
-- Show: CustomerName, City, State, TotalOrders,
--       TotalRevenue, FirstOrderDate, LastOrderDate,
--       DaysBetweenFirstAndLastOrder
-- Order by TotalOrders DESC

SELECT
Customers.CustomerName,Customers.City,Customers.State,
COUNT(DISTINCT OrderID)      AS TotalOrders,
SUM(TotalAmount)             AS TotalRevenue,
MIN(OrderDate)           AS FirstOrderDate,
MAX(OrderDate)          AS LastOrderDate,
DATEDIFF (DAY, MIN(OrderDate), MAX(OrderDate)) AS DaysBetweenFirstAndLastOrder
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.CustomerName,Customers.City,Customers.State
HAVING COUNT(DISTINCT OrderID) > 3
ORDER BY TotalOrders DESC;

-- -----------------------------------------------------------------------------------------------------------------------------------*/
-- This query identifies high-value customers who have placed more than 3 orders,
-- providing a detailed view of their purchasing behavior and engagement over time.

-- It calculates total orders, total revenue, first and last purchase dates,
-- and the number of days between a customer’s first and most recent order,
-- offering insight into customer longevity and activity span.

-- Results show that several customers consistently placed 6 orders within a similar time frame
-- (approximately 102–103 days), indicating a stable and repeat purchasing pattern.
-- Customers with 4 orders show a shorter engagement window (~68 days),
-- suggesting more recent or less frequent interaction.

-- High-performing customers such as Chinedu Okafor and Tunde Adeyemi generate significant revenue,
-- highlighting the importance of repeat buyers in overall business performance.

-- This analysis helps identify loyal customers, measure retention behavior,
-- and supports targeted marketing strategies such as loyalty programs,
-- personalized offers, and customer lifetime value optimization.
-- -----------------------------------------------------------------------------------------------*/
-- QUICK BUSINESS INSIGHT 
-- Top 10 customers all placed 6 orders each — they're your most loyal customers
-- Chinedu Okafor has the highest revenue at ₦958,500 — your most valuable customer
-- Most loyal customers joined in January 2024 — early adopters are your best customers
-- Everyone has roughly 68-103 days between first and last order — consistent engagement
-- --------------------------------------------------------------------------------------------------------*/


-- Question 10
-- Which customers placed their FIRST ever order in January 2024
-- but have NOT ordered since February 2024?
-- (Hint: These are your churned early adopters)
-- Show: CustomerName, Email, City, FirstOrderDate

SELECT 
    Customers.CustomerName,
    Customers.Email,
    Customers.City,
    MIN(OrderDate) AS FirstOrderDate
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.CustomerName, Customers.Email, Customers.City
HAVING MIN(OrderDate) >= '2024-01-01' 
AND MIN(OrderDate) < '2024-02-01'
AND MAX(OrderDate) < '2024-02-01'
ORDER BY FirstOrderDate;

-- --------------------------------------------------------------------------------------------------------------*/
-- Result: No customers returned
-- This is expected based on the dataset.
-- All ShopNest customers placed orders across multiple months,
-- indicating no churned early adopters exist in this dataset.
-- Query logic verified by testing across January and February 2024.

-- This query identifies customers who made their first-ever purchase in January 2024
-- but did not return to place another order in February 2024, highlighting early churn behavior.

-- It calculates each customer’s first order date and filters for those whose initial purchase
-- occurred in January, while excluding customers with any activity in February.

-- The results represent "early churned customers" — users who engaged initially
-- but did not continue their purchasing journey in the following month.

-- This insight is critical for understanding customer drop-off patterns,
-- especially among new users, and can help businesses improve onboarding,
-- retention strategies, and early engagement campaigns.

-- By identifying these customers, the business can implement targeted actions
-- such as follow-up promotions, personalized communication, or incentives
-- to reduce churn and increase customer lifetime value.
-- ---------------------------------------------------------------------------------------------------------------------------*/



-- Question 11
-- Classify customers using a CASE statement:
-- 'VIP'      → Total spend above ₦500,000
-- 'Regular'  → Total spend between ₦100,000 and ₦500,000
-- 'Casual'   → Total spend below ₦100,000
-- Show: CustomerName, City, TotalOrders, TotalSpend, CustomerTier
-- Order by TotalSpend DESC

SELECT
Customers.CustomerName, Customers.City,
COUNT(OrderID)   AS   TotalOrders,
SUM(DISTINCT TotalAmount)   AS TotalSpend,
CASE WHEN SUM(TotalAmount) > 500000 THEN 'VIP'
     WHEN SUM(TotalAmount) BETWEEN 100000 AND 500000 THEN 'Regular'
     WHEN SUM(TotalAmount) < 100000 THEN 'Casual' ELSE 'Irregular'
END AS CustomerTier
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName, Customers.City
ORDER BY TotalSpend DESC;

-- ----------------------------------------------------------------------------------------------------------------*/
-- This query segments customers into value-based tiers (VIP, Regular, Casual)
-- using their total spending, providing insight into customer purchasing behavior.
-- 
-- The results highlight that VIP customers contribute the highest revenue,
-- while Regular and Casual customers represent lower spending segments.
-- 
-- This classification enables better business decisions such as targeting
-- high-value customers for retention, upselling mid-tier customers, and
-- re-engaging low-value customers to improve overall revenue performance.
-- -------------------------------------------------------------------------------------------------------------------*/


-- Question 12
-- Which product category has the highest average
-- delivery time for delivered orders?
-- Show: Category, TotalDeliveredOrders, AvgDeliveryDays,
-- MinDeliveryDays, MaxDeliveryDays
-- Order by AvgDeliveryDays DESC
-- HINT: Filter for Delivered status only

SELECT Category,
COUNT(DISTINCT OrderID)                           AS TotalDeliveredOrders,
AVG(DeliveryDays)                                 AS AvgDeliveryDays,
MIN(DeliveryDays)                                 AS MinDeliveryDays,
MAX(DeliveryDays)                                 AS MaxDeliveryDays
FROM Products
INNER JOIN Orders ON Products.ProductID = Orders.ProductID
WHERE DeliveryStatus = 'Delivered'
GROUP BY Category
ORDER BY AvgDeliveryDays DESC;


-- -------------------------------------------------------------------------------------------------------------------*/
-- This query analyzes delivery performance across product categories by focusing
-- only on successfully delivered orders.
--
-- It calculates the total number of delivered orders, along with average,
-- minimum, and maximum delivery times (in days) for each category.
--
-- The results show that "Home & Living" has the highest average delivery time( 4 days),
-- indicating slower fulfillment compared to other categories, while "Sports"
-- has the fastest average delivery(2 days).
--
-- These insights help identify operational inefficiencies in logistics and
-- highlight opportunities to optimize delivery speed, improve customer
-- satisfaction, and streamline supply chain performance.
-- -----------------------------------------------------------------------------------------------------------------------*/

-- Question 13
-- Find all products that have NEVER been ordered.
-- Show: ProductID, ProductName, Category, SellerName, UnitPrice
-- HINT: Use a LEFT JOIN or NOT EXISTS

SELECT
    Products.ProductID,
    Products.ProductName,
    Products.Category,
    Sellers.SellerName,
    Products.UnitPrice
FROM Products
LEFT JOIN Orders ON Products.ProductID = Orders.ProductID
LEFT JOIN Sellers ON Products.SellerID = Sellers.SellerID
WHERE Orders.OrderID IS NULL;

-- ----------------------------------------------------------------------------------------------------------------------------*/
-- Result: No products returned
-- All 15 products in the ShopNest catalogue have been ordered
-- at least once during the analysis period.
-- Query logic verified by confirming 15 distinct ProductIDs
-- exist in the Orders table matching all products in the Products table.
-- ------------------------------------------------------------------------------------------------------------------------*/


-- Question 14
-- Rank sellers by total revenue generated through their products.
-- Show: SellerName, Category, SellerRating, TotalOrders,
-- TotalRevenue, TotalDiscounts,
-- PerformanceLabel (use CASE):
--'Top Seller'  → Revenue above ₦1,000,000
--'Growing'     → Revenue between ₦500,000 and ₦1,000,000
--'Needs Growth'→ Revenue below ₦500,000

SELECT 
    Sellers.SellerName,
    Products.Category,
    Sellers.Rating,
COUNT(DISTINCT OrderID)           AS TotalOrders,
SUM(TotalAmount)                   AS TotalRevenue,
SUM(Discount)                     AS TotalDiscounts,
CASE
    WHEN SUM(TotalAmount) > 1000000 THEN 'Top Seller'
    WHEN SUM(TotalAmount) BETWEEN 500000 AND 1000000 THEN 'Growing'
    WHEN SUM(TotalAmount) < 500000 THEN 'Needs Growth'
    ELSE 'Poor Seller'
    END AS PerformanceLabel
FROM Sellers
INNER JOIN Products ON Sellers.SellerID = Products.SellerID
INNER JOIN Orders ON Products.ProductID = Orders.ProductID
GROUP BY  Sellers.SellerName,
    Products.Category,
    Sellers.Rating
ORDER BY TotalRevenue DESC;

-- ----------------------------------------------------------------------------------------------------------------------*/
-- This query evaluates seller performance by aggregating total orders, revenue,
-- and discounts across their products, and classifies them into performance tiers
-- using a CASE statement.
-- Result: Electronics dominates — GadgetKing and TechZone NG are the only Top Sellers,
-- generating the majority of ShopNest's revenue. Every other category falls into Needs
-- Growth, suggesting ShopNest is heavily dependent on Electronics for revenue. BookNest
-- has the highest rating (4.8) but the lowest revenue — suggesting quality doesn't always translate to sales volume.

-- The results show that a small number of sellers generate the highest revenue
-- (Top Sellers), while the majority fall into the 'Needs Growth' category,
-- indicating potential gaps in performance.

-- This analysis enables data-driven decision-making by helping businesses identify
-- high-performing sellers to reward, mid-tier sellers to support, and low-performing
-- sellers who may require intervention, optimization, or strategic review.
-- -----------------------------------------------------------------------------------------------------------------------------*/



-- Question 15
-- Which sellers have an average delivery time
-- ABOVE the overall platform average?
-- Show: SellerName, Category, AvgDeliveryDays,
-- PlatformAvgDeliveryDays, DaysAbovePlatformAvg


SELECT Sellers.SellerName,
        Sellers.Category,
        AVG(DeliveryDays)           AS AvgDeliveryDays,
(SELECT AVG(DeliveryDays) FROM Orders WHERE DeliveryStatus = 'Delivered') AS PlatformAverageDeliveryDays,
AVG(DeliveryDays) - (SELECT AVG(DeliveryDays) FROM Orders WHERE DeliveryStatus = 'Delivered') AS DaysAbovePlatformAvg
FROM Sellers
INNER JOIN Products ON Sellers.SellerID = Products.SellerID
INNER JOIN Orders ON Products.ProductID = Orders.ProductID
GROUP BY Sellers.SellerName,
         Sellers.Category
HAVING AVG(DeliveryDays) > (SELECT AVG(DeliveryDays) FROM Orders WHERE DeliveryStatus = 'Delivered')
ORDER BY AvgDeliveryDays DESC;

-- ----------------------------------------------------------------------------------------------------------------------------*/
-- This query identifies sellers whose average delivery time exceeds the overall
-- platform average for delivered orders.
--
-- It calculates each seller’s average delivery time and compares it against the
-- platform-wide average, also showing the difference in days.

-- The results reveal that GadgetKing, HomeGlow, KitchenPlus and SportZone all deliver 1 day slower than the platform average. 
-- Operations team should investigate why these sellers are slower.  
-- This analysis is valuable for performance monitoring, enabling businesses to
-- pinpoint underperforming sellers, improve delivery operations, and enhance
-- overall customer satisfaction by reducing delays.
-- ----------------------------------------------------------------------------------------------------------------------------------*/



-- Question 16  (SELLER PERFORMANCE SCORECARD)
-- The operations team wants a complete seller scorecard.
-- Using CTEs, build a report that shows for each seller:
--
--   Step 1 (CTE 1 - SellerMetrics):
--   Calculate per seller:
--   - TotalOrders, TotalRevenue, TotalDiscounts,
--     AvgDeliveryDays, CancelledOrders, ReturnedOrders
--
--   Step 2 (CTE 2 - SellerScores):
--   Using SellerMetrics, add:
--   - CancellationRate (%)
--   - ReturnRate (%)
--   - ReliabilityScore: CASE
--       'Excellent' → CancellationRate < 5 AND AvgDeliveryDays <= 4
--       'Good'      → CancellationRate < 10 AND AvgDeliveryDays <= 6
--       'Poor'      → Everything else
--
--   Final SELECT: Show all columns from SellerScores
--   ordered by TotalRevenue DESC


WITH SellerMetrics AS (
SELECT  Sellers.SellerName,
        Sellers.Category,
        Sellers.Rating,
COUNT(DISTINCT OrderID)           AS TotalOrders,
SUM(TotalAmount)                   AS TotalRevenue,
SUM(Discount)                     AS TotalDiscounts,
AVG(DeliveryDays)           AS AvgDeliveryDays,
COUNT(CASE WHEN Orders.DeliveryStatus = 'Cancelled' THEN 1 END) AS CancelledOrders,
COUNT(CASE WHEN Orders.DeliveryStatus = 'Returned' THEN 1 END) AS ReturnedOrders
FROM Sellers
INNER JOIN Products ON Sellers.SellerID = Products.SellerID
INNER JOIN Orders ON Products.ProductID = Orders.ProductID
GROUP BY Sellers.SellerName, Sellers.Category, Sellers.Rating
),

SellerScore AS (
SELECT*,
CAST(CancelledOrders * 100.0 / TotalOrders AS DECIMAL (5,2)) AS CancellationRate,
CAST(ReturnedOrders  * 100.0 / TotalOrders AS DECIMAL (5,2)) AS ReturnRate,
CASE
    WHEN( CancelledOrders * 100.0 / TotalOrders)  < 5 AND AvgDeliveryDays <= 4 THEN 'Excellent'
    WHEN(CancelledOrders * 100.0 / TotalOrders) < 10 AND AvgDeliveryDays <= 6 THEN 'Good'
    ELSE 'Poor'
END AS ReliabilityScore
FROM SellerMetrics
) 
SELECT * FROM SellerScore
ORDER BY TotalRevenue DESC;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- This analysis evaluates seller performance by combining operational efficiency 
-- and customer experience metrics into a single reliability score.

-- Key metrics calculated include:
-- - TotalOrders and TotalRevenue to measure sales performance
-- - TotalDiscounts to assess pricing strategies
-- - AvgDeliveryDays to evaluate delivery efficiency
-- - CancelledOrders and ReturnedOrders to capture fulfillment issues

-- From these, CancellationRate (%) and ReturnRate (%) are derived to quantify
-- the proportion of problematic orders per seller.

-- A CASE-based classification is applied to segment sellers into:
-- - 'Excellent' → Low cancellation rate (<5%) and fast delivery (≤4 days)
-- - 'Good'      → Moderate cancellation rate (<10%) and acceptable delivery (≤6 days)
-- - 'Poor'      → High cancellations or slower delivery performance

-- Key insights from the results:
-- - High-performing sellers like GadgetKing and TechZone NG achieve strong revenue 
--   while maintaining low cancellation and return rates, earning an 'Excellent' rating.
-- - Some sellers generate solid revenue but suffer from higher return or cancellation 
--   rates, reducing their reliability classification.
-- - A few sellers likw SportZone and KitchenPlus fall into the 'Poor' category, indicating operational inefficiencies 
--   that may impact customer satisfaction and retention.

-- This analysis provides a balanced view of seller performance beyond revenue alone,
-- enabling data-driven decisions for vendor management, quality control, 
-- and platform optimization.
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------*/





-- Question 17  (CUSTOMER PURCHASE JOURNEY)
-- Marketing wants to understand the full customer journey.
-- Using CTEs, build a report that shows:
--
--   Step 1 (CTE 1 - CustomerOrders):
--   Per customer: TotalOrders, TotalSpent, TotalDiscount,
--   FirstOrderDate, LastOrderDate, FavouriteCategory
--   (category with the most orders for that customer)
--
--   Step 2 (CTE 2 - CustomerJourney):
--   Using CustomerOrders, add:
--   - CustomerLifespanDays (days between first and last order)
--   - AvgDaysBetweenOrders (lifespan / total orders)
--   - SpendTier: CASE
--       'VIP'     → TotalSpent > ₦500,000
--       'Regular' → TotalSpent BETWEEN ₦100,000 AND ₦500,000
--       'Casual'  → TotalSpent < ₦100,000
--
--   Final SELECT: Join back to Customers table to get
--   CustomerName, Email, City, State, SignupDate
--   + all columns from CustomerJourney
--   Order by TotalSpent DESC

WITH CustomerOrders AS (
    SELECT 
        Customers.CustomerID,
        Customers.CustomerName,
        COUNT(DISTINCT Orders.OrderID)  AS TotalOrders,
        SUM(Orders.TotalAmount)         AS TotalSpent,
        SUM(Orders.Discount)            AS TotalDiscount,
        MIN(Orders.OrderDate)           AS FirstOrderDate,
        MAX(Orders.OrderDate)           AS LastOrderDate,
        (SELECT TOP 1 p2.Category 
         FROM Orders o2
         INNER JOIN Products p2 ON o2.ProductID = p2.ProductID
         WHERE o2.CustomerID = Customers.CustomerID
         GROUP BY p2.Category
         ORDER BY COUNT(*) DESC) AS FavouriteCategory
    FROM Customers
    INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
    INNER JOIN Products ON Orders.ProductID = Products.ProductID
    GROUP BY Customers.CustomerID, Customers.CustomerName
),
CustomerJourney AS (
    SELECT *,
        DATEDIFF(DAY, FirstOrderDate, LastOrderDate) AS CustomerLifespanDays,
        DATEDIFF(DAY, FirstOrderDate, LastOrderDate) / TotalOrders AS AvgDaysBetweenOrders,
        CASE
            WHEN TotalSpent > 500000 THEN 'VIP'
            WHEN TotalSpent BETWEEN 100000 AND 500000 THEN 'Regular'
            WHEN TotalSpent < 100000 THEN 'Casual'
            ELSE 'Casual'
        END AS SpendTier
    FROM CustomerOrders
)
SELECT 
    Customers.CustomerName,
    Customers.Email,
    Customers.City,
    Customers.State,
    Customers.SignupDate,
    CustomerJourney.TotalOrders,
    CustomerJourney.TotalSpent,
    CustomerJourney.TotalDiscount,
    CustomerJourney.FirstOrderDate,
    CustomerJourney.LastOrderDate,
    CustomerJourney.FavouriteCategory,
    CustomerJourney.CustomerLifespanDays,
    CustomerJourney.AvgDaysBetweenOrders,
    CustomerJourney.SpendTier
FROM CustomerJourney
INNER JOIN Customers ON CustomerJourney.CustomerID = Customers.CustomerID
ORDER BY TotalSpent DESC;


-- This analysis builds a comprehensive customer journey report by combining
-- transactional behavior with customer profile data.
--
-- Step 1 (CustomerOrders):
-- Aggregates customer-level metrics such as total orders, total spend,
-- total discounts, and identifies the first and last purchase dates.
-- A correlated subquery is used to determine each customer's favourite
-- product category based on highest purchase frequency.
--
-- Step 2 (CustomerJourney):
-- Enhances the dataset by calculating customer lifespan (difference between
-- first and last order dates) and average time between orders.
-- Customers are segmented into spend tiers:
--   - 'VIP'     : TotalSpend > 500,000
--   - 'Regular' : TotalSpend between 100,000 and 500,000
--   - 'Casual'  : TotalSpend < 100,000
--
-- Final Output:
-- Combines customer demographic data (name, email, city, state, signup date)
-- with behavioral insights to provide a 360-degree view of each customer.
--
-- Key Results & Insights:
-- 1. High-value customers (VIPs) dominate the top of the dataset, with
--    total spend reaching up to ~958,500, indicating strong revenue concentration
--    among a small group of customers.
--
-- 2. The most frequent favourite category across customers is 'Electronics',
--    followed by 'Sports' and 'Fashion', suggesting these categories are
--    primary drivers of customer engagement and sales.
--
-- 3. Customer lifespan is relatively consistent (typically ~68 to 103 days),
--    and the average time between orders is stable (~17 days), indicating
--    predictable purchasing behavior across the customer base.
--
-- 4. 'Regular' customers form a significant portion of the dataset,
--    representing an opportunity for targeted strategies to convert them
--    into high-value (VIP) customers.
--
-- 5. 'Casual' customers contribute the least revenue and may require
--    re-engagement strategies such as promotions or personalized offers.
--
-- Business Impact:
-- This analysis enables data-driven decision-making by helping identify
-- high-value customers, understand purchasing patterns, and optimize
-- marketing strategies for retention and revenue growth.
-- -----------------------------------------------------------------------------------------------------------------------------------------*/

-- =========================================================
-- SHOPNEST ANALYSIS – FINAL OVERVIEW & BUSINESS CONCLUSION
-- =========================================================
--
-- This project provides a comprehensive analysis of the ShopNest
-- e-commerce platform, covering customer behavior, seller performance,
-- product trends, and operational efficiency.
--
-- Overall Findings:
--
-- 1. Revenue Concentration:
-- A small group of high-value customers (VIPs) and top-performing sellers
-- contribute a significant portion of total revenue. This indicates a
-- dependency on a limited segment for business performance.
--
-- 2. Customer Behavior:
-- Customers exhibit relatively consistent purchasing patterns, with
-- average order intervals remaining stable. However, most customers fall
-- within the 'Regular' and 'Casual' tiers, highlighting an opportunity
-- to increase customer lifetime value through targeted engagement.
--
-- 3. Product & Category Trends:
-- Categories such as Electronics, Sports, and Fashion drive the majority
-- of customer purchases, making them key areas for inventory optimization,
-- promotions, and strategic growth.
--
-- 4. Seller Performance:
-- Only a few sellers qualify as 'Top Sellers', while the majority fall
-- into 'Needs Growth'. Additionally, some sellers show operational
-- inefficiencies (e.g., higher cancellation rates or slower delivery times),
-- which may negatively impact customer experience.
--
-- 5. Operational Efficiency:
-- Delivery performance is generally consistent across the platform,
-- but certain categories and sellers experience slightly higher delivery
-- times. Monitoring and optimizing logistics can further improve efficiency.
--
-- 6. Risk & Opportunities:
-- - Risk: Over-reliance on top customers and sellers
-- - Opportunity: Convert 'Regular' customers into 'VIPs'
-- - Opportunity: Support underperforming sellers to improve platform balance
-- - Opportunity: Leverage high-performing categories for growth strategies
--
-- Final Conclusion:
-- ShopNest demonstrates strong revenue potential with identifiable
-- high-performing segments. However, sustainable growth will depend on
-- improving seller performance distribution, increasing customer retention,
-- and optimizing operational processes across the platform.
--
-- This analysis provides a data-driven foundation for strategic decisions
-- aimed at maximizing revenue, improving customer experience, and ensuring
-- long-term scalability.
-- ==============================================================================================================================================*/