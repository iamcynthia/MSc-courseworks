-- Part 1.5 databaseNormalization.sql
--
-- Submitted by: Hsin -Ju, Chan
-- 


--  Write your Data Normalization statements here
CREATE TABLE Area AS
SELECT DISTINCT rd,area,area_name
FROM crimes;
ALTER TABLE Area ADD PRIMARY KEY(rd);

CREATE TABLE Type AS
SELECT DISTINCT crime_no, crime_desc
FROM crimes;
ALTER TABLE Type ADD PRIMARY KEY(crime_no);

CREATE TABLE Status AS
SELECT DISTINCT status_no, status, status_desc
FROM crimes;
ALTER TABLE Status ADD PRIMARY KEY(status_no);

CREATE TABLE 3NF AS 
SELECT dr_no,date_reported,date_occ,time_occ,crime_no,rd,status_no,image_no
FROM crimes;
ALTER TABLE 3NF ADD PRIMARY KEY(dr_no);
ALTER TABLE 3NF ADD FOREIGN KEY(crime_no) REFERENCES Type(crime_no);
ALTER TABLE 3NF ADD FOREIGN KEY(rd) REFERENCES Area(rd);
ALTER TABLE 3NF ADD FOREIGN KEY(status_no) REFERENCES Status(status_no);
