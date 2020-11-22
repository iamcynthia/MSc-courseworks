-- view.sql
--
-- Submitted by: Hsin-Ju Chan
-- 


-- add your CREATE VIEW statement here
CREATE VIEW Pro (ongoingProjects) AS SELECT id 
FROM project 
WHERE endDate > CURDATE() 
WITH CHECK OPTION;

SELECT * FROM Pro;