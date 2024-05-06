-- Part 1.4 dataIntegration.sql
--
-- Submitted by: Write your Name here
-- 


--  Write your Data Integration statements here

drop table if exists crimes;
create table crimes as select dr_no ,date_reported ,area, area_name,rd ,crime_no ,crime_desc ,status  ,status_desc,image_no,occured  from crimes2015;
insert into crimes  select dr_no ,date_reported ,area, area_name,rd ,crime_no ,crime_desc ,status  ,status_desc,image_no,occured from crimes2014;
insert into crimes  select dr_no ,date_reported ,area, area_name,rd ,crime_no ,crime_desc ,status  ,status_desc,image_no,occured from crimes2013;