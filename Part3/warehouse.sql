-- Part 3.1 warehouse.sql
--
-- Submitted by: Hsin -Ju, Chan
-- 


--  Write your SQL statements to create and populate the crimes data warehouse
-- data preprocessing: seperate the column occurred to date_occ and time_occ-----------
ALTER TABLE crimes2015 
ADD date_occ TEXT AFTER date_reported;  
ALTER TABLE crimes2015
ADD time_occ TIME AFTER date_occ;  

UPDATE crimes2015
SET date_occ = SUBSTRING(occured,1,10), time_occ = SUBSTRING(occured FROM 12);   

ALTER TABLE crimes2015 DROP occured;

-- data preprocessing: fill in the correct name in the column area_name----------------
create table area_new as select distinct area, area_name from crimes2015 where area_name != 'null';

UPDATE crimes2015 C SET area_name = (SELECT area_name from area_new A WHERE C.area = A.area); 

DROP TABLE area_new;

-- change the format of date_reported and date_occ-------------------------------------
UPDATE crimes2015
SET date_occ = STR_TO_DATE(date_occ, '%m/%d/%Y'), date_reported = STR_TO_DATE(date_reported, '%m/%d/%Y');

-- Data Warehousing--------------------------------------------------------------------
-- dim table TYPE
CREATE TABLE TYPE AS SELECT DISTINCT crime_no, crime_desc FROM crimes2015;
ALTER TABLE TYPE ADD PRIMARY KEY (crime_no);

--dim table Area_3
CREATE TABLE Area_3 AS SELECT DISTINCT area, area_name FROM crimes2015;
ALTER TABLE Area_3 ADD PRIMARY KEY (area);

-- dim table Status_3
CREATE TABLE Status_3(
status_no INT(11) NOT NULL AUTO_INCREMENT, 
status TEXT,
status_desc TEXT,
PRIMARY KEY (status_no));

INSERT INTO Status_3(status,status_desc)
SELECT DISTINCT status, status_desc FROM crimes2015;

-- dim table Reported
CREATE TABLE Reported(
rep_code INT(11) NOT NULL AUTO_INCREMENT,
day INT(2),
month INT(2),
year INT(4),
PRIMARY KEY (rep_code));

INSERT INTO Reported (day,month,year)
SELECT DISTINCT DAY(date_reported),MONTH(date_reported),YEAR(date_reported)
FROM crimes2015;

-- dim table Occ_timed
CREATE TABLE Occ_timed(
occ_code INT(11) NOT NULL AUTO_INCREMENT,
day INT(2),
month INT(2),
year INT(4),
hour INT(2),
minute INT(2),
PRIMARY KEY (occ_code));

INSERT INTO Occ_timed (day, month, year, hour, minute)
SELECT DISTINCT DAY(date_occ),MONTH(date_occ),YEAR(date_occ), HOUR(time_occ), MINUTE(time_occ)
FROM crimes2015;

-- fact table a_Crime
CREATE TABLE a_Crime (
dr_no INT(11) NOT NULL,
crime_no INT(11) NOT NULL,
area INT(11) NOT NULL,
status_no INT(11) NOT NULL,
rep_code INT(11) NOT NULL,
occ_code INT(11) NOT NULL,
PRIMARY KEY (dr_no, crime_no, area, status_no,rep_code,occ_code),
FOREIGN KEY (crime_no) REFERENCES TYPE(crime_no),
FOREIGN KEY (area) REFERENCES Area_3(area),
FOREIGN KEY (status_no) REFERENCES Status_3(status_no),
FOREIGN KEY (rep_code) REFERENCES Reported(rep_code),
FOREIGN KEY (occ_code) REFERENCES Occ_timed(occ_code));

INSERT INTO a_Crime
SELECT C.dr_no, T.crime_no, A.area, S.status_no, R.rep_code, O.occ_code
FROM crimes2015 C, TYPE T, Area_3 A, Status_3 S, Reported R, Occ_timed O
WHERE C.crime_no = T.crime_no AND
C.area = A.area AND
C.status_desc = S.status_desc AND
DAY(date_reported) = R.day AND
MONTH(date_reported) = R.month AND
YEAR(date_reported) = R.year AND
DAY(date_occ) = O.day AND
MONTH(date_occ) = O.month AND
YEAR(date_occ) = O.year AND
HOUR(time_occ) = O.hour AND
MINUTE(time_occ) = O.minute;





