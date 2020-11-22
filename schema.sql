--  schema.sql
--
-- Submitted by: Hsin-Ju Chan
-- 


-- add your CREATE TABLE statements here

CREATE TABLE department( id INT(11) NOT NULL, name CHAR(20) NOT NULL, description CHAR(20), PRIMARY KEY (id));

CREATE TABLE academic( id INT(11) NOT NULL, lname CHAR(20) NOT NULL, fname CHAR(20) NOT NULL, phone CHAR(20) NOT NULL, office CHAR(20) NOT NULL, dob DATE NOT NULL, email CHAR(20) NOT NULL, nino CHAR(20) NOT NULL, department_id INT(11) NOT NULL, PRIMARY KEY (id), FOREIGN KEY (department_id) REFERENCES department (id));

CREATE TABLE phdStudent( id INT(11) NOT NULL, lname CHAR(20) NOT NULL, fname CHAR(20) NOT NULL, email CHAR(20) NOT NULL, gender CHAR(20), address CHAR(20) NOT NULL, startDate DATE NOT NULL, PRIMARY KEY (id));

CREATE TABLE project( id INT(11) NOT NULL, title CHAR(20) NOT NULL, startDate DATE NOT NULL, endDate DATE NOT NULL, budget INT(11) NOT NULL, coordinator_id INT(11) NOT NULL, PRIMARY KEY (id), FOREIGN KEY (coordinator_id) REFERENCES academic (id));

CREATE TABLE collaboratesIn( academic_id INT(11) NOT NULL, project_id INT(11) NOT NULL, time DECIMAL(3,2) NOT NULL, PRIMARY KEY(academic_id, project_id), FOREIGN KEY (academic_id) REFERENCES academic(id), FOREIGN KEY (project_id) REFERENCES project(id)); 

CREATE TABLE supervises(student_id INT(11) NOT NULL, type CHAR(5) NOT NULL, supervisor_id INT(11) NOT NULL, PRIMARY KEY(type, student_id), FOREIGN KEY (student_id) REFERENCES phdStudent(id) ON DELETE CASCADE, FOREIGN KEY (supervisor_id) REFERENCES academic(id));