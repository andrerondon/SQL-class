LAB - Day 1
Day 1 – Lab
Install postGres and pdAdmin4 on your laptop.
Restore the database backup sql-lab.backup.
Assignment:  Warm up
•	Select all students.  How many rows were returned?
-- 
SELECT *
FROM students
ORDER BY id
LIMIT 263

•	Select all students who’s first name starts with an A.  How many rows were returned?

SELECT *
FROM students
WHERE first_name ILIKE 'A%'
Order by first_name
LIMIT 15

•	Select all students older than 30.  How many rows were returned?

SELECT count (*)
FROM students
WHERE age > 30


•	Select the first and last registered students.  What are their names?
SELECT *
FROM students
ORDER by registration_date desc
LIMIT 1


Assignment: [Lab] Products CRUD
Using the data from this morning's lesson, write the following SQL Queries:
•	Create a product record with the following attributes:
o	name: Premium Rustic Aluminum Gloves
o	description: Extra amazing gloves
o	price: 100
o	sale_price: 75
o	remaining_quantity: 40
•	Select that product from the database by fetching the last record (fetch a single record only)
•	Using the id you fetched from the previous exercise, update the remaining_quantity of that record to become 39:
o	Delete that record using its id
•	Select the number of products in the database.

Assignment: [Lab] CRUD
Using the data from today's lesson, write the following SQL Queries:
1.	Create a student record with the following attributes: first_name: John, last_name: Smith, Age: 45, email: john@smith.com registration_date: January 1st 2016, phone_number: 778.778.7787

/*
INSERT INTO students(first_name, last_name, age, email, registration_date)
VALUES ('Gregorio', 'Watchman', '29', 'greg@watchman.com', 'January 10, 1991');

UPDATE students
SET age = 50
WHERE id = 289

DELETE FROM students
WHERE id = 289
*/
2.	Select that student from the database by fetching the last record
3.	Using the id you fetched from the previous exercise, update the age of that record to become 50
4.	Delete that record using its id

Assignment: [Lab] Selecting
Using data from this morning lesson, write the following SQL Queries:
From the students table:
1.	Select the first 10 students whose ages are between 35 and 45.


SELECT *
FROM students
WHERE age BETWEEN 25 and 35
LIMIT 10

2.	Select the third set of 10 students whose ages are more than 25 and whose first names contain `le`. The students must be ordered by their id in ascending order then first name in a descending order.


SELECT *
FROM students
WHERE age > 25 and first_name LIKE '%le%'
ORDER BY id, first_name DESC
limit 10
offset 10

3.	Select the 10 oldest students (You should ignore students with an age that is `NULL`).

SELECT *
FROM students
ORDER BY age DESC
WHERE age IS NOT NULL
limit 10

4.	Select all students with age 45 whose last names contain the letter n.

From the products table:

1.	Select all the products that have a sale price that is more than 2 lower than the regular price and display by sales price in descending order.

SELECT *
FROM products
Where price - sale_price > 2
ORDER by sale_price DESC

2.	Select all the products that have a sale price that is less than 2 lower than the regular price and has stock. Sort by the quantity on hand.

SELECT *
FROM products
Where price - sale_price > 2
ORDER by remaining_quantity < 1

3.	Select all the products priced between 25 and 50 (regular price) and have a quantity between 10-20. Show the results by quantity descending and then price ascending
Assignment: [Lab] Queries

SELECT *
FROM products
Where price between 25 and 50 OR remaining_quantity between 10 and 20
ORDER by remaining_quantity DESC


Using data from this mornings lesson, write the following SQL Queries:

For the products table:

Select the product whose stock has the most value (use sale price)
Select the most expensive product whose price is between 25 and 50 with remaining quantity
Select all products on sale with remaining quantity ordered by their price and then their name
Select the second set 20 results based on the previous query
Find the average price of all products
Find the average sale_price of all products that are on sale
Find the average price of all products that are on sale with remaining quantity
Update all the products whose name contains `paper` (case insensitive) to increase the quantity by 3
Update all the products whose name contains `paper` or `steel` to have a remaining quantity of a random number between 5 and 25 (SELECT floor(random() * 10 + 1)::int;) will return a random number between 1-10
Select the second set of 10 cheapest products (by `price` or `sale_price`) with remaining quantity
Build a query that groups the products by their sale price and show the number of products in that price and the sum of remaining quantity. Label the count `product_count`
[stretch] Update the most expensive product to have double its quantity in a single query
Assignment: [Lab] Aggregate Functions
Using the data from this morning lesson, write the following SQL Queries:
From the students table:
•	Find the number of students named 'Elinore'.
•	List the `first_name`s that occur more than once in students, with the number occurrences of that name.
•	Refine the above query to list the 20 most common first_names among students, in order first of how common they are, and alphabetically when names have the same count.

From the products table:
•	Find the most expensive product.
•	Find the cheapest product that is on sale.
•	Find the total value of all inventory in stock (use sale price).

STRETCHES
=========
Select all students whose first name starts with J and their age is over 60 or their last name starts with N and their age is less than 25.  Sort results by first name and then age in reverse order.

SELECT *
FROM students
WHERE (first_name iLIKE 'j%' AND age > 60) or (last_name iLIKE 'n%' AND age < 25)
order by first_name, age desc


2.  Select all students whose first name starts with J and their age is over 60 or their  age is less than 25.  Sort results by last name and then age in reverse order.

SELECT *
FROM students
WHERE (first_name iLIKE 'j%' AND age > 60) or (last_name iLIKE 'n%' AND age < 25)
order by first_name, age desc


3.  Select all students who are 36 or 74 and their first name starts with R.

SELECT *
FROM students
WHERE (first_name iLIKE 'r%') AND (age = 25 or age 74)


4.  Select all students in their 20s, but only return their first name, last name, age, and phone number.

SELECT first_name, last_name, age, phone_number
FROM students
where age between 20 and 29

5.  Same as #4, but only return full name ([first name] [last name]), age, phone number.

SELECT first_name ||' ' || last_name as Name
FROM students
where age between 20 and 29

6.  Same as #5, but label the first column "Full Name".

SELECT first_name ||' ' || last_name as Name
FROM students
where age between 20 and 29

==DAY 1 Labs STOP HERE








Assignment: [Lab] Aggregate Functions
Using the data from this morning lesson, write the following SQL Queries:
From the students table:
•	Find the number of students named 'Elinore'.
•	List the `first_name`s that occur more than once in students, with the number occurrences of that name.
•	Refine the above query to list the 20 most common first_names among students, in order first of how common they are, and alphabetically when names have the same count.

From the products table:
•	Find the most expensive product.
•	Find the cheapest product that is on sale.
•	Find the total value of all inventory in stock (use sale price).


UPDATE students
SET email = Im_Jugraj_send_me_to_india