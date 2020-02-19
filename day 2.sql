--example of a subquery

UPDATE students
SET registration_date = 'February 18, 2020'
WHERE id IN (
	SELECT id
	FROM students
	WHERE first_name = 'Elinore'
)

--SELECT * from students where first_name = 'Elinore';

--example of a Transaction
BEGIN TRANSACTION;

SELECT * FROM students WHERE id = 7;

UPDATE students SET first_name = 'Blahblah' WHERE id = 7;

SELECT * FROM students WHERE id = 7;

--COMMIT TRANSACTION
--ROLLBACK TRANSACTION


Lab 1:  Find the Count of students whos first name starts with "L"
--28
SELECT COUNT(*)
FROM students
WHERE first_name ILIKE 'L%'

DEMO:  Get the number of students who are more than 25 years of age
SELECT COUNT(*)
FROM students
WHERE age > 25

Lab 2:  Find the sum of students ages whos first name starts with "L"


Lab: Find out the average age of students who registered after March 1st 2018
SELECT AVG(age)
FROM students
WHERE registration_date > 'March 1, 2018'

Exercise: Write a query with the maximum, minimum, average and total age of all students
SELECT MAX(age) AS max_age,
MIN(age) AS min_age,
ROUND(AVG(age), 2) AS average_age,
SUM(age) AS total_age
FROM students

--COUNT and GROUP BY example
SELECT first_name, count(*) AS NumberOfStudents
FROM students
GROUP BY first_name
ORDER BY 2 DESC

Exercise:  Find out the age that is the most common for all students.  Can return more than one age if needed
SELECT age, count(*) AS NumberOfStudentsWithThatAge
FROM students
GROUP BY age
ORDER BY 2 DESC

-------------------

DAY 2 LAB

Practice using Backup/Restore
Follow the following website to practice taking a backup and restoring from it.
https://o7planning.org/en/11913/backup-and-restore-postgres-database-with-pgadmin

Assignment: [Lab] Queries Aggregates.
Using data from this mornings lesson, write the following SQL Queries:
For the products table:  (A product is on sale when the sale_price = price)

1. Select the product whose stock has the most value (use sale price)

SELECT sale_price * remaining_quantity AS stock_value, *
FROM products
order by sale_price * remaining_quantity Desc
limit 1


2. Select the most expensive product whose price is between 25 and 50 with, remaining quantity

SELECT *
FROM products
where price BETWEEN 25 and 50
ORDER by remaining_quantity > 0 Desc
limit 1

3. Select all products on sale with remaining quantity ordered by their price and then their name

SELECT *
FROM products
where sale_price = price and remaining_quantity > 0
ORDER by price, name


4. Select the second set 20 results based on the previous query

SELECT *
FROM products
where sale_price = price and remaining_quantity > 1
ORDER by price, name
limit 20
offset 20





5. Find the average price of all products.
    STRETCH - Only show 2 decimal places.

SELECT round (AVG(price) :: numeric, 2) 
FROM products





6. Find the average sale_price of all products that are on sale

SELECT AVG(sale_price) 
FROM products
where sale_price = price



7. Find the average price of all products that are on sale with remaining quantity

SELECT AVG(sale_price) 
FROM products
where sale_price = price and remaining_quantity > 0



8. Update all the products whose name contains `paper` (case insensitive) to increase the quantity by 3

BEGIN TRANSACTION;
UPDATE products
SET remaining_quantity = remaining_quantity + 3
WHERE name ILIKE '%paper%';
SELECT remaining_quantity FROM products WHERE id = 113;  --SHOULD BE 10
--COMMIT TRANSACTION
--ROLLBACK TRANSACTION


9. Update all the products whose name contains `paper` or `steel` to have a remaining quantity of a random number between 5 and 25 (SELECT floor(random() * 10 + 1)::int;) will return a random number between 1-10

select * from products where name ilike '%paper%' or name ilike '%steel%'

update products
set remaining_quantity = floor(random() * 20 + 5)::int
where  name ilike '%paper%' or name ilike '%steel%'




10. Select the second set of 10 cheapest products (by `price` or `sale_price`) with remaining quantity

SELECT *
FROM products
WHERE sale_price = price AND remaining_quantity > 0
LIMIT 10
OFFSET 10


11. Build a query that groups the products by their sale price and show the number of products in that price and the sum of remaining quantity. Label the count `product_count`
[stretch] Update the most expensive product to have double its quantity in a single query

SELECT sale_price, SUM(remaining_quantity) AS product_count
FROM products
GROUP BY sale_price
ORDER BY 2 DESC

[stretch] Update the most expensive product (use 'price') to have double its quantity in a single query
Jugraj
select * from products order by price desc limit 1

update products set remaining_quantity = remaining_quantity * 2
where id = (select id from products order by price desc limit 1)


12.	Find the number of students named 'Elinore'.

select *
From students
WHERE first_name = 'Elinore'

13.	List the `first_name`s that occur more than once in students, with the number occurrences of that name.

SELECT first_name, COUNT(*) AS NumofOcc
FROM STUDENTS
GROUP BY first_name
HAVING COUNT(*) > 1

14.	Refine the above query to list the 20 most common first_names among students, in order first of how common they are, and alphabetically when names have the same count.

SELECT first_name, COUNT(*) AS NumofOcc
FROM STUDENTS
GROUP BY first_name
HAVING COUNT(*) > 1
order by 2 desc, first_name
limit 20



From the products table:
15.	Find the most expensive product.

select *
from products
order by sale_price DEsc
limit 1

16. Find the cheapest product that is on sale.

SELECT *
FROM products
WHERE sale_price = price
ORDER BY sale_price
LIMIT 1


17. Find the total value of all inventory in stock (use sale price).


SELECT SUM(remaining_quantity * sale_price) AS total_value
FROM products