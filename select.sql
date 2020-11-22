-- select.sql
--
-- Submitted by: Hsin-Ju Chan
-- 


-- add your SELECT statements here



-- 4.1 Research Involvement.

SELECT lname, fname 
FROM academic WHERE id IN 
(SELECT academic_id FROM project P JOIN 
collaboratesIn C ON P.id = C.project_id 
WHERE endDate > CURDATE());

-- 4.2  Male Supervision Report.

SELECT lname, fname, COUNT(student_id) AS male_first_supervised
FROM supervises S JOIN phdStudent P ON S.student_id = P.id 
WHERE gender = 'M' AND type = 1 
GROUP BY supervisor_id;

-- 4.3 Number 1 and 2 by Research Income.

SELECT lname, fname, email, SUM(budget) AS ResearchIncome 
FROM academic A JOIN project P ON A.id = P.coordinator_id 
GROUP BY coordinator_id 
ORDER BY ResearchIncome DESC LIMIT 2;

-- 4.4 Most Overloaded Academic.

SELECT academic_id, SUM(time) AS loading
FROM collaboratesIn C JOIN project P ON C.project_id = P.id 
WHERE endDate > CURDATE() 
GROUP BY academic_id 
HAVING SUM(time)>= ALL(SELECT SUM(time)
FROM collaboratesIn C JOIN project P ON C.project_id = P.id 
WHERE endDate > CURDATE() 
GROUP BY academic_id);
