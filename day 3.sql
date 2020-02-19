--Find the title of all projects owned by the student with an id of 2.

SELECT title
FROM projects
WHERE student_id = 2


--Get all student ids and scores for the course with an id of 1.
SELECT student_id, score
FROM enrolments
WHERE course_id = 1

--Cross join the students table with the projects table
SELECT *
FROM students
CROSS JOIN projects

--Get all students with their associated projects in the same query.
--Order the results by the student's first_name.

SELECT *
FROM students s
INNER JOIN projects p ON s.id = p.student_id
ORDER BY s.first_name

--SELECT students.first_name, projects.title
--FROM students
--INNER JOIN projects  ON students.id = projects.student_id
--ORDER BY s.first_name

--------------------------------------


--Select all the students  that have projects and show
-- the project name in one query ordered by the project name.

SELECT pr.title
FROM students AS st
INNER JOIN projects AS pr ON pr.student_id = st.id
ORDER BY 1


--List all the students enrolled in the course whose title contains 'hybrid matrix'

SELECT s.first_name, s.last_name, e.score, c.*
FROM students s
INNER JOIN enrolments e ON e.student_id = s.id
INNER JOIN courses c ON e.course_id = c.id
WHERE c.title ILIKE '%hybrid matrix%'
ORDER BY score DESC

--Find all courses that have at least one student whose name begins with 'Re'.
--Show the course title, student names and their scores.

SELECT c.title, s.first_name, s.last_name, e.score
FROM courses c
INNER JOIN enrolments e ON e.course_id = c.id
INNER JOIN students s ON s.id = e.student_id

WHERE c.id IN
(
	SELECT c.id
	FROM courses c
	INNER JOIN enrolments e ON e.course_id = c.id
	INNER JOIN students s ON e.student_id = s.id
	WHERE e.student_id IN (
		SELECT s.id
		FROM students s
		WHERE first_name ILIKE 're%'
		)
)
ORDER BY c.title, e.score DESC, s.first_name



--List all the students and their projects.
-- Students with no projects must be included.

SELECT s.*, p.title
FROM students s
LEFT JOIN projects p ON p.student_id = s.id



--Select all the students who don't have a project.

SELECT * 
FROM students s
LEFT JOIN projects p ON p.student_id = s.id
WHERE p.id IS NULL

--Select all students   x
-- grouping them by their ages  x
-- while aggregating their first_names into an array  x
-- and counting the number of occurrences and x
-- ordering by them.

SELECT age, COUNT(*) AS NumOfOccurrences, STRING_AGG ( first_name, ',' ORDER BY first_name) AS NameList
FROM students
GROUP BY age
ORDER BY 2

--List the average score for each course   x
-- with higher averages on top             x
-- displaying the course title and score average.
SELECT ROUND(AVG(score)::numeric, 2) AS AvgScore, c.title
FROM enrolments e
INNER JOIN courses c ON e.course_id = c.id
GROUP BY c.title
ORDER BY AvgScore DESC




Exercise 1:
--List courses ordered by the last registered student showing the course title
--and the registration date.

SELECT *
FROM
(
	SELECT title, MAX(registration_date) AS Last_registered_student_date
	FROM courses c
	INNER JOIN enrolments e ON e.course_id = c.id
	INNER JOIN students s ON e.student_id = s.id
	GROUP BY title
) x
ORDER BY 2 DESC


Exercise 2:

--Select all students with their project titles, course titles and scores in one query.
--You may need use variations aggregations.

SELECT s.first_name || ' ' || s.last_name AS full_name, p.title AS project_title, c.title AS course_title, e.score AS course_score
FROM students s
LEFT JOIN projects p ON p.student_id = s.id
LEFT JOIN enrolments e ON e.student_id = s.id
LEFT JOIN courses c ON e.course_id = c.id
ORDER BY 1, 2, 3

--Exercise 3: (hint: subquery)
--List all courses with at least 5 enrolled students.
--Show the number of enrolled students and course title.
--Order by the number enrolled students.

SELECT *
FROM
(
	SELECT c.title, COUNT(e.*) AS NumOfStudents
	FROM courses c
	INNER JOIN enrolments e ON e.course_id = c.id
	GROUP BY c.title
) x
WHERE NumOfStudents > 4
ORDER BY 2 DESC
------------ 2nd solution

SELECT * FROM (
    SELECT c.title AS course_title , COUNT(s.*) AS noOfStudents
    FROM students s
    INNER JOIN enrolments e ON e.student_id = s.id
    INNER JOIN courses c ON c.id = e.course_id
    GROUP BY c.title
) x
WHERE noOfStudents > 4
ORDER BY noOfStudents DESC


--Exercise 4:
--Calculate the average score of all classes.
--Show only classes with a average score lower than 60.
--Display the course name, course id, average score and enrolment count.

SELECT c.title, c.id, average_score, COUNT(x.*) AS enrolment_count
FROM
(
	SELECT course_id, ROUND(AVG(score)::numeric, 2) AS average_score
	FROM enrolments e
	GROUP BY course_id
) x
INNER JOIN courses c ON x.course_id = c.id
WHERE average_score < 60
GROUP BY c.id, c.title, average_score
ORDER BY average_score, enrolment_count DESC



