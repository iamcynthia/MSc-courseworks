-- Part 1.6 delete.sql
--
-- Submitted by: Hsin-Ju Chan
-- 
-- 


-- add your statements here
DELETE FROM phdStudent WHERE id IN (SELECT student_id FROM supervises GROUP BY student_id Having SUM(type) = 1); 