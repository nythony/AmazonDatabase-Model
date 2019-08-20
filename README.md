# Amazon Database Model
A database that models the Amazon's database. Manages sellers (personal/account information), Amazon warehouses, products, listings, orders, consumers (personal/account information), and shipment.

/////////////

The code for this model is for Oracle SQL Developer. The data definition language (DDL) includes sample data insert scripts.

The following data modification langauge (DML) are included, along with example executions:

  1. A query that returns information about products in the “Computers” or “Electronics” categories that cost $30 or less.
  2. A query that returns all of a particular seller's products that have an inventory of 11 or less sold in the past 2 months.
  3. A query that returns the names and addresses of all customers who bought any product that was purchased by at least three different people. 
  4. A query that returns the top single product from each of the three categories: 'Computers', 'Electronics', and 'Books'
  5. A stored procedure for a seller to add products. This stored procedure accounts for different scenarios (e.g. product exists, but not for an existing brand; seller already sells that product; product does not exist; product exist but seller has never sold it; etc)
  6. A stored procedure to modify the price. Due to the design of this database, a product is considered a different product if any other attribute of the product gets modified.
  7. A query that returns the lowest priced listings of each product in a specific category
  8. A query that returns the products sold to the most number of buyers (regardless of quantity purchased per buyer) in 3 specified categories: 'Computers', 'Electronics', and 'Books'
