
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

SELECT product_id,  p.name, --SUM(quantity) as total_sold, p.remaining_quantity,
SUM(quantity) + p.remaining_quantity AS total_inventory
FROM line_items li
INNER JOIN products p ON p.id = li.product_id
GROUP BY product_id, p.name, remaining_quantity



6.3 Find the total value of each product sold.  (6.1 but summing up the values)

SELECT product_id,
SUM(li.quantity * li.price) as sum_total_sold,
p.name
FROM line_items li
INNER JOIN products p ON p.id = li.product_id
GROUP BY product_id, p.name


6.4 Find the average price for each product sold.


SELECT AVG(li.price), li.product_id
FROM line_items li
GROUP BY product_id;

SELECT * from line_items where product_id = 4

SELECT( 32.15 + (34.15 * 5) + 38.15) / 7

SELECT --SUM(price * quantity) AS tot_value,
ROUND((SUM(price * quantity) / SUM (quantity))::numeric, 2) AS avg_price, product_id
FROM line_items
GROUP BY product_id
--WHERE product_id = 4
7a. Find which year/month has the highest number of orders.
select TO_CHAR(o.completed_on,'Mon') as mon,
	EXTRACT(year FROM o.completed_on) AS yyyy,
    count(*) AS noOforders
FROM line_items li
INNER JOIN orders o ON o.id = li.order_id
GROUP BY 1,2
ORDER BY noOforders DESC
LIMIT 1

/*
SELECT DATE_PART('year', completed_on), DATE_PART('month', completed_on), COUNT(*)
FROM orders o
GROUP BY DATE_PART('year', completed_on), DATE_PART('month', completed_on)
ORDER BY 3 DESC
LIMIT 1
*/

SELECT DATE_PART('year', completed_on), DATE_PART('month', completed_on), COUNT(*)
FROM orders o
GROUP BY 1,2
LIMIT 1

7b. Find which year/months have the highest and lowest value of orders.
 - Lowest - January 2007 = 20.58
 SELECT DATE_PART('year', completed_on), DATE_PART('month', completed_on),
SUM(li.price * li.quantity) AS total_monthly_sales
FROM orders o
INNER JOIN line_items li ON li.order_id = o.id
GROUP BY 1,2
ORDER BY 3
LIMIT 1

 - Highest - Dec 2007 - 3322.48
 SELECT DATE_PART('year', completed_on), DATE_PART('month', completed_on),
SUM(li.price * li.quantity) AS total_monthly_sales
FROM orders o
INNER JOIN line_items li ON li.order_id = o.id
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 1

7c. Find the minimum, maximum, and average order total for orders in January 2006 in a single query.

SELECT MAX(order_total) AS max_order_total, MIN(order_total) AS min_order_total, AVG(order_total) AS avg_order_total
FROM
(
	SELECT SUM(li.price * li.quantity) AS order_total , o.id
	FROM orders o
	INNER JOIN line_items li ON li.order_id = o.id
	WHERE DATE_PART('year', completed_on) = 2006 AND DATE_PART('month', completed_on) = 1
	GROUP BY o.id
) x

7d. Find which month has the highest number of orders.
7e. Find which year has the lowest value of sales.

8a.  Find all the orders from 2007.
SELECT completed_on
FROM orders
--WHERE completed_on > '2007-01-01' AND completed_on < '2008-01-01'
--WHERE completed_on BETWEEN '2007-01-01' AND  '2008-01-01'
WHERE DATE_PART('year', completed_on) = 2007

8b.  Include all the line_items for those orders.
SELECT *
FROM orders o
LEFT JOIN line_items li ON li.order_id = o.id
WHERE completed_on > '2007-01-01' AND completed_on < '2008-01-01'

8c.  Find the top 10 products in terms of 2007s gross sales.  Show the product name and its gross sales.
--8c.  Find the top 10 products in terms of 2007's gross sales.
--Show the product name and its' gross sales.

SELECT o.id, SUM(li.price * li.quantity) AS order_total
FROM orders o
LEFT JOIN line_items li ON li.order_id = o.id
WHERE completed_on > '2007-01-01' AND completed_on < '2008-01-01'
GROUP BY o.id
ORDER BY order_total DESC
LIMIT 10

10. Select all the products that werent purchased in March.

--first get all orders that in March.
SELECT *
FROM orders o
WHERE DATE_PART('month', completed_on) = 3

--second get all the product ids that are in those orders
SELECT DISTINCT li.product_id
FROM orders o
INNER JOIN line_items li ON li.order_id = o.id
WHERE DATE_PART('month', completed_on) = 3

--finally select all the products that do NOT have ids found in orders
SELECT COUNT(*)
FROM products
WHERE id NOT IN
(
	SELECT DISTINCT li.product_id
	FROM orders o
	INNER JOIN line_items li ON li.order_id = o.id
	WHERE DATE_PART('month', completed_on) = 3
)


11. Select the average order total price for all orders containing some type of `Leather Gloves` product.
a) one way to do this
SELECT *
FROM line_items li
WHERE li.product_id IN
(
	SELECT id
	FROM products p
	WHERE p.name ILIKE '%Leather Gloves%'
)

b) Second way, using a join to filter the products
SELECT *
FROM line_items li
INNER JOIN products p ON p.id = li.product_id AND p.name ILIKE '%Leather Gloves%'

c) second step, grab all the order ids that have a line_item that has a product of type Leather gloves
SELECT order_id
FROM line_items li
WHERE li.product_id IN
(
  SELECT id
  FROM products p
  WHERE p.name ILIKE '%Leather Gloves%'
)

d)  Select all line_items for all orders that have a line_item that has a product of type leather gloves.
--
SELECT li.order_id, li.product_id, p.name, li.price, li.quantity
FROM line_items li
INNER JOIN products p ON p.id = li.product_id
WHERE order_id IN
(
	SELECT order_id
	FROM line_items li
	WHERE li.product_id IN
	(
		SELECT id
		FROM products p
		WHERE p.name ILIKE '%Leather Gloves%'
	)
)
ORDER BY order_id, product_id

e)  Now find the average total order price for each orders

-- find all line_items containing one of those types of gloves
SELECT SUM(li.price * li.quantity) as order_total, order_id   --li.order_id, li.product_id, p.name, li.price, li.quantity
FROM line_items li
INNER JOIN products p ON p.id = li.product_id
WHERE order_id IN
(
	SELECT order_id
	FROM line_items li
	WHERE li.product_id IN
	(
		SELECT id
		FROM products p
		WHERE p.name ILIKE '%Leather Gloves%'
	)
)
GROUP BY order_id
ORDER BY order_id

13. We need to find out the sales by day of the week so we can see which days people are buying stuff.  So list all days of the week (Mon-Sun) and their total sales.

-- by day of week
SELECT DATE_PART('dow', completed_on) || '-' ||to_char(completed_on, 'Day'), sum(li.price * li.quantity)
FROM orders o
INNER JOIN line_items li ON li.order_id = o.id
GROUP BY 1
ORDER BY 1

-- by highest total sales desc
SELECT DATE_PART('dow', completed_on) || '-' ||to_char(completed_on, 'Day'), sum(li.price * li.quantity)
FROM orders o
INNER JOIN line_items li ON li.order_id = o.id
GROUP BY 1
ORDER BY 2 DESC

14. We need the same as 13, but the average total sale.  We want to know if bigger orders are being placed on certain days or not.

Stretches
=========
S1. Find all the descriptors and materials used in all 'gloves' products.  ie.  Durable Steel Gloves has 'steel' as the material and 'durable' as the descriptor.
S2. Find the average order total price for all the orders in the system with only one query. (without nested query)
S3. Find the number of orders for each month and display that count along with the month/year that the number of orders is for.  Sort it by most orders.  Sort it again but chronologically.

SELECT DATE_PART('year', completed_on), DATE_PART('month', completed_on),
COUNT(o.*) AS NumOfOrders
FROM orders o
INNER JOIN line_items li ON li.order_id = o.id
GROUP BY 1,2
ORDER BY 3 DESC
