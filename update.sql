--  update.sql
--
-- Submitted by: Hsin-Ju Chan
-- 


-- add your statements here
update supervises S JOIN 
(SELECT student_id, SUM(type) AS total FROM supervises GROUP BY student_id) T 
ON S.student_id = T.student_id 
SET type = 1 
WHERE total = 2;