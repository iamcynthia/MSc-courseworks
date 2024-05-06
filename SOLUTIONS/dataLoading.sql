-- Part 1.2 dataLoading.sql
--
-- Submitted by: Write your Name here
-- 

DROP TABLE IF EXISTS `crimes2013`;
CREATE TABLE `crimes2013` (
  `dr_no` int(11) DEFAULT NULL,
  `date_reported` text,
  `date_occ` text,
  `time_occ` varchar(20) DEFAULT NULL,
  `area` int(11) DEFAULT NULL,
  `area_name` text,
  `rd` int(11) DEFAULT NULL,
  `crime_no` int(11) DEFAULT NULL,
  `crime_desc` text,
  `status` text,
  `status_desc` text,
  `image_no` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `crimes2014`;
CREATE TABLE `crimes2014` (
  `date_reported` text,
  `dr_no` int(11) DEFAULT NULL,
  `date_occ` text,
  `time_occ` varchar(20) DEFAULT NULL,
  `area` int(11) DEFAULT NULL,
  `area_name` text,
  `rd` int(11) DEFAULT NULL,
  `crime_no` int(11) DEFAULT NULL,
  `crime_desc` text,
  `status` text,
  `status_desc` text,
  `image_no` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA LOCAL INFILE '/Users/natalia/OneDrive - King\'s College London/KCL/2019-20/7CCSMDDW/2019-20/Assignments/Assignment2/SOLUTIONS/Part1/crimes2014.csv' 
INTO TABLE crimes2014 
FIELDS TERMINATED BY ';' ENCLOSED BY '\'' LINES TERMINATED BY '\n' 
  IGNORE 1 LINES
  (date_reported,dr_no,date_occ,time_occ,area,area_name,rd,crime_no,crime_desc,status,status_desc,image_no) ;

  
LOAD DATA LOCAL INFILE '/Users/natalia/OneDrive - King\'s College London/KCL/2019-20/7CCSMDDW/2019-20/Assignments/Assignment2/SOLUTIONS/Part1/crimes2013.txt' 
INTO TABLE crimes2013 
FIELDS TERMINATED BY '\t' ENCLOSED BY '\'' LINES TERMINATED BY '\n' 
  IGNORE 1 LINES
  (dr_no,date_reported,date_occ,time_occ,area,area_name,rd,crime_no,crime_desc,status,status_desc,image_no) ;