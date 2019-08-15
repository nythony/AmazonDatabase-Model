/* Name: Alina Chaiyasarikul
 * Date: December 15th, 2018
 * 
 * A model of Amazon's database that manages sellers, seller inventory (warehouse), products, customers, and customer purchases.
 * To sell on Amazon, the seller ships the products to one of Amazon’s warehouses. Product listings are defined by the product and the price.
 * Consumers can purchase products and select shipping speed.
 */

--Drop Commands (table referencing, then table referenced)
    --Buyer
DROP TABLE ProductPurchase1;
DROP TABLE Orders1;
DROP TABLE ShippingSpeed1;
DROP TABLE Buyer1;
    --"Amazon"
DROP TABLE SellShipProduct1;
DROP TABLE SellShip1;
DROP TABLE AmazonInventory1;
DROP TABLE Warehouse1;
DROP TABLE Seller1;
    --Product
DROP TABLE Listing1;
DROP TABLE Product1;
DROP TABLE ProductBrand1;
DROP TABLE ProductType1;
DROP TABLE ProductCategory1;
DROP TABLE ProductCondition1;
    --Address
DROP TABLE Address1;
DROP TABLE ZipCode1;
DROP TABLE City1;
DROP TABLE State1;

--Create table
    --Address
CREATE TABLE State1(
State1_ID NUMERIC PRIMARY KEY,
St1_Name VARCHAR(64) NOT NULL UNIQUE,
St1_Abbrev VARCHAR(10) NOT NULL UNIQUE);
ALTER TABLE State1 ADD CONSTRAINT St_Abbrev_length CHECK(LENGTH(St1_Abbrev)=2);

CREATE TABLE City1(
City1_ID NUMERIC PRIMARY KEY,
C1_Name VARCHAR(64) NOT NULL);

CREATE TABLE ZipCode1(
ZipCode1_ID NUMERIC PRIMARY KEY,
Zipcode1 VARCHAR(10) UNIQUE,
City1_ID NUMERIC NOT NULL REFERENCES City1(City1_ID),
State1_ID NUMERIC NOT NULL REFERENCES State1(State1_ID));
ALTER TABLE ZipCode1 ADD CONSTRAINT zipcode1_length CHECK(LENGTH(Zipcode1)=5);

CREATE TABLE Address1(
Address1_ID NUMERIC PRIMARY KEY,
Zipcode1_ID NUMERIC REFERENCES ZipCode1(Zipcode1_ID),
A1_StreetName VARCHAR(64) NOT NULL,
A1_UnitNumber VARCHAR(10));

    --Product
CREATE TABLE ProductCondition1(
Condition1_ID NUMERIC PRIMARY KEY,
Con1_Type VARCHAR(64) NOT NULL);

CREATE TABLE ProductCategory1(
Category1_ID NUMERIC PRIMARY KEY,
Cat1_Name VARCHAR(64) NOT NULL);

CREATE TABLE ProductType1(
ProductType1_ID NUMERIC PRIMARY KEY,
Category1_ID NUMERIC NOT NULL REFERENCES ProductCategory1(Category1_ID),
T1_Name VARCHAR(64) NOT NULL);

CREATE TABLE ProductBrand1(
Brand1_ID NUMERIC PRIMARY KEY,
Br1_Name VARCHAR(64) NOT NULL);
    
CREATE TABLE Product1(
Product1_ID NUMERIC PRIMARY KEY,
Condition1_ID NUMERIC NOT NULL REFERENCES ProductCondition1(Condition1_ID),
ProductType1_ID NUMERIC NOT NULL REFERENCES ProductType1(ProductType1_ID),
Brand1_ID NUMERIC NOT NULL REFERENCES ProductBrand1(Brand1_ID),
P1_Name VARCHAR(64) NOT NULL,
P1_Description VARCHAR(64) NOT NULL);

CREATE TABLE Listing1(
Listing1_ID NUMERIC PRIMARY KEY,
Product1_ID NUMERIC REFERENCES Product1(Product1_ID),
L1_Quantity NUMERIC,
P1_Price DECIMAL(12, 2) NOT NULL);

    --"Amazon"
CREATE TABLE Seller1(
Seller1_ID NUMERIC PRIMARY KEY,
Address1_ID NUMERIC REFERENCES Address1(Address1_ID),
S1_Username VARCHAR(64) NOT NULL UNIQUE,
S1_FirstName VARCHAR(64) NOT NULL,
S1_LastName VARCHAR(64) NOT NULL,
S1_Email VARCHAR(64) NOT NULL UNIQUE);

CREATE TABLE Warehouse1(
Warehouse1_ID NUMERIC PRIMARY KEY,
Address1_ID NUMERIC REFERENCES Address1(Address1_ID));

CREATE TABLE AmazonInventory1(
Inventory1_ID NUMERIC PRIMARY KEY,
Seller1_ID NUMERIC NOT NULL REFERENCES Seller1(Seller1_ID),
Listing1_ID NUMERIC NOT NULL REFERENCES Listing1(Listing1_ID),
Warehouse1_ID NUMERIC NOT NULL REFERENCES Warehouse1(Warehouse1_ID),
I1_Quantity NUMERIC NOT NULL);

CREATE TABLE SellShip1(
SellShip1_ID NUMERIC PRIMARY KEY,
Seller1_ID NUMERIC NOT NULL REFERENCES Seller1(Seller1_ID),
Warehouse1_ID NUMERIC NOT NULL REFERENCES Warehouse1(Warehouse1_ID));

CREATE TABLE SellShipProduct1(
SellShip1_ID NUMERIC REFERENCES SellShip1(SellShip1_ID),
Product1_ID NUMERIC REFERENCES Product1(Product1_ID),
Sh1_Quantity NUMERIC NOT NULL,
CONSTRAINT SellShipProduct1_pk PRIMARY KEY (SellShip1_ID,Product1_ID));

    --Buyer  
CREATE TABLE Buyer1(
Buyer1_ID NUMERIC PRIMARY KEY,
Address1_ID NUMERIC REFERENCES Address1(Address1_ID),
B1_Username VARCHAR(64) NOT NULL UNIQUE,
B1_FirstName VARCHAR(64) NOT NULL,
B1_LastName VARCHAR(64) NOT NULL,
B1_Email VARCHAR(64) NOT NULL UNIQUE);

CREATE TABLE ShippingSpeed1(
Speed1_ID NUMERIC PRIMARY KEY,
Sh1_Type VARCHAR(64) NOT NULL);

CREATE TABLE Orders1(
Orders1_ID NUMERIC PRIMARY KEY,
Buyer1_ID NUMERIC REFERENCES Buyer1(Buyer1_ID),
Speed1_ID NUMERIC REFERENCES ShippingSpeed1(Speed1_ID),
O1_Total DECIMAL(12, 2),
O1_Date DATE);

CREATE TABLE ProductPurchase1(
Purchase1_ID NUMERIC PRIMARY KEY,
Orders1_ID NUMERIC REFERENCES Orders1(Orders1_ID),
Inventory1_ID NUMERIC REFERENCES AmazonInventory1(Inventory1_ID),
P1_Price DECIMAL(12, 2) NOT NULL,
Pch1_Quantity NUMERIC NOT NULL);

--Insert Commands
    --Address
INSERT INTO State1(State1_ID, St1_Name, St1_Abbrev)
VALUES(1, 'Massachusetts', 'MA');
INSERT INTO State1(State1_ID, St1_Name, St1_Abbrev)
VALUES(2, 'Florida', 'FL');
INSERT INTO State1(State1_ID, St1_Name, St1_Abbrev)
VALUES(3, 'Georgia', 'GA');
INSERT INTO State1(State1_ID, St1_Name, St1_Abbrev)
VALUES(4, 'Vermont', 'VT');

INSERT INTO City1(City1_ID, C1_Name)
VALUES(1, 'Boston');
INSERT INTO City1(City1_ID, C1_Name)
VALUES(2, 'Northampton');
INSERT INTO City1(City1_ID, C1_Name)
VALUES(3, 'Somerville');
INSERT INTO City1(City1_ID, C1_Name)
VALUES(4, 'Lakeland');
INSERT INTO City1(City1_ID, C1_Name)
VALUES(5, 'Orlando');
INSERT INTO City1(City1_ID, C1_Name)
VALUES(6, 'Atlanta');
INSERT INTO City1(City1_ID, C1_Name)
VALUES(7, 'Stowe');

INSERT INTO ZipCode1(Zipcode1_ID, ZipCode1, City1_ID, State1_ID)
VALUES(1, '02215', 1, 1);
INSERT INTO ZipCode1(Zipcode1_ID, ZipCode1, City1_ID, State1_ID)
VALUES(2, '02134', 1, 1);
INSERT INTO ZipCode1(Zipcode1_ID, ZipCode1, City1_ID, State1_ID)
VALUES(3, '02118', 1, 1);
INSERT INTO ZipCode1(Zipcode1_ID, ZipCode1, City1_ID, State1_ID)
VALUES(4, '01060', 2, 1);
INSERT INTO ZipCode1(Zipcode1_ID, ZipCode1, City1_ID, State1_ID)
VALUES(5, '02145', 3, 1);
INSERT INTO ZipCode1(Zipcode1_ID, ZipCode1, City1_ID, State1_ID)
VALUES(6, '33813', 4, 2);
INSERT INTO ZipCode1(Zipcode1_ID, ZipCode1, City1_ID, State1_ID)
VALUES(7, '33805', 4, 2);
INSERT INTO ZipCode1(Zipcode1_ID, ZipCode1, City1_ID, State1_ID)
VALUES(8, '32830', 5, 2);
INSERT INTO ZipCode1(Zipcode1_ID, ZipCode1, City1_ID, State1_ID)
VALUES(9, '30318', 6, 3);
INSERT INTO ZipCode1(Zipcode1_ID, ZipCode1, City1_ID, State1_ID)
VALUES(10, '05672', 7, 4);

INSERT INTO Address1(Address1_ID, Zipcode1_ID, A1_StreetName, A1_UnitNumber)
VALUES(1001, 1, '700 Commonwealth Avenue', '10A');
INSERT INTO Address1(Address1_ID, Zipcode1_ID, A1_StreetName, A1_UnitNumber)
VALUES(1002, 2, '1315 Commonwealth Avenue', '403');
INSERT INTO Address1(Address1_ID, Zipcode1_ID, A1_StreetName, A1_UnitNumber)
VALUES(1003, 2, '1377 Commonwealth Avenue', '9');
INSERT INTO Address1(Address1_ID, Zipcode1_ID, A1_StreetName, A1_UnitNumber)
VALUES(1004, 3, '715 Albany Street', '311E');
INSERT INTO Address1(Address1_ID, Zipcode1_ID, A1_StreetName, A1_UnitNumber)
VALUES(1005, 3, '715 Albany Street', '416E');
INSERT INTO Address1(Address1_ID, Zipcode1_ID, A1_StreetName, A1_UnitNumber)
VALUES(1006, 3, '670 Albany Street', '10A');
INSERT INTO Address1(Address1_ID, Zipcode1_ID, A1_StreetName)
VALUES(1007, 4, '201 Grove Street');
INSERT INTO Address1(Address1_ID, Zipcode1_ID, A1_StreetName)
VALUES(1008, 5, '320 Lowell Street');
INSERT INTO Address1(Address1_ID, Zipcode1_ID, A1_StreetName, A1_UnitNumber)
VALUES(1009, 5, '66 Grant Street', 'A');
INSERT INTO Address1(Address1_ID, Zipcode1_ID, A1_StreetName)
VALUES(1010, 6, '4644 Kings Point Court');
INSERT INTO Address1(Address1_ID, Zipcode1_ID, A1_StreetName)
VALUES(1011, 7, '1300 North Lincoln Avenue');
INSERT INTO Address1(Address1_ID, Zipcode1_ID, A1_StreetName, A1_UnitNumber)
VALUES(1012, 8, 'Walt Disney Resort', 'Lot A');
INSERT INTO Address1(Address1_ID, Zipcode1_ID, A1_StreetName, A1_UnitNumber)
VALUES(1013, 8, 'Walt Disney Resort', 'Lot B');
INSERT INTO Address1(Address1_ID, Zipcode1_ID, A1_StreetName, A1_UnitNumber)
VALUES(1014, 9, '1630 Leona Street Northwest', '201');
INSERT INTO Address1(Address1_ID, Zipcode1_ID, A1_StreetName)
VALUES(1015, 10, '1746 Mountain Road');

    --Product
INSERT INTO ProductCondition1(Condition1_ID, Con1_Type)
VALUES(2001, 'New');
INSERT INTO ProductCondition1(Condition1_ID, Con1_Type)
VALUES(2002, 'Like New');
INSERT INTO ProductCondition1(Condition1_ID, Con1_Type)
VALUES(2003, 'Used');
INSERT INTO ProductCondition1(Condition1_ID, Con1_Type)
VALUES(2004, 'Rental');

INSERT INTO ProductCategory1(Category1_ID, Cat1_Name)
VALUES(3001, 'Appliances');
INSERT INTO ProductCategory1(Category1_ID, Cat1_Name)
VALUES(3002, 'Books');
INSERT INTO ProductCategory1(Category1_ID, Cat1_Name)
VALUES(3003, 'Clothing');
INSERT INTO ProductCategory1(Category1_ID, Cat1_Name)
VALUES(3004, 'Computers');
INSERT INTO ProductCategory1(Category1_ID, Cat1_Name)
VALUES(3005, 'Electronics');
INSERT INTO ProductCategory1(Category1_ID, Cat1_Name)
VALUES(3006, 'Jewelry');
INSERT INTO ProductCategory1(Category1_ID, Cat1_Name)
VALUES(3007, 'Toys');

INSERT INTO ProductType1(ProductType1_ID, Category1_ID, T1_Name)
VALUES(4001, 3001, 'Vacuum Cleaner');
INSERT INTO ProductType1(ProductType1_ID, Category1_ID, T1_Name)
VALUES(4002, 3002, 'Audiobooks');
INSERT INTO ProductType1(ProductType1_ID, Category1_ID, T1_Name)
VALUES(4003, 3002, 'E-Books');
INSERT INTO ProductType1(ProductType1_ID, Category1_ID, T1_Name)
VALUES(4004, 3002, 'Physical Books');
INSERT INTO ProductType1(ProductType1_ID, Category1_ID, T1_Name)
VALUES(4005, 3004, 'Computer Mouse');
INSERT INTO ProductType1(ProductType1_ID, Category1_ID, T1_Name)
VALUES(4006, 3005, 'External Hard Drive');
INSERT INTO ProductType1(ProductType1_ID, Category1_ID, T1_Name)
VALUES(4007, 3005, 'USB');
INSERT INTO ProductType1(ProductType1_ID, Category1_ID, T1_Name)
VALUES(4008, 3004, 'Laptop');
INSERT INTO ProductType1(ProductType1_ID, Category1_ID, T1_Name)
VALUES(4009, 3006, 'Bracelet');

INSERT INTO ProductBrand1(Brand1_ID, Br1_Name)
VALUES(5001, 'Logitech');
INSERT INTO ProductBrand1(Brand1_ID, Br1_Name)
VALUES(5002, 'WD');
INSERT INTO ProductBrand1(Brand1_ID, Br1_Name)
VALUES(5003, 'Seagate');
INSERT INTO ProductBrand1(Brand1_ID, Br1_Name)
VALUES(5004, 'Kingston');
INSERT INTO ProductBrand1(Brand1_ID, Br1_Name)
VALUES(5005, 'Roomie');
INSERT INTO ProductBrand1(Brand1_ID, Br1_Name)
VALUES(5006, 'Pearson');
INSERT INTO ProductBrand1(Brand1_ID, Br1_Name)
VALUES(5007, 'Macintosh');

INSERT INTO Product1(Product1_ID, Condition1_ID, ProductType1_ID, Brand1_ID, P1_Name, P1_Description)
VALUES(1,  2001, 4005, 5001, 'Logitech Mouse G3', 'Wireless, Red');
INSERT INTO Product1(Product1_ID, Condition1_ID, ProductType1_ID, Brand1_ID, P1_Name, P1_Description)
VALUES(2,  2001, 4008, 5007, 'Macbook Pro XX', '13" Retinal Display');
INSERT INTO Product1(Product1_ID, Condition1_ID, ProductType1_ID, Brand1_ID, P1_Name, P1_Description)
VALUES(3,  2001, 4006, 5002, 'WD Elements Portable Drive', '1 TB');
INSERT INTO Product1(Product1_ID, Condition1_ID, ProductType1_ID, Brand1_ID, P1_Name, P1_Description)
VALUES(4,  2001, 4006, 5002, 'WD Silk Portable Drive', '2 TB');
INSERT INTO Product1(Product1_ID, Condition1_ID, ProductType1_ID, Brand1_ID, P1_Name, P1_Description)
VALUES(5,  2001, 4006, 5003, 'Seagate Backup Plus Slim', '1 TB');
INSERT INTO Product1(Product1_ID, Condition1_ID, ProductType1_ID, Brand1_ID, P1_Name, P1_Description)
VALUES(6,  2001, 4007, 5004, 'Kingston Bolt', '16GB');
INSERT INTO Product1(Product1_ID, Condition1_ID, ProductType1_ID, Brand1_ID, P1_Name, P1_Description)
VALUES(7,  2001, 4007, 5004, 'Kingston Bolt', '8GB');
INSERT INTO Product1(Product1_ID, Condition1_ID, ProductType1_ID, Brand1_ID, P1_Name, P1_Description)
VALUES(8,  2001, 4001, 5005, 'Roomie Tec', 'Cordless, 2-in-1 Handheld');
INSERT INTO Product1(Product1_ID, Condition1_ID, ProductType1_ID, Brand1_ID, P1_Name, P1_Description)
VALUES(9,  2003, 4004, 5006, 'The Cell', 'By Thomas Smith. Eigth Edition');
INSERT INTO Product1(Product1_ID, Condition1_ID, ProductType1_ID, Brand1_ID, P1_Name, P1_Description)
VALUES(10,  2002, 4004, 5006, 'Matilda', 'By Road Dahl. Soft Cover');

INSERT INTO Listing1(Listing1_ID, Product1_ID, L1_Quantity, P1_Price)
VALUES (20001, 1, 10, 14.99);
INSERT INTO Listing1(Listing1_ID, Product1_ID, L1_Quantity, P1_Price)
VALUES (20002, 1, 10, 15.00);
INSERT INTO Listing1(Listing1_ID, Product1_ID, L1_Quantity, P1_Price)
VALUES (20003, 3, 10, 80.00);
INSERT INTO Listing1(Listing1_ID, Product1_ID, L1_Quantity, P1_Price)
VALUES (20004, 2, 15, 600.00);
INSERT INTO Listing1(Listing1_ID, Product1_ID, L1_Quantity, P1_Price)
VALUES (20005, 4, 10, 100.00);
INSERT INTO Listing1(Listing1_ID, Product1_ID, L1_Quantity, P1_Price)
VALUES (20006, 6, 10, 29.99);
INSERT INTO Listing1(Listing1_ID, Product1_ID, L1_Quantity, P1_Price)
VALUES (20007, 6, 10, 30.00);
INSERT INTO Listing1(Listing1_ID, Product1_ID, L1_Quantity, P1_Price)
VALUES (20008, 7, 10, 15.00);
INSERT INTO Listing1(Listing1_ID, Product1_ID, L1_Quantity, P1_Price)
VALUES (20009, 9, 10, 70.00);
INSERT INTO Listing1(Listing1_ID, Product1_ID, L1_Quantity, P1_Price)
VALUES (20010, 10, 10, 10.00);
INSERT INTO Listing1(Listing1_ID, Product1_ID, L1_Quantity, P1_Price)
VALUES (20011, 8, 15, 100.00);

     --"Amazon"
INSERT INTO Seller1(Seller1_ID, Address1_ID, S1_Username, S1_FirstName, S1_LastName, S1_Email)
VALUES (1, 1001, 'MrNiceGuy', 'John', 'Smith', 'niceguy@gmail.com');
INSERT INTO Seller1(Seller1_ID, Address1_ID, S1_Username, S1_FirstName, S1_LastName, S1_Email)
VALUES (2, 1011, 'MsNiceGal', 'Jane', 'Doe', 'nicegal@gmail.com');
INSERT INTO Seller1(Seller1_ID, Address1_ID, S1_Username, S1_FirstName, S1_LastName, S1_Email)
VALUES (3, 1009, 'MrNiceBoy', 'Bob', 'Brown', 'niceboy@gmail.com');
INSERT INTO Seller1(Seller1_ID, Address1_ID, S1_Username, S1_FirstName, S1_LastName, S1_Email)
VALUES (4, 1014, 'MsNiceGirl', 'Emily', 'Green', 'nicegirl@gmail.com');

INSERT INTO Warehouse1(Warehouse1_ID, Address1_ID)
VALUES (6001, 1006);
INSERT INTO Warehouse1(Warehouse1_ID, Address1_ID)
VALUES (6002, 1009);
INSERT INTO Warehouse1(Warehouse1_ID, Address1_ID)
VALUES (6003, 1012);
INSERT INTO Warehouse1(Warehouse1_ID, Address1_ID)
VALUES (6004, 1013);
INSERT INTO Warehouse1(Warehouse1_ID, Address1_ID)
VALUES (6005, 1015);

INSERT INTO AmazonInventory1(Inventory1_ID, Seller1_ID, Listing1_ID, Warehouse1_ID, I1_Quantity)
VALUES (1, 1, 20001, 6001, 4);
INSERT INTO AmazonInventory1(Inventory1_ID, Seller1_ID, Listing1_ID, Warehouse1_ID, I1_Quantity)
VALUES (2, 1, 20003, 6002, 4);
INSERT INTO AmazonInventory1(Inventory1_ID, Seller1_ID, Listing1_ID, Warehouse1_ID, I1_Quantity)
VALUES (3, 2, 20001, 6003, 6);
INSERT INTO AmazonInventory1(Inventory1_ID, Seller1_ID, Listing1_ID, Warehouse1_ID, I1_Quantity)
VALUES (4, 2, 20003, 6003, 6);
INSERT INTO AmazonInventory1(Inventory1_ID, Seller1_ID, Listing1_ID, Warehouse1_ID, I1_Quantity)
VALUES (5, 3, 20002, 6004, 10);
INSERT INTO AmazonInventory1(Inventory1_ID, Seller1_ID, Listing1_ID, Warehouse1_ID, I1_Quantity)
VALUES (6, 4, 20004, 6003, 15);
INSERT INTO AmazonInventory1(Inventory1_ID, Seller1_ID, Listing1_ID, Warehouse1_ID, I1_Quantity)
VALUES (7, 4, 20005, 6003, 10);
INSERT INTO AmazonInventory1(Inventory1_ID, Seller1_ID, Listing1_ID, Warehouse1_ID, I1_Quantity)
VALUES (8, 1, 20006, 6002, 10);
INSERT INTO AmazonInventory1(Inventory1_ID, Seller1_ID, Listing1_ID, Warehouse1_ID, I1_Quantity)
VALUES (9, 4, 20007, 6003, 7);
INSERT INTO AmazonInventory1(Inventory1_ID, Seller1_ID, Listing1_ID, Warehouse1_ID, I1_Quantity)
VALUES (10, 3, 20007, 6004, 3);
INSERT INTO AmazonInventory1(Inventory1_ID, Seller1_ID, Listing1_ID, Warehouse1_ID, I1_Quantity)
VALUES (11, 1, 20008, 6002, 10);
INSERT INTO AmazonInventory1(Inventory1_ID, Seller1_ID, Listing1_ID, Warehouse1_ID, I1_Quantity)
VALUES (12, 2, 20009, 6002, 10);
INSERT INTO AmazonInventory1(Inventory1_ID, Seller1_ID, Listing1_ID, Warehouse1_ID, I1_Quantity)
VALUES (13, 3, 20010, 6004, 10);
INSERT INTO AmazonInventory1(Inventory1_ID, Seller1_ID, Listing1_ID, Warehouse1_ID, I1_Quantity)
VALUES (14, 1, 20011, 6002, 15);

--Did not add data for selling shipments

    --Buyer  
INSERT INTO Buyer1(Buyer1_ID, Address1_ID, B1_Username, B1_FirstName, B1_LastName, B1_Email)
VALUES(1, 1002, 'MrBadGuy', 'John', 'Smith', 'badguy@gmail.com');
INSERT INTO Buyer1(Buyer1_ID, Address1_ID, B1_Username, B1_FirstName, B1_LastName, B1_Email)
VALUES(2, 1003, 'MsBadGal', 'Jackie', 'Whit', 'badgal@gmail.com');
INSERT INTO Buyer1(Buyer1_ID, Address1_ID, B1_Username, B1_FirstName, B1_LastName, B1_Email)
VALUES(3, 1004, 'MrBadBoy', 'Nick', 'Bluey', 'badboy@gmail.com');
INSERT INTO Buyer1(Buyer1_ID, Address1_ID, B1_Username, B1_FirstName, B1_LastName, B1_Email)
VALUES(4, 1005, 'MsBadGirl', 'Lucy', 'Greene', 'badgirl@gmail.com');

INSERT INTO ShippingSpeed1(Speed1_ID, Sh1_Type)
VALUES(8001, 'Super Saving Shipping');
INSERT INTO ShippingSpeed1(Speed1_ID, Sh1_Type)
VALUES(8002, 'Standard Shipping');
INSERT INTO ShippingSpeed1(Speed1_ID, Sh1_Type)
VALUES(8003, 'Two-Day Shipping');
INSERT INTO ShippingSpeed1(Speed1_ID, Sh1_Type)
VALUES(8004, 'One-Day Shipping');

INSERT INTO Orders1(Orders1_ID, Buyer1_ID, Speed1_ID, O1_Total, O1_Date)
VALUES (1000001, 3, 8002, 630.00, TO_DATE('30-NOV-2018'));
INSERT INTO Orders1(Orders1_ID, Buyer1_ID, Speed1_ID, O1_Total, O1_Date)
VALUES (1000002, 2, 8001, 15.00, TO_DATE('17-AUG-2018'));
INSERT INTO Orders1(Orders1_ID, Buyer1_ID, Speed1_ID, O1_Total, O1_Date)
VALUES (1000003, 3, 8002, 45.00, TO_DATE('17-SEP-2018'));
INSERT INTO Orders1(Orders1_ID, Buyer1_ID, Speed1_ID, O1_Total, O1_Date)
VALUES (1000004, 4, 8003, 30.00, TO_DATE('19-NOV-2018'));
INSERT INTO Orders1(Orders1_ID, Buyer1_ID, Speed1_ID, O1_Total, O1_Date)
VALUES (1000005, 3, 8001, 15.00, TO_DATE('19-NOV-2018'));
INSERT INTO Orders1(Orders1_ID, Buyer1_ID, Speed1_ID, O1_Total, O1_Date)
VALUES (1000006, 1, 8004, 59.98, TO_DATE('1-OCT-2018'));
INSERT INTO Orders1(Orders1_ID, Buyer1_ID, Speed1_ID, O1_Total, O1_Date)
VALUES (1000007, 2, 8003, 29.99, TO_DATE('2-OCT-2018'));
INSERT INTO Orders1(Orders1_ID, Buyer1_ID, Speed1_ID, O1_Total, O1_Date)
VALUES (1000008, 1, 8003, 44.99, TO_DATE('3-OCT-2018'));
INSERT INTO Orders1(Orders1_ID, Buyer1_ID, Speed1_ID, O1_Total, O1_Date)
VALUES (1000009, 4, 8002, 29.99, TO_DATE('17-OCT-2018'));
INSERT INTO Orders1(Orders1_ID, Buyer1_ID, Speed1_ID, O1_Total, O1_Date)
VALUES (1000010, 2, 8001, 60.00, TO_DATE('30-OCT-2018'));
INSERT INTO Orders1(Orders1_ID, Buyer1_ID, Speed1_ID, O1_Total, O1_Date)
VALUES (1000011, 4, 8001, 80.00, TO_DATE('3-DEC-2018'));
INSERT INTO Orders1(Orders1_ID, Buyer1_ID, Speed1_ID, O1_Total, O1_Date)
VALUES (1000012, 2, 8001, 10.00, TO_DATE('24-AUG-2018'));
INSERT INTO Orders1(Orders1_ID, Buyer1_ID, Speed1_ID, O1_Total, O1_Date)
VALUES (1000013, 4, 8004, 100.00, TO_DATE('24-OCT-2018'));

INSERT INTO ProductPurchase1(Purchase1_ID, Orders1_ID, Inventory1_ID, P1_Price, Pch1_Quantity)
VALUES (500001, 1000001, 6, 600.00, 1);
INSERT INTO ProductPurchase1(Purchase1_ID, Orders1_ID, Inventory1_ID, P1_Price, Pch1_Quantity)
VALUES (500002, 1000001, 9, 30.00, 1);
INSERT INTO ProductPurchase1(Purchase1_ID, Orders1_ID, Inventory1_ID, P1_Price, Pch1_Quantity)
VALUES (500003, 1000002, 11, 15.00, 1);
INSERT INTO ProductPurchase1(Purchase1_ID, Orders1_ID, Inventory1_ID, P1_Price, Pch1_Quantity)
VALUES (500004, 1000003, 9, 30.00, 1);
INSERT INTO ProductPurchase1(Purchase1_ID, Orders1_ID, Inventory1_ID, P1_Price, Pch1_Quantity)
VALUES (500005, 1000004, 11, 15.00, 2);
INSERT INTO ProductPurchase1(Purchase1_ID, Orders1_ID, Inventory1_ID, P1_Price, Pch1_Quantity)
VALUES (500006, 1000005, 11, 15.00, 1);
INSERT INTO ProductPurchase1(Purchase1_ID, Orders1_ID, Inventory1_ID, P1_Price, Pch1_Quantity)
VALUES (500007, 1000006, 7, 29.99, 2);
INSERT INTO ProductPurchase1(Purchase1_ID, Orders1_ID, Inventory1_ID, P1_Price, Pch1_Quantity)
VALUES (500008, 1000007, 7, 29.99, 1);
INSERT INTO ProductPurchase1(Purchase1_ID, Orders1_ID, Inventory1_ID, P1_Price, Pch1_Quantity)
VALUES (500009, 1000008, 7, 29.99, 1);
INSERT INTO ProductPurchase1(Purchase1_ID, Orders1_ID, Inventory1_ID, P1_Price, Pch1_Quantity)
VALUES (500010, 1000008, 5, 15.00, 1);
INSERT INTO ProductPurchase1(Purchase1_ID, Orders1_ID, Inventory1_ID, P1_Price, Pch1_Quantity)
VALUES (500011, 1000003, 1, 15.00, 1);
INSERT INTO ProductPurchase1(Purchase1_ID, Orders1_ID, Inventory1_ID, P1_Price, Pch1_Quantity)
VALUES (500012, 1000009, 8, 29.99, 1);
INSERT INTO ProductPurchase1(Purchase1_ID, Orders1_ID, Inventory1_ID, P1_Price, Pch1_Quantity)
VALUES (500013, 1000010, 9, 30.00, 2);
INSERT INTO ProductPurchase1(Purchase1_ID, Orders1_ID, Inventory1_ID, P1_Price, Pch1_Quantity)
VALUES (500014, 1000011, 12, 70.00, 1);
INSERT INTO ProductPurchase1(Purchase1_ID, Orders1_ID, Inventory1_ID, P1_Price, Pch1_Quantity)
VALUES (500015, 1000011, 13, 10.00, 1);
INSERT INTO ProductPurchase1(Purchase1_ID, Orders1_ID, Inventory1_ID, P1_Price, Pch1_Quantity)
VALUES (500016, 1000012, 13, 10.00, 1);
INSERT INTO ProductPurchase1(Purchase1_ID, Orders1_ID, Inventory1_ID, P1_Price, Pch1_Quantity)
VALUES (500017, 1000013, 14, 100.00, 1);


commit;


--Returns information about products including product name, product category, it’s price, description and availability of existing products 
--in the “Computers” or “Electronics” categories that cost $30 or less.
--Also shows different listings for the same product if it is being offered at different prices
SELECT P.P1_Name AS Product, PT.T1_Name||', '||PC.Cat1_name AS Category, 
    to_char(L.P1_Price, '$999,999.00') AS Price, P.P1_Description AS Description
FROM Product1 P
JOIN ProductType1 PT ON PT.ProductType1_ID = P.ProductType1_ID
JOIN ProductCategory1 PC ON PC.Category1_ID = PT.Category1_ID
JOIN Listing1 L ON L.Product1_ID = P.Product1_ID
WHERE L.P1_Price <= 30 AND (PC.Cat1_name = 'Computers' OR PC.Cat1_name = 'Electronics')
ORDER BY PC.Cat1_Name, PT.T1_name, Product, Description;

--A listing of all of a seller's products that have an inventory of 11 or less sold in the past 2 months. 
--Search seller by seller username
SELECT PP.Purchase1_ID, I.Inventory1_ID, S.S1_Username AS Seller, P.P1_Name||', '||P.P1_Description AS Product, 
    I.I1_Quantity, O.O1_Date AS RecentSold
FROM AmazonInventory1 I
JOIN Seller1 S ON S.Seller1_ID = I.Seller1_ID AND S.S1_Username = 'MsNiceGirl'
JOIN Listing1 L ON L.Listing1_ID = I.Listing1_ID
JOIN Product1 P ON P.Product1_ID = L.Product1_ID
JOIN ProductPurchase1 PP ON PP.Inventory1_ID = I.Inventory1_ID
JOIN Orders1 O ON O.Orders1_ID = PP.Orders1_ID
WHERE PP.Purchase1_ID IN ( 
    --Most recent record of product being sold by a particular seller
    SELECT PP.Purchase1_ID
    FROM AmazonInventory1 I2
    JOIN ProductPurchase1 PP ON PP.Inventory1_ID = I2.Inventory1_ID
    JOIN Orders1 O ON O.Orders1_ID = PP.Orders1_ID
    WHERE I2.Inventory1_ID = I.Inventory1_ID
    ORDER BY I2.Inventory1_ID ASC, O.O1_DATE DESC 
    FETCH FIRST ROW ONLY)
AND O.O1_Date > (SELECT ADD_MONTHS(sysdate,-2) FROM DUAL)
AND I1_Quantity <= 11;


--The names and addresses of all customers who bought any product that was purchased by at least three different people
--Products bought more than 3 times can be sold by different sellers at different prices

    --Products (not listings) and Buyer count   
    SELECT P.P1_Name, P.P1_description, P.Product1_ID, count(O.Buyer1_ID) AS NumberBuyers
    FROM ProductPurchase1 PP
    JOIN Orders1 O ON O.Orders1_ID = PP.Orders1_ID
    JOIN AmazonInventory1 I ON I.Inventory1_ID = PP.Inventory1_ID
    JOIN Listing1 L ON L.Listing1_ID = I.Listing1_ID
    JOIN Product1 P ON P.Product1_ID = L.Product1_ID
    GROUP BY P.P1_Name, P.P1_description, P.Product1_ID
    ORDER BY NumberBuyers, Product1_ID;

    --Buyers of each product
    SELECT P.Product1_ID, B.Buyer1_ID
    FROM Product1 P
    JOIN Listing1 L ON L.Product1_ID = P.Product1_ID
    JOIN AmazonInventory1 I ON I.Listing1_ID = L.Listing1_ID
    JOIN ProductPurchase1 PP ON PP.Inventory1_ID = I.Inventory1_ID
    JOIN Orders1 O ON O.Orders1_ID = PP.Orders1_ID
    JOIN Buyer1 B ON O.Buyer1_ID = B.Buyer1_ID
    ORDER BY Product1_ID;
    
    --Products that have more than 3 buyers and the list of buyers
    SELECT P.Product1_ID, O.Buyer1_ID
    FROM Product1 P
    JOIN Listing1 L ON L.Product1_ID = P.Product1_ID
    JOIN AmazonInventory1 I ON I.Listing1_ID = L.Listing1_ID
    JOIN ProductPurchase1 PP ON PP.Inventory1_ID = I.Inventory1_ID
    JOIN Orders1 O ON O.Orders1_ID = PP.Orders1_ID
    JOIN Buyer1 B ON O.Buyer1_ID = B.Buyer1_ID 
    WHERE P.Product1_ID IN (
        SELECT P.Product1_ID
        FROM ProductPurchase1 PP
        JOIN Orders1 O ON O.Orders1_ID = PP.Orders1_ID
        JOIN AmazonInventory1 I ON I.Inventory1_ID = PP.Inventory1_ID
        JOIN Listing1 L ON L.Listing1_ID = I.Listing1_ID
        JOIN Product1 P ON P.Product1_ID = L.Product1_ID
        GROUP BY P.P1_Name, P.P1_description, P.Product1_ID
        HAVING count(O.Buyer1_ID) >=3)
    ORDER BY Product1_ID;

    --Products sold to 3+ times. Listing sellers for each products once
    SELECT DISTINCT P.Product1_ID, O.Buyer1_ID
    FROM Product1 P
    JOIN Listing1 L ON L.Product1_ID = P.Product1_ID
    JOIN AmazonInventory1 I ON I.Listing1_ID = L.Listing1_ID
    JOIN ProductPurchase1 PP ON PP.Inventory1_ID = I.Inventory1_ID
    JOIN Orders1 O ON O.Orders1_ID = PP.Orders1_ID
    JOIN Buyer1 B ON O.Buyer1_ID = B.Buyer1_ID 
    WHERE P.Product1_ID IN (
        SELECT P.Product1_ID
        FROM ProductPurchase1 PP
        JOIN Orders1 O ON O.Orders1_ID = PP.Orders1_ID
        JOIN AmazonInventory1 I ON I.Inventory1_ID = PP.Inventory1_ID
        JOIN Listing1 L ON L.Listing1_ID = I.Listing1_ID
        JOIN Product1 P ON P.Product1_ID = L.Product1_ID
        GROUP BY P.P1_Name, P.P1_description, P.Product1_ID
        HAVING count(O.Buyer1_ID) >=3)
    ORDER BY Product1_ID;
    
    --Count the number of buyers per product that have been sold more than 3 times
    SELECT Product1_ID, count(Buyer1_ID)
    FROM 
        (SELECT DISTINCT P.Product1_ID, O.Buyer1_ID
        FROM Product1 P
        JOIN Listing1 L ON L.Product1_ID = P.Product1_ID
        JOIN AmazonInventory1 I ON I.Listing1_ID = L.Listing1_ID
        JOIN ProductPurchase1 PP ON PP.Inventory1_ID = I.Inventory1_ID
        JOIN Orders1 O ON O.Orders1_ID = PP.Orders1_ID
        JOIN Buyer1 B ON O.Buyer1_ID = B.Buyer1_ID 
        WHERE P.Product1_ID IN (
            SELECT P.Product1_ID
            FROM ProductPurchase1 PP
            JOIN Orders1 O ON O.Orders1_ID = PP.Orders1_ID
            JOIN AmazonInventory1 I ON I.Inventory1_ID = PP.Inventory1_ID
            JOIN Listing1 L ON L.Listing1_ID = I.Listing1_ID
            JOIN Product1 P ON P.Product1_ID = L.Product1_ID
            GROUP BY P.P1_Name, P.P1_description, P.Product1_ID
            HAVING count(O.Buyer1_ID) >=3)
        ORDER BY Product1_ID)
    GROUP BY Product1_ID;
    
    --Products sold to 3 different sellers
    SELECT Product1_ID
    FROM 
        (SELECT DISTINCT P.Product1_ID, O.Buyer1_ID
        FROM Product1 P
        JOIN Listing1 L ON L.Product1_ID = P.Product1_ID
        JOIN AmazonInventory1 I ON I.Listing1_ID = L.Listing1_ID
        JOIN ProductPurchase1 PP ON PP.Inventory1_ID = I.Inventory1_ID
        JOIN Orders1 O ON O.Orders1_ID = PP.Orders1_ID
        JOIN Buyer1 B ON O.Buyer1_ID = B.Buyer1_ID 
        WHERE P.Product1_ID IN (
            SELECT P.Product1_ID
            FROM ProductPurchase1 PP
            JOIN Orders1 O ON O.Orders1_ID = PP.Orders1_ID
            JOIN AmazonInventory1 I ON I.Inventory1_ID = PP.Inventory1_ID
            JOIN Listing1 L ON L.Listing1_ID = I.Listing1_ID
            JOIN Product1 P ON P.Product1_ID = L.Product1_ID
            GROUP BY P.P1_Name, P.P1_description, P.Product1_ID
            HAVING count(O.Buyer1_ID) >=3)
        ORDER BY Product1_ID)
    GROUP BY Product1_ID
    HAVING COUNT(Buyer1_ID)>=3;
    
    --Products sold to 3 different sellers
        SELECT DISTINCT P.Product1_ID, O.Buyer1_ID
        FROM Product1 P
        JOIN Listing1 L ON L.Product1_ID = P.Product1_ID
        JOIN AmazonInventory1 I ON I.Listing1_ID = L.Listing1_ID
        JOIN ProductPurchase1 PP ON PP.Inventory1_ID = I.Inventory1_ID
        JOIN Orders1 O ON O.Orders1_ID = PP.Orders1_ID
        JOIN Buyer1 B ON O.Buyer1_ID = B.Buyer1_ID
        JOIN Address1 A ON A.Address1_ID = B.Address1_ID
        WHERE P.Product1_ID IN (
            SELECT P.Product1_ID
            FROM ProductPurchase1 PP
            JOIN Orders1 O ON O.Orders1_ID = PP.Orders1_ID
            JOIN AmazonInventory1 I ON I.Inventory1_ID = PP.Inventory1_ID
            JOIN Listing1 L ON L.Listing1_ID = I.Listing1_ID
            JOIN Product1 P ON P.Product1_ID = L.Product1_ID
            GROUP BY P.P1_Name, P.P1_description, P.Product1_ID
            HAVING count(O.Buyer1_ID) >=3)
        AND
        P.Product1_ID IN (
            SELECT Product1_ID
            FROM (
                SELECT DISTINCT P.Product1_ID, O.Buyer1_ID
                FROM Product1 P
                JOIN Listing1 L ON L.Product1_ID = P.Product1_ID
                JOIN AmazonInventory1 I ON I.Listing1_ID = L.Listing1_ID
                JOIN ProductPurchase1 PP ON PP.Inventory1_ID = I.Inventory1_ID
                JOIN Orders1 O ON O.Orders1_ID = PP.Orders1_ID
                JOIN Buyer1 B ON O.Buyer1_ID = B.Buyer1_ID
                JOIN Address1 A ON A.Address1_ID = B.Address1_ID
                WHERE P.Product1_ID IN (
                    SELECT P.Product1_ID
                    FROM ProductPurchase1 PP
                    JOIN Orders1 O ON O.Orders1_ID = PP.Orders1_ID
                    JOIN AmazonInventory1 I ON I.Inventory1_ID = PP.Inventory1_ID
                    JOIN Listing1 L ON L.Listing1_ID = I.Listing1_ID
                    JOIN Product1 P ON P.Product1_ID = L.Product1_ID
                    GROUP BY P.P1_Name, P.P1_description, P.Product1_ID
                    HAVING count(O.Buyer1_ID) >=3))
            GROUP BY Product1_ID
            HAVING COUNT(Buyer1_ID)>=3)
            ORDER BY Product1_ID;
            
--RESULT: Names and address of buyers who bought items sold to 2 other sellers
SELECT DISTINCT B.B1_FirstName AS FirstName, B.B1_LastName AS LastName, A.A1_StreetName||', '||A.A1_UnitNumber AS Address    
FROM Buyer1 B
JOIN Address1 A ON A.Address1_ID = B.Address1_ID
JOIN 
        (SELECT DISTINCT P.Product1_ID, O.Buyer1_ID
        FROM Product1 P
        JOIN Listing1 L ON L.Product1_ID = P.Product1_ID
        JOIN AmazonInventory1 I ON I.Listing1_ID = L.Listing1_ID
        JOIN ProductPurchase1 PP ON PP.Inventory1_ID = I.Inventory1_ID
        JOIN Orders1 O ON O.Orders1_ID = PP.Orders1_ID
        JOIN Buyer1 B ON O.Buyer1_ID = B.Buyer1_ID
        JOIN Address1 A ON A.Address1_ID = B.Address1_ID
        WHERE P.Product1_ID IN (
        SELECT P.Product1_ID
        FROM ProductPurchase1 PP
        JOIN Orders1 O ON O.Orders1_ID = PP.Orders1_ID
        JOIN AmazonInventory1 I ON I.Inventory1_ID = PP.Inventory1_ID
        JOIN Listing1 L ON L.Listing1_ID = I.Listing1_ID
        JOIN Product1 P ON P.Product1_ID = L.Product1_ID
        GROUP BY P.P1_Name, P.P1_description, P.Product1_ID
        HAVING count(O.Buyer1_ID) >=3)
    AND
    P.Product1_ID IN (
    SELECT Product1_ID
    FROM (
        SELECT DISTINCT P.Product1_ID, O.Buyer1_ID
        FROM Product1 P
        JOIN Listing1 L ON L.Product1_ID = P.Product1_ID
        JOIN AmazonInventory1 I ON I.Listing1_ID = L.Listing1_ID
        JOIN ProductPurchase1 PP ON PP.Inventory1_ID = I.Inventory1_ID
        JOIN Orders1 O ON O.Orders1_ID = PP.Orders1_ID
        JOIN Buyer1 B ON O.Buyer1_ID = B.Buyer1_ID
        JOIN Address1 A ON A.Address1_ID = B.Address1_ID
        WHERE P.Product1_ID IN (
            SELECT P.Product1_ID
            FROM ProductPurchase1 PP
            JOIN Orders1 O ON O.Orders1_ID = PP.Orders1_ID
            JOIN AmazonInventory1 I ON I.Inventory1_ID = PP.Inventory1_ID
            JOIN Listing1 L ON L.Listing1_ID = I.Listing1_ID
            JOIN Product1 P ON P.Product1_ID = L.Product1_ID
            GROUP BY P.P1_Name, P.P1_description, P.Product1_ID
            HAVING count(O.Buyer1_ID) >=3))
GROUP BY Product1_ID
HAVING COUNT(Buyer1_ID)>=3)
ORDER BY Product1_ID) SUB
ON SUB.Buyer1_ID = B.Buyer1_ID;



--4.Top product From 3 Categories
    --Each sale of each product and the quantity bought
    SELECT P.Product1_ID, P.P1_Name, P.P1_description, C.Cat1_Name, L.Listing1_ID, PP.Purchase1_ID, PP.Pch1_Quantity
    FROM ProductPurchase1 PP
    JOIN AmazonInventory1 A ON A.Inventory1_ID = PP.Inventory1_ID
    JOIN Listing1 L ON L.Listing1_ID = A.Listing1_ID
    JOIN Product1 P ON P.Product1_ID = L.Product1_ID
    JOIN ProductType1 T ON T.ProductType1_ID = P.ProductType1_ID
    JOIN ProductCategory1 C ON C.Category1_ID = T.Category1_ID AND C.Cat1_Name IN ('Computers', 'Electronics', 'Books')
    ORDER BY P.Product1_ID;
    
    --Each sale of each product and the quantity bought
    SELECT P.Product1_ID, C.Cat1_Name, SUM(PP.Pch1_Quantity) AS NumberSold
    FROM ProductPurchase1 PP
    JOIN AmazonInventory1 A ON A.Inventory1_ID = PP.Inventory1_ID
    JOIN Listing1 L ON L.Listing1_ID = A.Listing1_ID
    JOIN Product1 P ON P.Product1_ID = L.Product1_ID
    JOIN ProductType1 T ON T.ProductType1_ID = P.ProductType1_ID
    JOIN ProductCategory1 C ON C.Category1_ID = T.Category1_ID AND C.Cat1_Name IN ('Computers', 'Electronics', 'Books')
    GROUP BY P.Product1_ID, C.Cat1_Name
    ORDER BY Product1_ID;
    
--RESULT: Top products from Computer, Electronics, and Books
SELECT P.Product1_ID, P.P1_Name||', '||P.P1_Description AS ProductInfo, C.Cat1_Name AS CategoryName,
    SUM(PP.Pch1_Quantity) AS NumberSold
FROM ProductPurchase1 PP
JOIN AmazonInventory1 A ON A.Inventory1_ID = PP.Inventory1_ID
JOIN Listing1 L ON L.Listing1_ID = A.Listing1_ID
JOIN Product1 P ON P.Product1_ID = L.Product1_ID
JOIN ProductType1 T ON T.ProductType1_ID = P.ProductType1_ID
JOIN ProductCategory1 C ON C.Category1_ID = T.Category1_ID AND C.Cat1_Name IN ('Computers', 'Electronics', 'Books')
WHERE P.Product1_ID IN 
(
SELECT Product1_ID 
FROM(
    SELECT P.Product1_ID, C2.Cat1_Name, SUM(PP.Pch1_Quantity) AS NumberSold
    FROM ProductPurchase1 PP
    JOIN AmazonInventory1 A ON A.Inventory1_ID = PP.Inventory1_ID
    JOIN Listing1 L ON L.Listing1_ID = A.Listing1_ID
    JOIN Product1 P ON P.Product1_ID = L.Product1_ID
    JOIN ProductType1 T ON T.ProductType1_ID = P.ProductType1_ID
    JOIN ProductCategory1 C2 ON C2.Category1_ID = T.Category1_ID AND C2.Cat1_Name IN ('Computers', 'Electronics', 'Books')
    WHERE C2.Cat1_Name = C.Cat1_Name
    GROUP BY P.Product1_ID, P.P1_Name, P.P1_description, C2.Cat1_Name
    ORDER BY Cat1_Name, NumberSold DESC
    FETCH FIRST ROW ONLY
    )
)
GROUP BY P.Product1_ID, P.P1_Name||', '||P.P1_Description, C.Cat1_Name
ORDER BY Product1_ID;


    
--Stored procedure to add products
CREATE OR REPLACE PROCEDURE Add_Product(
seller_username in VARCHAR2,
seller_warehouse IN NUMBER, --ID of warehouse assigned by AMAZON to seller. Seller can have multiple warehouses to choose from
prod_condition IN NUMBER, --ID of the condition pre-determined by AMAZON
prod_type IN NUMBER, --ID of the type pre-determined by AMAZON
prod_brand IN VARCHAR2,
prod_name IN VARCHAR2,
prod_description IN VARCHAR2,
prod_quantity IN NUMBER, --number of products seller is adding
prod_price IN NUMBER)
IS
NotOption EXCEPTION;
InvalidRecord EXCEPTION;
BEGIN

DECLARE
--Values will equal to 2 if a record exists matching criteria (only one record should match)
product_exists number(1);
inventory_exists number(1);
listing_exists number(1);
--Values should all equal 2 or exception thrown
condition_exists number(1);
type_exists number(1);
warehouse_exists number(1);
--create brand if remains as 1
brand_exists number(1);
BEGIN
    --Default Amazon-determined IDs do not exist (Type of condition, product category type, assigned warehouse)
    SELECT (COUNT(*)+1) INTO condition_exists FROM ProductCondition1 WHERE Condition1_ID = prod_condition;
    SELECT (COUNT(*)+1) INTO type_exists FROM ProductType1 WHERE ProductType1_ID = prod_type;
    SELECT (COUNT(*)+1) INTO warehouse_exists FROM Warehouse1 WHERE Warehouse1_ID = seller_warehouse;
    
    IF  (condition_exists = 1) OR
        (type_exists = 1) OR
        (warehouse_exists = 1)
        THEN RAISE NotOption;
    END IF;
    
    --Creating ProductBrand if it doesn't already exists
    SELECT (COUNT(*)+1) INTO brand_exists FROM ProductBrand1 WHERE Br1_Name = prod_brand;
    IF (brand_exists = 1)
        THEN 
        INSERT INTO ProductBrand1(Brand1_ID, Br1_Name)
        VALUES((SELECT (MAX(Brand1_ID)+1) FROM ProductBrand1), prod_brand);
    END IF;

    --Existing records
    SELECT (COUNT(*)+1) INTO product_exists FROM Product1 WHERE Product1_ID =   
            (SELECT P.Product1_ID
            FROM Product1 P
            JOIN ProductBrand1 PB ON PB.Brand1_ID = P.Brand1_ID
            JOIN ProductType1 T ON T.ProductType1_ID = P.ProductType1_ID
            JOIN ProductCategory1 CT ON CT.Category1_ID = T.Category1_ID
            JOIN ProductCondition1 CD ON CD.Condition1_ID = P.Condition1_ID
            WHERE 
                CD.Condition1_ID = prod_condition AND
                T.ProductType1_ID = prod_type AND
                PB.Br1_Name = prod_brand AND
                P.P1_Name = prod_name AND
                P.P1_Description = prod_description
            );
        
    SELECT (COUNT(*)+1) INTO inventory_exists FROM AmazonInventory1 WHERE Inventory1_ID = 
            (SELECT I.Inventory1_ID
                FROM AmazonInventory1 I
                JOIN Seller1 S ON S.Seller1_ID = I.Seller1_ID
                JOIN Listing1 L ON L.Listing1_ID = I.Listing1_ID
                JOIN Product1 P ON P.Product1_ID = L.Product1_ID
                WHERE 
                    S.S1_Username = seller_username AND
                    P.Product1_ID =                
                        (SELECT P.Product1_ID
                        FROM Product1 P
                        JOIN ProductBrand1 PB ON PB.Brand1_ID = P.Brand1_ID
                        JOIN ProductType1 T ON T.ProductType1_ID = P.ProductType1_ID
                        JOIN ProductCategory1 CT ON CT.Category1_ID = T.Category1_ID
                        JOIN ProductCondition1 CD ON CD.Condition1_ID = P.Condition1_ID
                        WHERE 
                            CD.Condition1_ID = prod_condition AND
                            T.ProductType1_ID = prod_type AND
                            PB.Br1_Name = prod_brand AND
                            P.P1_Name = prod_name AND
                            P.P1_Description = prod_description)
                );
    
    SELECT (COUNT(*)+1) INTO listing_exists FROM Listing1 WHERE Listing1_ID =
                (SELECT L.Listing1_ID
                FROM Listing1 L
                JOIN AmazonInventory1 I ON I.Listing1_ID = L.Listing1_ID
                JOIN Seller1 S ON S.Seller1_ID = I.Seller1_ID
                JOIN Product1 P ON P.Product1_ID = L.Product1_ID
                WHERE 
                    L.P1_Price = prod_price AND
                    P.Product1_ID =                
                        (SELECT P.Product1_ID
                        FROM Product1 P
                        JOIN ProductBrand1 PB ON PB.Brand1_ID = P.Brand1_ID
                        JOIN ProductType1 T ON T.ProductType1_ID = P.ProductType1_ID
                        JOIN ProductCategory1 CT ON CT.Category1_ID = T.Category1_ID
                        JOIN ProductCondition1 CD ON CD.Condition1_ID = P.Condition1_ID
                        WHERE 
                            CD.Condition1_ID = prod_condition AND
                            T.ProductType1_ID = prod_type AND
                            PB.Br1_Name = prod_brand AND
                            P.P1_Name = prod_name AND
                            P.P1_Description = prod_description)
                );    
    
    IF (product_exists != 1 AND product_exists != 2) OR (inventory_exists != 1 AND inventory_exists != 2) OR
        (listing_exists != 1 AND listing_exists != 2)
        THEN
        RAISE InvalidRecord;
    END IF;
    
    --Product exists already
    IF product_exists = 2
        --Product exists, checks if seller is already selling the product already 
        --If the seller is already selling the product, then the listing record already exists (Listing is a FK in Inventory)
        THEN
        IF inventory_exists = 2               
            --Listing already exists. Update values to add products
            THEN
            --Update seller inventory quantity
            UPDATE AmazonInventory1 SET I1_Quantity = (I1_Quantity + prod_quantity)
                WHERE Inventory1_ID = 
                    (SELECT I.Inventory1_ID
                    FROM AmazonInventory1 I
                    JOIN Seller1 S ON S.Seller1_ID = I.Seller1_ID
                    JOIN Listing1 L ON L.Listing1_ID = I.Listing1_ID
                    JOIN Product1 P ON P.Product1_ID = L.Product1_ID
                    WHERE 
                        S.S1_Username = seller_username AND
                        P.Product1_ID =                
                            (SELECT P.Product1_ID
                            FROM Product1 P
                            JOIN ProductBrand1 PB ON PB.Brand1_ID = P.Brand1_ID
                            JOIN ProductType1 T ON T.ProductType1_ID = P.ProductType1_ID
                            JOIN ProductCategory1 CT ON CT.Category1_ID = T.Category1_ID
                            JOIN ProductCondition1 CD ON CD.Condition1_ID = P.Condition1_ID
                            WHERE 
                                CD.Condition1_ID = prod_condition AND
                                T.ProductType1_ID = prod_type AND
                                PB.Br1_Name = prod_brand AND
                                P.P1_Name = prod_name AND
                                P.P1_Description = prod_description)
                        );
            --and listing quantity (all sellers for a product combined)
            UPDATE Listing1 SET L1_Quantity = (L1_Quantity + prod_quantity)
                WHERE Listing1_ID = 
                    (SELECT L.Listing1_ID
                    FROM Listing1 L
                    JOIN AmazonInventory1 I ON I.Listing1_ID = L.Listing1_ID
                    JOIN Seller1 S ON S.Seller1_ID = I.Seller1_ID
                    JOIN Product1 P ON P.Product1_ID = L.Product1_ID
                    WHERE 
                        S.S1_Username = seller_username AND
                        P.Product1_ID =                
                            (SELECT P.Product1_ID
                            FROM Product1 P
                            JOIN ProductBrand1 PB ON PB.Brand1_ID = P.Brand1_ID
                            JOIN ProductType1 T ON T.ProductType1_ID = P.ProductType1_ID
                            JOIN ProductCategory1 CT ON CT.Category1_ID = T.Category1_ID
                            JOIN ProductCondition1 CD ON CD.Condition1_ID = P.Condition1_ID
                            WHERE 
                                CD.Condition1_ID = prod_condition AND
                                T.ProductType1_ID = prod_type AND
                                PB.Br1_Name = prod_brand AND
                                P.P1_Name = prod_name AND
                                P.P1_Description = prod_description)
                    ); 
        
        --Product exists but seller is not selling it yet. Create seller inventory and update listing
        ELSE
            --Check if listing does NOT exists (product is NOT being sold by different seller). Creates listing if so.
            IF listing_exists = 1
                --Product exists, but no other sellers are selling it
                THEN
                --Create listing
                INSERT INTO Listing1(Listing1_ID, Product1_ID, L1_Quantity, P1_Price)
                VALUES((SELECT (MAX(Listing1_ID)+1) FROM Listing1), 
                    (SELECT P.Product1_ID --Product1_ID
                        FROM Product1 P
                        JOIN ProductBrand1 PB ON PB.Brand1_ID = P.Brand1_ID
                        JOIN ProductType1 T ON T.ProductType1_ID = P.ProductType1_ID
                        JOIN ProductCategory1 CT ON CT.Category1_ID = T.Category1_ID
                        JOIN ProductCondition1 CD ON CD.Condition1_ID = P.Condition1_ID
                        WHERE 
                            CD.Condition1_ID = prod_condition AND
                            T.ProductType1_ID = prod_type AND
                            PB.Br1_Name = prod_brand AND
                            P.P1_Name = prod_name AND
                            P.P1_Description = prod_description),
                    0, prod_price); --Quantity starts with 0 until seller has inventory
            END IF;    
        --Product exists, Listing exists, seller does not yet sell the product. Create seller inventory and update listing
        --Create inventory
        INSERT INTO AmazonInventory1(Inventory1_ID, Seller1_ID, Listing1_ID, Warehouse1_ID, I1_Quantity)
        VALUES((SELECT (MAX(Inventory1_ID)+1) FROM AmazonInventory1),
                (SELECT Seller1_ID FROM Seller1 WHERE S1_Username = seller_username), --Seller1_ID
                (SELECT L.Listing1_ID --Listing1_ID
                FROM Listing1 L
                JOIN AmazonInventory1 I ON I.Listing1_ID = L.Listing1_ID
                JOIN Seller1 S ON S.Seller1_ID = I.Seller1_ID
                JOIN Product1 P ON P.Product1_ID = L.Product1_ID
                WHERE 
                    L.P1_Price = prod_price AND
                    P.Product1_ID =                
                        (SELECT P.Product1_ID
                        FROM Product1 P
                        JOIN ProductBrand1 PB ON PB.Brand1_ID = P.Brand1_ID
                        JOIN ProductType1 T ON T.ProductType1_ID = P.ProductType1_ID
                        JOIN ProductCategory1 CT ON CT.Category1_ID = T.Category1_ID
                        JOIN ProductCondition1 CD ON CD.Condition1_ID = P.Condition1_ID
                        WHERE 
                            CD.Condition1_ID = prod_condition AND
                            T.ProductType1_ID = prod_type AND
                            PB.Br1_Name = prod_brand AND
                            P.P1_Name = prod_name AND
                            P.P1_Description = prod_description)
                ),
                seller_warehouse, prod_quantity);
        
        --Update listing (same as above)        
        UPDATE Listing1 SET L1_Quantity = (L1_Quantity + prod_quantity)
                WHERE Listing1_ID = 
                    (SELECT L.Listing1_ID
                    FROM Listing1 L
                    JOIN AmazonInventory1 I ON I.Listing1_ID = L.Listing1_ID
                    JOIN Seller1 S ON S.Seller1_ID = I.Seller1_ID
                    JOIN Product1 P ON P.Product1_ID = L.Product1_ID
                    WHERE 
                        S.S1_Username = seller_username AND
                        P.Product1_ID =                
                            (SELECT P.Product1_ID
                            FROM Product1 P
                            JOIN ProductBrand1 PB ON PB.Brand1_ID = P.Brand1_ID
                            JOIN ProductType1 T ON T.ProductType1_ID = P.ProductType1_ID
                            JOIN ProductCategory1 CT ON CT.Category1_ID = T.Category1_ID
                            JOIN ProductCondition1 CD ON CD.Condition1_ID = P.Condition1_ID
                            WHERE 
                                CD.Condition1_ID = prod_condition AND
                                T.ProductType1_ID = prod_type AND
                                PB.Br1_Name = prod_brand AND
                                P.P1_Name = prod_name AND
                                P.P1_Description = prod_description)
                    );      
        END IF;
    
    --Product does not exist at all -- no listing exists (can initialize quantity as seller's quantity during instantiation)
    ELSE    
        --create product, then listing for product, then inventory
        INSERT INTO Product1(Product1_ID, Condition1_ID, ProductType1_ID, Brand1_ID, P1_Name, P1_Description)
        VALUES((SELECT (MAX(Product1_ID)+1) FROM Product1) , prod_condition, prod_type,
            (SELECT Brand1_ID FROM ProductBrand1 WHERE Br1_name = prod_brand), prod_name, prod_description);
    
        INSERT INTO Listing1(Listing1_ID, Product1_ID, L1_Quantity, P1_Price)
        VALUES((SELECT (MAX(Listing1_ID)+1) FROM Listing1), 
                (SELECT Product1_ID FROM Product1 
                    WHERE Condition1_ID = prod_condition 
                    AND ProductType1_ID = prod_type 
                    AND Brand1_ID = (SELECT Brand1_ID FROM ProductBrand1 WHERE Br1_name = prod_brand)
                    AND P1_Name = prod_name 
                    AND P1_Description = prod_description),
            prod_quantity, prod_price);
            
        INSERT INTO AmazonInventory1(Inventory1_ID, Seller1_ID, Listing1_ID, Warehouse1_ID, I1_Quantity)
        VALUES((SELECT (MAX(Inventory1_ID)+1) FROM AmazonInventory1),
            (SELECT Seller1_ID FROM Seller1 WHERE S1_Username = seller_username),
            (SELECT Listing1_ID FROM Listing1 
                WHERE Product1_ID = 
                    (SELECT Product1_ID FROM Product1 
                    WHERE Condition1_ID = prod_condition 
                    AND ProductType1_ID = prod_type 
                    AND Brand1_ID = (SELECT Brand1_ID FROM ProductBrand1 WHERE Br1_name = prod_brand)
                    AND P1_Name = prod_name 
                    AND P1_Description = prod_description)),
            seller_warehouse, prod_quantity);
    END IF;

END;

EXCEPTION
WHEN NotOption THEN
raise_application_error (-20001, 'Condition, product type, and/or warehouse does not exist');
WHEN OTHERS THEN
raise_application_error(-20002, 'An error has occured adding product'); --including incorrect seller

END;

--Adding an already existing product that the seller has already sold (add to quantity)
SELECT S.S1_username, I.Warehouse1_ID AS Warehouse, P.Brand1_ID AS Brand, P.P1_name AS ProdName, P.ProductType1_ID AS ProdType, 
    P.P1_description AS ProdDesc, P.Condition1_ID AS ProdCond, I.I1_Quantity AS SellerQuantity, L.L1_Quantity AS AmazonQuantity,
    L.P1_price AS Price
FROM Seller1 S
JOIN AmazonInventory1 I ON I.Seller1_ID = S.Seller1_ID
JOIN Listing1 L ON  L.Listing1_ID = I.Listing1_ID
JOIN Product1 P ON P.Product1_ID = L.Product1_ID
WHERE P.P1_Name = 'Roomie Tec';

    --Add to product list as seller MrNiceGuy
EXECUTE Add_Product('MrNiceGuy',6002, 2001, 4001, 'Roomie','Roomie Tec','Cordless, 2-in-1 Handheld',5, 100);

--New Product, new brand
    SELECT S.S1_username, I.Warehouse1_ID AS Warehouse, B.Br1_name AS Brand, P.P1_name AS ProdName, P.ProductType1_ID AS ProdType, 
    P.P1_description AS ProdDesc, P.Condition1_ID AS ProdCond, I.I1_Quantity AS SellerQuantity, L.L1_Quantity AS AmazonQuantity,
    L.P1_price AS Price
    FROM Seller1 S
    JOIN AmazonInventory1 I ON I.Seller1_ID = S.Seller1_ID
    JOIN Listing1 L ON  L.Listing1_ID = I.Listing1_ID
    JOIN Product1 P ON P.Product1_ID = L.Product1_ID
    JOIN ProductBrand1 B ON B.Brand1_ID = P.Brand1_ID
    WHERE B.Br1_Name = 'Kay Jewelry';

EXECUTE Add_Product('MrNiceGuy',6001, 2001, 4009, 'Kay Jewelry','Around-the-world Diamond','Real Diamonds', 15, 200);

    --Checks to see how many listings of the new product exists 
    SELECT S.S1_username, I.Warehouse1_ID, P.Brand1_ID, P.P1_name, P.ProductType1_ID, 
        P.P1_description, P.Condition1_ID, I.I1_Quantity, L.L1_Quantity, L.P1_price
    FROM Seller1 S
    JOIN AmazonInventory1 I ON I.Seller1_ID = S.Seller1_ID
    JOIN Listing1 L ON  L.Listing1_ID = I.Listing1_ID
    JOIN Product1 P ON P.Product1_ID = L.Product1_ID
    WHERE P.P1_Name = 'Around-the-world Diamond';

--Adding an already existing product the seller has not yet sold
    --All listings and its descriptions sold by specific seller
    SELECT S.S1_username, I.Warehouse1_ID, P.Brand1_ID, P.P1_name, P.ProductType1_ID, 
        P.P1_description, P.Condition1_ID, I.I1_Quantity, L.L1_Quantity, L.P1_price
    FROM Seller1 S
    JOIN AmazonInventory1 I ON I.Seller1_ID = S.Seller1_ID
    JOIN Listing1 L ON  L.Listing1_ID = I.Listing1_ID
    JOIN Product1 P ON P.Product1_ID = L.Product1_ID
    WHERE S.S1_Username = 'MsNiceGirl';

    --All listings and its description of a specific product
    SELECT S.S1_username, L.Listing1_ID, P.ProductType1_ID, P.P1_name, P.P1_description, 
         P.Condition1_ID, I.I1_Quantity, L.L1_Quantity, L.P1_price
    FROM Seller1 S
    JOIN AmazonInventory1 I ON I.Seller1_ID = S.Seller1_ID
    JOIN Listing1 L ON  L.Listing1_ID = I.Listing1_ID
    JOIN Product1 P ON P.Product1_ID = L.Product1_ID
    WHERE P.P1_Name = 'Roomie Tec';

EXECUTE Add_Product('MsNiceGirl',6003, 2001, 4001, 'Roomie','Roomie Tec','Cordless, 2-in-1 Handheld', 15, 100);

--Modify Product. (Can't change anything else without it being considered a new product) 
CREATE OR REPLACE PROCEDURE Modify_Price(
seller_inventory IN NUMBER, --ID of inventory (which determines listing of product by seller)
new_price IN NUMBER)
IS
InvalidProduct EXCEPTION;
InvalidRecord EXCEPTION;

BEGIN

DECLARE 
s_inventory_exists number(1); --checks to make sure seller_inventory is valid
new_listing_exists number(1); --checks to see if another listing for the product with same price exists

    BEGIN     
        SELECT (COUNT(*)+1) INTO s_inventory_exists FROM AmazonInventory1 WHERE Inventory1_ID = seller_inventory;
        SELECT (COUNT(*)+1) INTO new_listing_exists FROM Listing1 
            WHERE Product1_ID =                --Where product and price matches
               (SELECT L.Product1_ID
                FROM Listing1 L
                JOIN AmazonInventory1 I ON I.Listing1_ID = L.Listing1_ID
                AND I.Inventory1_ID = seller_inventory
                )
            AND P1_Price = new_price; --Should only have 1 record of this if it exists
                
        IF (new_listing_exists != 2 AND new_listing_exists != 1) OR s_inventory_exists > 2
            THEN
            RAISE InvalidRecord;
        END IF;

        IF new_listing_exists = 1 --New listing does not exist
            THEN
            --Create new listing
            INSERT INTO Listing1(Listing1_ID, Product1_ID, L1_Quantity, P1_Price)
            VALUES((SELECT (MAX(Listing1_ID)+1)  FROM Listing1), 
               (SELECT L.Product1_ID --Product1_ID does not change
                FROM Listing1 L
                JOIN AmazonInventory1 I ON I.Listing1_ID = L.Listing1_ID
                AND I.Inventory1_ID = seller_inventory),
               (SELECT I1_Quantity --Inventory Quantity
                FROM AmazonInventory1 I
                WHERE Inventory1_ID = seller_inventory), new_price);
            --Remove quantity of seller's products from old listing
            UPDATE Listing1 SET L1_Quantity = (L1_Quantity - 
               (SELECT I1_Quantity --Inventory Quantity
                FROM AmazonInventory1 I
                WHERE Inventory1_ID = seller_inventory)) 
            WHERE Listing1_ID = 
               (SELECT L.Listing1_ID 
                FROM Listing1 L
                JOIN AmazonInventory1 I ON I.Listing1_ID = L.Listing1_ID
                AND I.Inventory1_ID = seller_inventory);
            --Change Inventory's listing reference to new listing
            UPDATE AmazonInventory1 SET Listing1_ID = (SELECT MAX(Listing1_ID) FROM Listing1)
            WHERE Inventory1_ID = seller_inventory;

        ELSE
            --New listing exists. 
            --Remove quantity of seller's products from old listing
            UPDATE Listing1 SET L1_Quantity = (L1_Quantity - 
               (SELECT I1_Quantity --Inventory Quantity
                FROM AmazonInventory1 I
                WHERE Inventory1_ID = seller_inventory)) 
            WHERE Listing1_ID = 
               (SELECT L.Listing1_ID 
                FROM Listing1 L
                JOIN AmazonInventory1 I ON I.Listing1_ID = L.Listing1_ID
                AND I.Inventory1_ID = seller_inventory);
            --Update new listing quantity (add)
            UPDATE Listing1 
            SET L1_Quantity = L1_Quantity +
               (SELECT I1_Quantity --Inventory Quantity
                FROM AmazonInventory1
                WHERE Inventory1_ID = seller_inventory) 
            WHERE Product1_ID =  
               (SELECT L.Product1_ID 
                FROM Listing1 L
                JOIN AmazonInventory1 I ON I.Listing1_ID = L.Listing1_ID
                AND I.Inventory1_ID = seller_inventory
                )
            AND P1_Price = new_price;               
            --Change Inventory Listing reference
            UPDATE AmazonInventory1 
            SET Listing1_ID = 
               (SELECT L.Listing1_ID 
                FROM Listing1 L
                WHERE L.Product1_ID =  
                   (SELECT L2.Product1_ID 
                    FROM Listing1 L2
                    JOIN AmazonInventory1 I ON I.Listing1_ID = L2.Listing1_ID
                    AND I.Inventory1_ID = seller_inventory
                    )
                AND P1_Price = new_price)
            WHERE Inventory1_ID = seller_inventory;
        END IF;
    END; 

EXCEPTION
WHEN InvalidProduct THEN
raise_application_error (-20001, 'No product exists in seller inventory'); 
--product can exist, but seller isn't selling it
WHEN InvalidRecord THEN
raise_application_error (-20001, 'Duplicate idential records for listing or seller exists'); 
--Same inventory or listing with multiple IDs
WHEN OTHERS THEN
raise_application_error(-20002, 'An error has occured trying to modify product price');

END;

--Changing Seller 1's listing for Roomie Tec from 100 to 105
SELECT S.Seller1_ID, I.Inventory1_ID, L.Listing1_ID, L.P1_Price, I.I1_Quantity, L.L1_Quantity
FROM Seller1 S
JOIN AmazonInventory1 I ON I.Seller1_ID = S.Seller1_ID
JOIN Listing1 L ON L.Listing1_ID = I.Listing1_ID
JOIN Product1 P ON P.Product1_ID = L.Product1_ID
WHERE S.Seller1_ID = 1 AND P.P1_Name = 'Roomie Tec'; --Hardcoding to show results

EXECUTE Modify_Price(14, 105);

--Seller 1, 3, 4 all sell the same product.
SELECT S.Seller1_ID, I.Inventory1_ID, L.Listing1_ID, L.P1_Price, I.I1_Quantity, L.L1_Quantity
FROM Seller1 S
JOIN AmazonInventory1 I ON I.Seller1_ID = S.Seller1_ID
JOIN Listing1 L ON L.Listing1_ID = I.Listing1_ID
JOIN Product1 P ON P.Product1_ID = L.Product1_ID
WHERE P.Product1_ID = 6;

    --Seller 4 modifies price from 30 to 29.99
EXECUTE Modify_Price(9, 29.99);

--The lowest priced listings of each product in a specific category
SELECT L.Listing1_ID, P.Product1_ID, P.P1_Name, P.P1_description, to_char(L.P1_price, '$999,999.00') AS Price
FROM Listing1 L
JOIN Product1 P ON P.Product1_ID = L.Product1_ID
JOIN ProductType1 PT ON PT.ProductType1_ID = P.ProductType1_ID
JOIN ProductCategory1 CT ON CT.Category1_ID = PT.Category1_ID AND CT.Cat1_Name = 'Electronics'
JOIN ProductCondition1 CD ON CD.Condition1_ID = P.Condition1_ID AND CD.Con1_Type = 'New'
WHERE L.Listing1_ID IN
    (SELECT L.Listing1_ID--, P2.P1_Name, P2.P1_description, L.P1_Price
     FROM Listing1 L
     JOIN Product1 P2 ON P2.Product1_ID = L.Product1_ID 
     WHERE P2.Product1_ID = P.Product1_ID
     ORDER BY P2.Product1_ID, L.P1_Price ASC
     FETCH FIRST ROW ONLY)      
ORDER BY P.Product1_ID;

    --Adding a used product to check query selects or not
    SELECT S.S1_username, I.Warehouse1_ID, P.Brand1_ID, P.P1_name, P.ProductType1_ID, 
        P.P1_description, P.Condition1_ID, I.I1_Quantity, L.L1_Quantity, L.P1_price
    FROM Seller1 S
    JOIN AmazonInventory1 I ON I.Seller1_ID = S.Seller1_ID
    JOIN Listing1 L ON  L.Listing1_ID = I.Listing1_ID
    JOIN Product1 P ON P.Product1_ID = L.Product1_ID
    WHERE P.P1_Name = 'Kingston Bolt';
    
    EXECUTE Add_Product('MrNiceBoy',6004, 2002, 4007, 'Kingston','Kingston Bolt','8GB', 2, 8);



--Products sold to the most number of buyers (regardless of quantity purchased per buyer) in 3 specified categories
--Products and Amount of buyers
    SELECT P.P1_Name, P.P1_description, C.Cat1_Name, count(O.Buyer1_ID) AS NumberBuyers
    FROM ProductPurchase1 PP
    JOIN Orders1 O ON O.Orders1_ID = PP.Orders1_ID
    JOIN AmazonInventory1 I ON I.Inventory1_ID = PP.Inventory1_ID
    JOIN Listing1 L ON L.Listing1_ID = I.Listing1_ID
    JOIN Product1 P ON P.Product1_ID = L.Product1_ID
    JOIN ProductType1 T ON T.ProductType1_ID = P.ProductType1_ID
    JOIN ProductCategory1 C ON C.Category1_ID = T.Category1_ID
    GROUP BY P.P1_Name, P.P1_description, C.Cat1_Name
    ORDER BY NumberBuyers;
    
    --Search by "Computers", "Books", "Electronics"
    SELECT P.Product1_ID, P.P1_Name, P.P1_description, C.Cat1_Name, count(O.Buyer1_ID) AS NumberBuyers
    FROM ProductPurchase1 PP
    JOIN Orders1 O ON O.Orders1_ID = PP.Orders1_ID
    JOIN AmazonInventory1 I ON I.Inventory1_ID = PP.Inventory1_ID
    JOIN Listing1 L ON L.Listing1_ID = I.Listing1_ID
    JOIN Product1 P ON P.Product1_ID = L.Product1_ID
    JOIN ProductType1 T ON T.ProductType1_ID = P.ProductType1_ID
    JOIN ProductCategory1 C ON C.Category1_ID = T.Category1_ID AND C.Cat1_Name IN ('Computers', 'Electronics', 'Books')
    GROUP BY P.Product1_ID, P.P1_Name, P.P1_description, C.Cat1_Name
    ORDER BY Cat1_Name, NumberBuyers;
   
--RESULT: Products sold to the most number of buyers (regardless of quantity purchased per buyer) in 3 specified categories   
SELECT P.Product1_ID, P.P1_Name||', '||P.P1_Description AS ProductInfo, C.Cat1_Name, count(O.Buyer1_ID) AS NumberBuyers
FROM ProductPurchase1 PP
JOIN Orders1 O ON O.Orders1_ID = PP.Orders1_ID
JOIN AmazonInventory1 I ON I.Inventory1_ID = PP.Inventory1_ID
JOIN Listing1 L ON L.Listing1_ID = I.Listing1_ID
JOIN Product1 P ON P.Product1_ID = L.Product1_ID
JOIN ProductType1 T ON T.ProductType1_ID = P.ProductType1_ID
JOIN ProductCategory1 C ON C.Category1_ID = T.Category1_ID AND C.Cat1_Name IN ('Computers', 'Electronics', 'Books') 
WHERE P.Product1_ID IN 
    (
    SELECT Product1_ID 
    FROM(
        SELECT P.Product1_ID, P.P1_Name, P.P1_description, C2.Cat1_Name, count(O.Buyer1_ID) AS NumberBuyers
        FROM ProductPurchase1 PP
        JOIN Orders1 O ON O.Orders1_ID = PP.Orders1_ID
        JOIN AmazonInventory1 I ON I.Inventory1_ID = PP.Inventory1_ID
        JOIN Listing1 L ON L.Listing1_ID = I.Listing1_ID
        JOIN Product1 P ON P.Product1_ID = L.Product1_ID
        JOIN ProductType1 T ON T.ProductType1_ID = P.ProductType1_ID
        JOIN ProductCategory1 C2 ON C2.Category1_ID = T.Category1_ID AND C2.Cat1_Name IN ('Computers', 'Electronics', 'Books')
        WHERE C2.Cat1_Name = C.Cat1_Name
        GROUP BY P.Product1_ID, P.P1_Name, P.P1_description, C2.Cat1_Name
        ORDER BY Cat1_Name, NumberBuyers DESC
        FETCH FIRST ROW ONLY
        )
    )
GROUP BY P.Product1_ID, P.P1_Name||', '||P.P1_Description, C.Cat1_Name
ORDER BY Cat1_Name;
         
--Creating an index for product name
CREATE INDEX prod_name_index ON Product1(P1_Name);

commit;    