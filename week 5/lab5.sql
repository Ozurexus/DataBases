 
-- 1
SELECT  MAX(enrolment), MIN(enrolment) 
FROM (select sec_id, count(*) 
	  AS enrolment 
	  FROM takes 
	  GROUP BY sec_id, semester, year, course_id 
	  ORDER BY sec_id) 
	  AS enrolment;
	  
-- 2
SELECT sec_id, semester, year, course_id a
FROM (
	SELECT MAX(count)
	  FROM(
		  SELECT COUNT(id), sec_id, semester, year, course_id
		  FROM takes 
		  GROUP BY sec_id, semester, year, course_id) 
	AS counter
		  WHERE count!=0) as maximum
	  INNER JOIN(
		  SELECT COUNT(id), sec_id, semester, year, course_id
		  FROM takes 
		  GROUP BY sec_id, semester, year, course_id) 
		  AS counter
      ON counter.count = maximum.max;
	  
-- 3

-- 4
SELECT * FROM course WHERE course_id LIKE 'CS-1%';

-- 5
SELECT name FROM instructor WHERE dept_name='Biology';

-- 6
SELECT sec_id, count(*) AS enrolment 
FROM takes WHERE semester = 'Fall' and year = '2022' 
GROUP BY sec_id 
ORDER BY sec_id;

-- 7
SELECT  MAX(enrolment) 
FROM (
	SELECT sec_id, count(*) 
	AS enrolment
FROM takes WHERE semester='Fall' and year='2022'
GROUP BY sec_id, semester, year, course_id 
ORDER BY sec_id) AS enrolment;
