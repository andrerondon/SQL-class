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

--Generating the ice cream survey crosstab

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

You can update or insert data in the underlying table that a view queries
as long as the view meets certain conditions.
One requirement is that the view must reference a single table.
If the view’s query joins tables, then you can’t perform inserts or updates directly.
Also, the view’s query can’t contain DISTINCT, GROUP BY, or other clauses.
(See a complete list of restrictions at https://www.postgresql.org/docs/current/static/sql-createview.html.)

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
