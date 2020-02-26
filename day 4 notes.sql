-- Cross tabulations
-- Install the crosstab() function via the tablefunc module

CREATE EXTENSION tablefunc;

-- Creating and filling the ice_cream_survey table

CREATE TABLE ice_cream_survey (
    response_id integer PRIMARY KEY,
    office varchar(20),
    flavor varchar(20)
);

-- The following is an example of a query to import data,
-- but we'll be using pgAdmin4's GUI to do so.
COPY ice_cream_survey
FROM 'C:\YourDirectory\ice_cream_survey.csv'
WITH (FORMAT CSV, HEADER);

-- Generating the ice cream survey crosstab
-- Use DAy 4 question S3 as base to show crosstab

SELECT *
FROM crosstab('SELECT office,
                      flavor,
                      count(*)
               FROM ice_cream_survey
               GROUP BY office, flavor
               ORDER BY office',

              'SELECT flavor
               FROM ice_cream_survey
               GROUP BY flavor
               ORDER BY flavor')

AS (office varchar(20),
    chocolate bigint,
    strawberry bigint,
    vanilla bigint);

--VIEWS
Views are especially useful because they allow you to:
• Avoid duplicate effort by letting you write a query once and access the results when needed
• Reduce complexity for yourself or other database users by showing only columns relevant to your needs
• Provide security by limiting access to only certain columns in a table

--Using Views to simplify your queries
CREATE OR REPLACE VIEW students_under_21 AS
  SELECT id, first_name, last_name, email, phone_number, age, registration_date
  FROM students
WHERE age < 21;

--create a total column in the line items table to save us calculating it
CREATE OR REPLACE VIEW line_items_total AS
  SELECT id, product_id, order_id, price, quantity, price * quantity as line_total
  FROM line_items
;

You can update or insert data in the underlying table that a view queries
as long as the view meets certain conditions.
One requirement is that the view must reference a single table.
If the view’s query joins tables, then you can’t perform inserts or updates directly.
Also, the view’s query can’t contain DISTINCT, GROUP BY, or other clauses.
(See a complete list of restrictions at

EXERCISE 1 :  Create a view to show which products have 5 or less remaining_quantity.
 Call your view, products_to_reorder

DEMO : Create a view that adds the order total along with the order information.  (completed_on)




--FUNCTIONS
--Functions allow you to declare a simple or complex set of steps to be
--done each time to save you time from writing it each time.

--SUM(), UPPER(), AVG() are examples of functions.

CREATE OR REPLACE FUNCTION full_name(first_name varchar(15), last_name varchar(15))
RETURNS varchar(31) AS
'SELECT first_name || '' '' || last_name;'
LANGUAGE SQL
IMMUTABLE
RETURNS NULL ON NULL INPUT;

SELECT full_name(first_name, last_name), *
FROM students

CREATE OR REPLACE FUNCTION percent_change(new_value numeric, old_value numeric,
decimal_places integer DEFAULT 1) RETURNS numeric AS
'SELECT round(
((new_value - old_value) / old_value) * 100, decimal_places
);'
LANGUAGE SQL
IMMUTABLE
RETURNS NULL ON NULL INPUT;

TRIGGERS - Just be aware they are there for your use.

CREATE OR REPLACE FUNCTION log_student_created_on()
  RETURNS trigger AS
$BODY$
BEGIN
   UPDATE students SET created_on = NOW() WHERE id = NEW.id
/*
   IF NEW.last_name <> OLD.last_name THEN
       INSERT INTO employee_audits(employee_id,last_name,changed_on)
       VALUES(OLD.id,OLD.last_name,now());
   END IF;
*/
   RETURN NEW;
END;
$BODY$


--Other functions/logic available to users

--CASE
SELECT
	CASE
		WHEN age < 21 THEN 'Minor'
		WHEN age BETWEEN 21 and 35 THEN 'Adult'
		WHEN age > 65 THEN 'Grandpa'
		ELSE 'getting up there'
	END AS Demographic
, *
FROM students

Exercise - Create a view that has all product columns plus AveragePriceSoldFor

AveragePriceSoldFor = li.price average weighted by quantity .

1. create the view, add the new column which returns 10.
2. work on the logic to return the actual value.

youll want to use something similiar to below in your logic.
ROUND((SUM(price * quantity) / SUM (quantity))::numeric, 2)

CREATE OR REPLACE view products_with_avg_price_sold_for
AS

	SELECT p.id, name, p.price, sale_price, remaining_quantity,
	ROUND((SUM(li.price * li.quantity) / SUM (li.quantity))::numeric, 2) AS AveragePriceSoldFor
	FROM products p
	INNER JOIN line_items li ON li.product_id = p.id
	GROUP BY p.id, name, p.price, sale_price, remaining_quantity

NOTE:  Postgres does allow you to put Order BY in the view. M$SQL does not.

SELECT * from products_with_avg_price_sold_for
WHERE sale_price > averagepricesoldfor

Exercise - Create a query that has all the student columns plus FizzBuzz
The value of FizzBuzz should be as follows:
1.  If the age is a multiple of 3, it should be Fizz
2.  If the age is a multiple of 5, it should be Buzz
3.  If the age is a multiple of 3 and 5, it should be FizzBuzz
4.  Otherwise, just put in the age.

SELECT
	CASE
		WHEN MOD(age,15) = 0 THEN 'FizzBuzz'
		WHEN MOD(age, 3) = 0 THEN 'Fizz'
		WHEN MOD(age, 5) = 0 THEN 'Buzz'
		ELSE age::varchar(3)
	END AS FizzBuzz
, *
FROM students

Part 2 - Create a view called StudentsFizzBuzz with the query from Part 1 using the GUI

Part 3 - Export all rows from StudentsFizzBuzz to a csv file.  Use the following code snippet to
assist you.

COPY (SELECT
	CASE
		WHEN MOD(age,15) = 0 THEN 'FizzBuzz'
		WHEN MOD(age, 3) = 0 THEN 'Fizz'
		WHEN MOD(age, 5) = 0 THEN 'Buzz'
		ELSE age::varchar(3)
	END AS FizzBuzz
, *
FROM students)
TO '/Users/Greg/codecore/Teaching/WADD201911/fizzbuzz.csv'
WITH CSV HEADER;

Lecture:  Vaccuum
