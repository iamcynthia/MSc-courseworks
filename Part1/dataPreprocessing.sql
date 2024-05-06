-- Part 1.3 dataPreprocessing.sql
--
-- Submitted by: Hsin -Ju, Chan
-- 


-- Write your Data Preprocessing statements here
-- remove duplicates, inconsistencies and anomalies--------------------
-- 2013
CREATE TABLE temp2013 AS SELECT * FROM crimes2013 
GROUP BY date_reported, date_occ,time_occ,area, area_name, rd, crime_no, crime_desc, status, status_desc, image_no;

DROP TABLE crimes2013;

RENAME TABLE temp2013 TO crimes2013;  

-- update the inconsistent crime description
select crime_no, crime_desc 
from (select crime_no, crime_desc from crimes2013 group by crime_desc) AS C 
group by crime_no having count(C.crime_desc) >1;   -- show the inconsistent crime description

CREATE TABLE crime_desc_new AS select crime_no, crime_desc 
from (select crime_no, crime_desc from crimes2013 group by crime_desc) AS C 
group by crime_no;

UPDATE crimes2013 C
SET crime_desc = (SELECT crime_desc FROM crime_desc_new N WHERE C.crime_no = N.crime_no);

DROP TABLE crime_desc_new;    

-- 2014
CREATE TABLE temp2014 AS SELECT DISTINCT * from crimes2014 
GROUP BY date_reported, date_occ,time_occ,area, area_name, rd, crime_no, crime_desc, status, status_desc, image_no;

DROP TABLE crimes2014; 

RENAME TABLE temp2014 TO crimes2014; 
-- update the inconsistent crime description 
select crime_no, crime_desc 
from (select crime_no, crime_desc from crimes2014 group by crime_desc) AS C 
group by crime_no having count(C.crime_desc) >1;   -- show the inconsistent crime description

CREATE TABLE crime_desc_new1 AS select crime_no, crime_desc 
from (select crime_no, crime_desc from crimes2014 group by crime_desc) AS C 
group by crime_no;

UPDATE crimes2014 C
SET crime_desc = (SELECT crime_desc FROM crime_desc_new1 N WHERE C.crime_no = N.crime_no);

DROP TABLE crime_desc_new1;   

-- 2015
UPDATE crimes2015 SET rd = SUBSTRING(rd FROM 6);  --remove the word 'road'

-- 1.3.1--------------------------------------------------------------- 
ALTER TABLE crimes2015 
ADD date_occ TEXT AFTER date_reported;  -- Add two columns in table crimes2015
ALTER TABLE crimes2015
ADD time_occ TIME AFTER date_occ;  

UPDATE crimes2015
SET date_occ = SUBSTRING(occured,1,10), time_occ = SUBSTRING(occured FROM 12);   -- seperate date and time from colummn occured and insert into the new columns

ALTER TABLE crimes2015 DROP occured;    -- drop the original column occured

-- 1.3.2--------------------------------------------------------------- 
UPDATE crimes2013
SET time_occ = CONCAT(time_occ,'00');         -- add '00' at the end
UPDATE crimes2013
SET time_occ = CONVERT(time_occ, TIME);       -- convert the string to time
ALTER TABLE crimes2013 MODIFY time_occ TIME;  -- change the data type to TIME

UPDATE crimes2014
SET time_occ = CONCAT(time_occ,'00');
UPDATE crimes2014
SET time_occ = CONVERT(time_occ, TIME);
ALTER TABLE crimes2014 MODIFY time_occ TIME;

-- 1.3.3--------------------------------------------------------------- 
UPDATE crimes2013
SET image_no = '0'
WHERE image_no = '-1';  -- change all the strange image_no to 0

UPDATE crimes2015
SET image_no = '0'
WHERE image_no IS NULL;  -- change all the strange image_no to 0

-- 1.3.4--------------------------------------------------------------- 
UPDATE crimes2013 
SET status  = UPPER(status);    -- capitalize the column status in table crimes2013

-- 1.3.5--------------------------------------------------------------- 
UPDATE crimes2013
SET date_occ = STR_TO_DATE(date_occ, '%D %M, %Y'), date_reported = STR_TO_DATE(date_reported, '%D %M, %Y');

UPDATE crimes2014 
SET date_occ = STR_TO_DATE(date_occ, '%Y-%M-%d'), date_reported = STR_TO_DATE(date_reported, '%Y-%M-%d');

UPDATE crimes2015
SET date_occ = STR_TO_DATE(date_occ, '%m/%d/%Y'), date_reported = STR_TO_DATE(date_reported, '%m/%d/%Y');

-- 1.3.6--------------------------------------------------------------- 
create table area_new as select distinct area, area_name from crimes2015 where area_name != 'null';

UPDATE crimes2015 C SET area_name = (SELECT area_name from area_new A WHERE C.area = A.area); 

DROP TABLE area_new;
