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
