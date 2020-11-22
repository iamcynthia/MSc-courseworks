-- insert.sql
--
-- Submitted by: Hsin-Ju Chan
-- 


-- add your INSERT statements here

--Create at least 2 department

INSERT INTO department VALUES (1001, 'Informatics','dept01'),(1002, 'Law','dept02');

--Create at least 3 academics per each department

INSERT INTO academic VALUES (3001,'Brock','McKinney','0923517583','I01','1964/03/02','kwrlwh@gmail.com',98235,1001), 
(3002,'Edith','Beasley','0934785621','I02','1960/11/02','slkhwti@gmail.com',98256,1001),
(3003,'Julian','Johnston','0928461759','I03','1959/06/07','ah4uy@gmail.com',98734,1001), 
(3004,'Eddie','Olson','0917473816','L01','1969/07/07','a8943y@gmail.com',98724,1002), 
(3005,'Julie','Garmer','0947281957','L02','1954/02/14','kefbns@gmail.com',98757,1002), 
(3006,'Tony','Maxwell','0936581275','L03','1950/05/20','ero4p6@gmail.com',98926,1002);


--Create at least 10 students

INSERT INTO phdStudent VALUES (5001,'Jack','Hu','jelbn@gmail.com','M','London','2018/02/04'),
(5002,'Romeo','Wallace','aruhp@gmail.com','M','Durham','2019/09/10'),
(5003,'Eva','Wang','a4ioyh@gmail.com','F','Leeds','2019/08/14'),
(5004,'Dan','Wolfson','5yjoiw@gmail.com','M','Bath','2017/04/30'), 
(5005,'Kelly','Caldwell','54290ngj@gmail.com','F','London','2019/09/09'),
(5006,'Shay','Mooney','reku3@gmail.com','M','Glasgow','2018/03/05'), 
(5007,'Curtis','Kou','34uih@gmail.com','M','Leeds','2019/04/28'), 
(5008,'Vincent','Yates','gk65he@gmail.com','M','Bath','2017/02/28'), 
(5009,'Mafi','Liu','wuioyg@gmail.com','F','London','2019/05/21'), 
(5010,'Rachael','Lee','ho562et@gmail.com','F','York','2019/04/03');



--Include at least 1 supervisor per student

INSERT INTO supervises VALUES (5001,'1',3001),
(5002,'1',3003),(5002,'2',3001),(5003,'1',3003),
(5003,'2',3005),(5004,'1',3006),(5005,'2',3001),
(5006,'1',3004),(5007,'1',3001),(5007,'2',3005),
(5008,'1',3005),(5009,'2',3002),(5010,'1',3005);


--Create at least 2 projects per each academic

INSERT INTO project VALUES (7001,'aaaaa','2018/01/04','2019/04/01',680,3002), 
(7002,'bbbbb','2019/02/10','2020/04/05',950,3005), 
(7003,'ccccc','2019/04/18','2019/09/29',1200,3004), 
(7004,'ddddd','2017/05/13','2018/05/31',500,3001), 
(7005,'eeeee','2019/05/24','2020/06/07',900,3001), 
(7006,'fffff','2019/05/07','2019/12/25',860,3002), 
(7007,'ggggg','2017/11/09','2018/12/20',780,3005), 
(7008,'hhhhh','2019/05/08','2020/10/04',700,3006), 
(7009,'iiiii','2017/12/09','2018/05/30',800,3003), 
(7010,'jjjjj','2019/04/06','2020/08/02',850,3003), 
(7011,'kkkkk','2018/07/27','2019/09/30',550,3004), 
(7012,'lllll','2019/06/03','2020/10/10',600,3006);

--Include at least 4 collaboratesIn per academic

INSERT INTO collaboratesIn VALUES (3001,7002,0.25),
(3001,7003,0.13), (3001,7001,0.30), (3001,7006,0.32), 
(3002,7012,0.18), (3002,7004,0.24), (3002,7009,0.31), 
(3002,7007,0.27), (3003,7003,0.30), (3003,7006,0.17), 
(3003,7005,0.21), (3003,7011,0.32), (3004,7010,0.24), 
(3004,7009,0.19), (3004,7008,0.22), (3004,7012,0.35), 
(3005,7003,0.21), (3005,7001,0.38), (3005,7009,0.26), 
(3005,7010,0.15), (3006,7006,0.13), (3006,7002,0.43), 
(3006,7005,0.20), (3006,7011,0.24);
