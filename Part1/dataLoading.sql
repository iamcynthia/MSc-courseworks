-- Part 1.2 dataLoading.sql
--
-- Submitted by: Hsin -Ju, Chan
-- 


-- Part 1.2.1 Table Creation
CREATE TABLE crimes2013( 
dr_no INT(11) DEFAULT NULL,
date_reported TEXT, 
date_occ TEXT,
time_occ TEXT,
area INT(11) DEFAULT NULL,
area_name TEXT,
rd TEXT,
crime_no INT(11) DEFAULT NULL,
crime_desc TEXT,
status TEXT,
status_desc TEXT,
image_no INT(11) DEFAULT NULL,
PRIMARY KEY (dr_no));

CREATE TABLE crimes2014(
dr_no INT(11),
date_reported TEXT,
date_occ TEXT,
time_occ TEXT,
area TEXT,
area_name TEXT,
rd TEXT,
crime_no TEXT,
crime_desc TEXT,
status TEXT,
status_desc TEXT,
image_no TEXT);

-- Part 1.2.1 Data Load
LOAD DATA LOCAL INFILE "./db/crimes2013.txt" INTO TABLE crimes2013
FIELDS TERMINATED BY "\t" ENCLOSED BY "'"
LINES TERMINATED BY "\n"
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE './db/crimes2014.csv' INTO TABLE crimes2014
FIELDS TERMINATED BY ';' ENCLOSED BY "'"
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@date_reported, @dr_no, @date_occ, @time_occ, @area, @area_name, @rd, @crime_no, @crime_desc, @status, @status_desc, @image_no)
SET dr_no = @dr_no,
date_reported = @date_reported,
date_occ = @date_occ,
time_occ = @time_occ,
area = @area,
area_name = @area_name,
rd = @rd,
crime_no = @crime_no,
crime_desc = @crime_desc,
status = @status,
status_desc = @status_desc,
image_no = @image_no;




