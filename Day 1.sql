SELECT *
FROM table
WHERE condition
ORDER BY column DESC
LIMIT 10
OFFSET 20


SELECT *
FROM students
WHERE registration_date >= 'January 31, 2018' AND registration_date < 'March 1, 2018'

SELECT MIN(registration_date), MAX(registration_date)
FROM students

SELECT registration_date
FROM students
ORDER BY registration_date

--Select all students whose ids are more than 100 and less than 200

SELECT *
FROM students
WHERE id > 100 AND id < 200
ORDER BY id

--Select all students whose ages are null or less than 20
SELECT *
FROM students
WHERE age IS NULL OR age < 20

--Find all students whose first names start with Jo (case sensitive)
SELECT *
FROM students
WHERE first_name LIKE 'Jo%'


-- same but insensitive
SELECT *
FROM students
WHERE first_name iLIKE 'Jo%'

--Find all students whose first names end with ‘on’ (case insensitive)
SELECT *
FROM students
WHERE first_name iLIKE '%on'

--Select all students whose first names or last names contain ‘nn’
SELECT *
FROM students
WHERE first_name iLIKE '%nn%' OR last_name iLIKE '%nn%'

--Select all students whose ages are between 25 and 35

SELECT *
FROM students
WHERE age BETWEEN 25 and 35

--Select all students that have registered between July 14, 2019 and July 28, 2019
SELECT *
FROM students
WHERE registration_date BETWEEN 'July 14, 2019' AND 'July 28, 2019'

--Select all students that whose first name is Daphnee, Norma, or Rene
SELECT *
FROM students
WHERE first_name IN ('Daphnee', 'Norma', 'Rene')

/* This is the same as....
first_name = 'Daphnee'
OR first_name = 'Norma'
OR first = 'Rene'

But it takes less typing if the list is long
*/

--Select all students whose age is one of 23, 26, or 29.
SELECT *
FROM students
WHERE age IN (23, 26, 29)

-- order by multiple fields
SELECT *
FROM students
WHERE first_name IN ('Daphnee', 'Norma', 'Rene')
ORDER BY first_name, last_name DESC

--Find students whose names begin with ‘no’ ordered by their first name then age in descending order.
SELECT *
FROM students
WHERE first_name iLIKE 'no%'
ORDER BY first_name, age DESC;

--Find students whose ages are more than 30 ordered by their first names then last names
SELECT *
FROM students
WHERE age > 30
ORDER BY first_name, last_name


--select first 10 students
SELECT *
FROM students
LIMIT 10

--Select the first 10 students whose first names start with `ma` (case insensitive)
SELECT *
FROM students
WHERE first_name ILIKE 'MA%'
ORDER BY id
LIMIT 10

--Selecting the third set of 10 students
SELECT *
FROM students
ORDER BY id
LIMIT 10
OFFSET 20

-- Select the second set of 20 students whose ages are more than 25 and are ordered ascending
SELECT *
FROM students
WHERE age > 25
ORDER BY age
LIMIT 20
OFFSET 20

LAB - Day 1
Day 1 – Lab
Install postGres and pdAdmin4 on your laptop.
Restore the database backup sql-lab.backup.
Assignment:  Warm up
•	Select all students.  How many rows were returned?
•	Select all students who’s first name starts with an A.  How many rows were returned?
•	Select all students older than 30.  How many rows were returned?
•	Select the first and last registered students.  What are their names?

SELECT *
FROM students
ORDER BY registration_date
LIMIT 1

Assignment: [Lab] Products CRUD
Using the data from this mornings lesson, write the following SQL Queries:
•	Create a product record with the following attributes:
  o	name: Premium Rustic Aluminum Gloves [your name]
  o	description: Extra amazing gloves
  o	price: 100
  o	sale_price: 75
  o	remaining_quantity: 40
•	Select that product from the database by fetching by the product name (fetch a single record only)
•	Using the id you fetched from the previous exercise, update the remaining_quantity of that record to become 39:
o	Delete that record using its id
•	Select the number of products in the database.

Assignment: [Lab] CRUD
Using the data from today's lesson, write the following SQL Queries:
1.	Create a student record (real or ficticious) with the following attributes: first_name, last_name, Age, email, registration_date: (Today's date), phone_number

/*
INSERT INTO students(first_name, last_name, age, email, registration_date)
VALUES ('Gregorio', 'Watchman', '29', 'greg@watchman.com', 'January 10, 1991');

UPDATE students
SET age = 50
WHERE id = 289

DELETE FROM students
WHERE id = 289
*/
2.	Select that student from the database by searching on both your first and last name.
3.	Using the id you fetched from the previous exercise, update the age of that record to become 50
4.	Delete that record using its id

Assignment: [Lab] Selecting
Using data from this mornings lesson, write the following SQL Queries:
From the students table:
1.	Select the first 10 students whose ages are between 35 and 45.
2.	Select the second set of 10 students whose ages are more than 25 and whose first names contain `le`. The students must be ordered by their id in ascending order then first name in a descending order.
3.	Select the 10 oldest students (You should ignore students with an age that is `NULL`).
4.	Select all students with age 45 whose last names contain the letter n.

From the products table:
1.	Select all the products that have a sale price that is more than 2 lower than the regular price and display by sales price in descending order.
SELECT price - sale_price, *
FROM products
Where price - sale_price > 2
ORDER by remaining_quantity < 1

2.	Select all the products that have a sale price that is less than 2 lower than the regular price and has stock. Sort by the quantity on hand.
3.	Select all the products priced between 25 and 50 (regular price) and have a quantity between 10-20. Show the results by quantity descending and then price ascending



STRETCHES
=========
1.  Select all students whose first name starts with J and their age is over 60 or their last name starts with N and their age is less than 25.  Sort results by last name and then age in reverse order.

2.  Select all students whose first name starts with J and their age is over 60 or their  age is less than 25.  Sort results by last name and then age in reverse order.
select * from students
where first_name ilike 'j%'
  and age
not between 25 and 60
ORDER BY last_name, age DESC

SELECT *
FROM students
WHERE first_name iLIKE 'j%' AND (age > 60 OR age < 25)
ORDER BY last_name, age DESC

3.  Select all students who are 36 or 74 and their first name starts with R.

4.  Select all students in their 20s, but only return their first name, last name, age, and phone number.

5.  Same as #4, but only return full name ([first name] [last name]), age, phone number.

6.  Same as #5, but label the first column "Full Name".


==DAY 1 Labs STOP HERE


Assignment: [Lab] Queries Aggregates.
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
Using the data from this mornings lesson, write the following SQL Queries:
From the students table:
•	Find the number of students named 'Elinore'.
•	List the `first_name`s that occur more than once in students, with the number occurrences of that name.
•	Refine the above query to list the 20 most common first_names among students, in order first of how common they are, and alphabetically when names have the same count.

From the products table:
•	Find the most expensive product.
•	Find the cheapest product that is on sale.
•	Find the total value of all inventory in stock (use sale price).
