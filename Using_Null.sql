--Table #1: teacher(id,	dept,	name,	phone,	mobile)
--Table #2: dept(id, name)

--1. List the teachers who have NULL for their department.

SELECT name
 FROM teacher
 WHERE dept IS NULL;
 
--2. The inner join that misses the teachers with no department and the departments with no teacher.

SELECT teacher.name, dept.name
 FROM teacher 
  JOIN dept ON (teacher.dept=dept.id);
  
--3. Use a different JOIN so that all teachers are listed.

SELECT teacher.name, dept.name
 FROM teacher 
  LEFT JOIN dept ON (teacher.dept=dept.id);
  
--4. Use a different JOIN so that all departments are listed.

SELECT teacher.name, dept.name
 FROM teacher 
  RIGHT JOIN dept ON (teacher.dept=dept.id);
