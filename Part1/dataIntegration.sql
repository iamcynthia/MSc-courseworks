-- Part 1.4 dataIntegration.sql
--
-- Submitted by: Hsin -Ju, Chan
-- 


--  Write your Data Integration statements here
CREATE TABLE crimes AS SELECT * FROM crimes2013 UNION SELECT * FROM crimes2014 UNION SELECT * FROM crimes2015;


ALTER TABLE crimes
ADD status_no INT AFTER crime_desc;
ALTER TABLE crimes MODIFY crime_no INT;
ALTER TABLE crimes MODIFY date_reported TEXT;
ALTER TABLE crimes MODIFY rd INT;
ALTER TABLE crimes MODIFY date_occ TEXT;
ALTER TABLE crimes MODIFY area_name TEXT;
ALTER TABLE crimes MODIFY crime_desc TEXT;
ALTER TABLE crimes MODIFY status TEXT; 
ALTER TABLE crimes MODIFY status_desc TEXT;

UPDATE crimes
SET status_no ='1' WHERE status = 'AA';
UPDATE crimes
SET status_no ='2' WHERE status = 'AO';
UPDATE crimes
SET status_no ='3' WHERE status = 'IC';
UPDATE crimes
SET status_no ='4' WHERE status = 'JA';
UPDATE crimes
SET status_no ='5' WHERE status = 'JO';
UPDATE crimes
SET status_no ='6' WHERE status = 'UNK';