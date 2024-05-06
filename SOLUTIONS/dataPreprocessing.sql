-- Part 1.3 dataPreprocessing.sql
--
-- Submitted by: 
-- Student Number 


-- Write your Data Preprocessing statements here

-- ----------------------------------------------------------------------------
-- REMOVE DUPLICATE ENTRIES FROM crimes2014

-- Create a new table to hold the distinct rows from crimes2014.
CREATE TABLE new_crimes2014 (
    date_reported VARCHAR(20),
    dr_no INT(9),
    date_occ VARCHAR(20),
    time_occ VARCHAR(5),
    area INT(2),
    area_name VARCHAR(50),
    rd INT(4),
    crime_no INT(3),
    crime_desc VARCHAR(255),
    status VARCHAR(5),
    status_desc VARCHAR(50),
    image_no INT(3)
);

-- Load distinct rows from crimes2014 into the new table.
INSERT INTO new_crimes2014(date_reported, dr_no, date_occ, time_occ, area, 
                            area_name, rd, crime_no, crime_desc, status, 
                            status_desc, image_no)
SELECT DISTINCT date_reported, dr_no, date_occ, time_occ, area, area_name, rd,
                    crime_no, crime_desc, status, status_desc, image_no
FROM crimes2014;

-- Drop the old crimes2014 table.
DROP TABLE crimes2014;

-- Rename the new table to crimes2014.
RENAME TABLE new_crimes2014 TO crimes2014;


-- ----------------------------------------------------------------------------
-- CONVERSION OF DATES AND TIMES INTO CONSISTENT DATETIME VALUES
--
-- This is a fairly long piece of preprocessing. As such the changes to each
-- table are listed separately. The dates and times of occurences are moved to
-- a new column named "occured" with the DATETIME datatype for the crimes2013
-- and crimes2014 tables. The crimes2015 table already has this column but it
-- is not the DATETIME datatype, thus it is converted to DATETIME. The
-- date_reported column is converted to the DATETIME datatype for all
-- three tables.

-- --------------------
-- CHANGES TO THE crimes2015 TABLE
-- 
-- Convert the values of the occured column to DATETIME and then convert the
-- datatype of the column.
UPDATE crimes2015
SET occured = (
    STR_TO_DATE(occured, '%m/%d/%Y %H:%i:%s')
);

ALTER TABLE crimes2015
MODIFY occured DATETIME;

-- Convert the values of the date_reported column to DATETIME and then convert
-- the datatype of the column.
UPDATE crimes2015
SET date_reported = (
    STR_TO_DATE(date_reported, '%m/%d/%Y')
);

ALTER TABLE crimes2015
MODIFY date_reported DATETIME;

-- --------------------
-- CHANGES TO THE crimes2014 TABLE

-- Alter the crimes2014 to have an occured column with DATETIME datatype.
ALTER TABLE crimes2014
ADD occured DATETIME;

-- Reformat the time_occ column to have an hh:mm or h:mm format to facilitate
-- string conversion to DATETIME datatype.
UPDATE crimes2014
SET time_occ = (
    INSERT(time_occ, 3, 0, ':')
    )
WHERE LENGTH(time_occ) = 4;

UPDATE crimes2014
SET time_occ = (
    INSERT(time_occ, 2, 0, ':')
    )
WHERE LENGTH(time_occ) = 3;

UPDATE crimes2014
SET time_occ = (
    INSERT(time_occ, 1, 0, '0:')
    )
WHERE LENGTH(time_occ) = 2;

UPDATE crimes2014
SET time_occ = (
    INSERT(time_occ, 1, 0, '0:0')
    )
WHERE LENGTH(time_occ) = 1;

-- Concatenate the date_occ and time_occ column and convert to DATETIME then
-- load into the occured column.
UPDATE crimes2014
SET occured = (
    STR_TO_DATE(CONCAT(date_occ, ' ', time_occ), '%Y-%M-%d %H:%i')
);

-- Drop the date_occ and time_occ columns.
ALTER TABLE crimes2014
DROP date_occ;

ALTER TABLE crimes2014
DROP time_occ;

-- Convert the values of the date_reported column to DATETIME and then convert
-- the datatype of the column.
UPDATE crimes2014
SET date_reported = (
    STR_TO_DATE(date_reported, '%Y-%M-%d')
);

ALTER TABLE crimes2014
MODIFY date_reported DATETIME;

-- --------------------
-- CHANGES TO THE crimes2013 TABLE

-- alter the crimes2013 to have an occured column with DATETIME datatype.
ALTER TABLE crimes2013
ADD occured DATETIME;

-- Reformat the time_occ column to have an hh:mm or h:mm format to facilitate
-- string conversion to DATETIME datatype.
UPDATE crimes2013
SET time_occ = (
    INSERT(time_occ, 3, 0, ':')
    )
WHERE LENGTH(time_occ) = 4;

UPDATE crimes2013
SET time_occ = (
    INSERT(time_occ, 2, 0, ':')
    )
WHERE LENGTH(time_occ) = 3;

UPDATE crimes2013
SET time_occ = (
    INSERT(time_occ, 1, 0, '0:')
    )
WHERE LENGTH(time_occ) = 2;

UPDATE crimes2013
SET time_occ = (
    INSERT(time_occ, 1, 0, '0:0')
    )
WHERE LENGTH(time_occ) = 1;

-- Concatenate the date_occ and time_occ column and convert to DATETIME then
-- load into the occured column.
UPDATE crimes2013
SET occured = (
    STR_TO_DATE(CONCAT(date_occ, ' ', time_occ), '%D %M, %Y %H:%i')
);

-- Drop the date_occ and time_occ columns.
ALTER TABLE crimes2013
DROP date_occ;

ALTER TABLE crimes2013
DROP time_occ;

-- Convert the values of the date_reported column to DATETIME and then convert
-- the datatype of the column.
UPDATE crimes2013
SET date_reported = (
    STR_TO_DATE(date_reported, '%D %M, %Y')
);

ALTER TABLE crimes2013
MODIFY date_reported DATETIME;

-- ----------------------------------------------------------------------------
-- SET INVALID IMAGE IDs TO NULL

-- As there are invalid image_no values in crimes2013 and crimes2014 these are
-- set to NULL here. Values in the crimes2015 table are already valid.
UPDATE crimes2014
SET image_no = NULL
WHERE image_no NOT IN (
    SELECT image_no FROM image
);

UPDATE crimes2013
SET image_no = NULL
WHERE image_no NOT IN (
    SELECT image_no FROM image
);

-- ----------------------------------------------------------------------------
-- CONVERT ALL STRING VALUES TO CONSISTENT LOWER CASE

-- Admittedly this may not be necessary for everything, but with three
-- different files it feels prudent to preprocess consistency in this regard.
UPDATE crimes2015
SET area_name = LOWER(area_name);

UPDATE crimes2015
SET rd = LOWER(rd);

UPDATE crimes2015
SET crime_desc = LOWER(crime_desc);

UPDATE crimes2015
SET status = LOWER(status);

UPDATE crimes2015
SET status_desc = LOWER(status_desc);

UPDATE crimes2014
SET area_name = LOWER(area_name);

UPDATE crimes2014
SET rd = LOWER(rd);

UPDATE crimes2014
SET crime_desc = LOWER(crime_desc);

UPDATE crimes2014
SET status = LOWER(status);

UPDATE crimes2014
SET status_desc = LOWER(status_desc);

UPDATE crimes2013
SET area_name = LOWER(area_name);

UPDATE crimes2013
SET rd = LOWER(rd);

UPDATE crimes2013
SET crime_desc = LOWER(crime_desc);

UPDATE crimes2013
SET status = LOWER(status);

UPDATE crimes2013
SET status_desc = LOWER(status_desc);

-- ----------------------------------------------------------------------------
-- HANDLE MISSING AREA NAMES

-- This issue only concerns the crimes2015 table.
UPDATE crimes2015
SET area_name = (
    @n := COALESCE(area_name, @n) 
) ORDER BY area, area_name DESC;

-- ----------------------------------------------------------------------------
-- REMOVE 'Road ' SUBSTRING FROM crimes2015

UPDATE crimes2015
SET rd = SUBSTRING(rd, 6);



























