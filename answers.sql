-- Question 1: Achieving 1NF (First Normal Form)
-- The original ProductDetail table violates 1NF due to multi-valued fields in the "Products" column.
-- To bring it into 1NF, we need to split the product list so that each product has its own row.

-- Original data (for reference):
-- OrderID | CustomerName | Products
-- 101     | John Doe      | Laptop, Mouse
-- 102     | Jane Smith    | Tablet, Keyboard, Mouse
-- 103     | Emily Clark   | Phone

-- Step 1: Create the normalized table structure
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Step 2: Insert normalized data (manually split multi-valued fields)
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Now the table is in First Normal Form (1NF): no repeating groups or multi-valued attributes.



-- Question 2: Achieving 2NF (Second Normal Form)
-- The OrderDetails table is in 1NF, but has partial dependency: CustomerName depends only on OrderID.

-- To normalize to 2NF:
-- Step 1: Create a separate Orders table for OrderID → CustomerName relationship.
-- Step 2: Create a new OrderLine table with full dependency on the composite key (OrderID, Product).

-- Step 1: Create the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Insert distinct orders
INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Step 2: Create the OrderLine table
CREATE TABLE OrderLine (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert product order lines
INSERT INTO OrderLine (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- Now the database is in Second Normal Form (2NF): no partial dependencies remain.
