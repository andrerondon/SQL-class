
4a. Insert a new product into the system with values in all columns.

INSERT INTO products
(id, name, description, price, sale_price, remaining_quantity)
VALUES (476, 'Quantum Finger Cuffs', 'To restrain pickpockets', 1, .9, 90)

SELECT MAX(id) FROM products

SELECT *
FROM products
WHERE id = 476

4b. Find all line_item rows that have a product_id of NULL and update them to be your new products id
SELECT *
FROM line_items
WHERE product_id IS NULL

UPDATE line_items
SET product_id = 476
WHERE product_id IS NULL

4c. Find the average line_item total price (meaning quantity * price) for each order
 that was completed in February 2007 month.

 select avg (total_price)
from (
	select *, quantity * price as total_price
	from line_items li
	inner join Orders o on li.order_id = o.id
	where completed_on  between 'feb 1, 2007' and 'feb 28 2007'
) x

--2nd way of doing it

select avg (total_price)
from (
	select *, quantity * price as total_price
	from line_items li
	inner join Orders o on li.order_id = o.id
	where completed_on  between 'feb 1, 2007' and 'feb 28 2007'
) x


5.  Find all products that were sold in 2016 or 2017, show their name, current price (not sale_price),
and the lowest price they were sold in 2016 or 2017.

--question was originally 'the last 20 months' but turned out there was no data.  Used the following queries
--to adjust the question appropriately

ELECT MIN(completed_on) AS min_date, MAX(completed_on) AS max_date,
CURRENT_DATE - INTERVAL '20 months'
--DATE_ADD('month', -20, CURRENTDATE)

SELECT DISTINCT p.name, p.price AS current_price, x.min_price
FROM orders o
INNER JOIN line_items li ON li.order_id = o.id
INNER JOIN products p ON p.id = li.product_id
INNER JOIN
(	SELECT MIN(price) AS min_price, li.product_id
	FROM orders o
	INNER JOIN line_items li ON li.order_id = o.id
	WHERE DATE_PART('year', completed_on) IN (2016, 2017)
	GROUP BY product_id
) x ON x.product_id = p.id
WHERE DATE_PART('year', completed_on) IN (2016, 2017)
ORDER BY 1, 2, 3


-- Guru solution

SELECT p.name , p.price , MIN(li.price) AS lowest_price
FROM products p
LEFT JOIN line_items li ON li.product_id = p.id
LEFT JOIN orders o ON o.id = li.order_id
WHERE date_part('year', completed_on) = 2016 or date_part('year', completed_on) = 2017
GROUP BY p.price,p.name




6. Calculate how many items in stock weve ever had for each product (remaining or sold) in the database.
6b. Same as 6, but show the total price for the sold 



6.1 The client wants to know how many of each product has been sold.  Find the total number of items sold for each product.

SELECT product_id, SUM(quantity) as total_sold, p.name
FROM line_items li
INNER JOIN products p ON p.id = li.product_id
GROUP BY product_id, p.name

6.2 The client wants to know how many of each product it has bought.  Find the total number of items sold for each product and the remaining stock.
6.3 Find the total value of each product sold.  (6.1 but summing up the values)
6.4 Find the average price for each product sold.

7. Find the minimum, maximum, and average order total or orders in March 2008
8. Select all the products that have been purchased in the last 24 months.
9. Select the top 10 products in terms of 2007s gross sales.
10. Select all the products that werent purchased in March.
11. Select the average order total price for all the `Leather Gloves` products.
12. CREATE TABLE users (  id  SERIAL PRIMARY KEY,  email VARCHAR(128) NOT NULL);
    CREATE TABLE groups (  id  SERIAL PRIMARY KEY,  group_name VARCHAR(128) NOT NULL);
    CREATE TABLE user_group_memberships (  id  SERIAL PRIMARY KEY,  user_id INTEGER NOT NULL,  group_id INTEGER NOT NULL);
    Please write a query to determine, given a particular users email address, what group ids and groups names do they belong to (associate with)?
13. We need to find out the sales by day of the week so we can see which days people are buying stuff.  So list all days of the week (Mon-Sun) and their total sales.
14. We need the same as 13, but the average total sale.  We want to know if bigger orders are being placed on certain days or not.

Stretches
=========
S1. Find the average order total price for all the orders in the system with only one query. (without nested query)
S2. Find the number of orders for each month and display that count along with the month/year that the number of orders is for.  Sort it by most orders.  Sort it again but chronologically.
S3. Find all the descriptors and materials used in all 'gloves' products.  ie.  Durable Steel Gloves has 'steel' as the material and 'durable' as the descriptor.
