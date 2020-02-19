/*
[Note] For the following exercises, the price in the line_items table is price per unit and not total price.
1. Put the following in order of usage:
WHERE, FROM, OFFSET, JOIN, SELECT, LIMIT, GROUP BY. What was missed?
SELECT, FROM, 

2. Select all the products that have orders and their orders
*/


select count(x.*) FROM
(SELECT *
FROM products p
LEFT JOIN line_items i ON i.product_id = p.id
ORDER BY p.id) x
GROUP BY x.product_id




3. Select all the products and their orders

SELECT * p.id AS product_id, description, name, p.price AS product_price, remaining_quantity, sale_price
--, i.order_id, i.price AS line_item_price, i.quantity AS line_item_quantity, o.completed_on AS order_date
FROM products p
INNER JOIN line_items i ON i.product_id = p.id
INNER JOIN orders o ON o.id = i.order_id
WHERE p.id IN
	(SELECT DISTINCT product_id
	FROM line_items i
	WHERE product_id IS NOT NULL
	ORDER BY 1)
ORDER BY product_id

Pre-4.  Remove all line_items that do not have a product_id.

DELETE 
FROM line_items
where product_id is null 
--
SELECT product_id
FROM line_items
where product_id is null 
--

4. Find the average line_item total price (meaning quantity * price) for each order that were completed in February 2007 month.
5. Select product names, product prices and the lowest price they were sold at during the last 20 months, sorting with the highest price first.
6. Calculate how many items in stock weve ever had for each product (remaining or sold) in the database.
7. Find the minimum, maximum, and average order total or orders in March 2008
8. Select all the products that have been purchased in the last 24 months.
9. Select the top 10 products in terms of 2007s gross sales.
10. Select all the products that werent purchased in March.
11. Select the average order total price for all the `Leather Gloves` products.
12. CREATE TABLE users (  id  SERIAL PRIMARY KEY,  email VARCHAR(128) NOT NULL);
    CREATE TABLE groups (  id  SERIAL PRIMARY KEY,  group_name VARCHAR(128) NOT NULL);
    CREATE TABLE user_group_memberships (  id  SERIAL PRIMARY KEY,  user_id INTEGER NOT NULL,  group_id INTEGER NOT NULL);
    Please write a query to determine, given a particular user email address, what group ids and groups names do they belong to (associate with)?


Stretches
=========
S1. Find the average order total price for all the orders in the system with only one query. (without nested query)
S2. Find the number of orders for each month and display that count along with the month/year that the number of orders is for.  Sort it by most orders.  Sort it again but chronologically.
S3. Find all the descriptors and materials used in all 'gloves' products.  ie.  Durable Steel Gloves has 'steel' as the material and 'durable' as the descriptor.



