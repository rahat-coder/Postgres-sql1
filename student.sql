CREATE TABLE student(
     sid int PRIMARY KEY,
     name varchar(20),
     city varchar(20)
);

INSERT  INTO student (sid, name, city)
VALUES 
(101,'Rahat','Dhaka'),
(102,'Kabbo','Rajshahi'),
(103,'Asfia','Khulna');
 
SELECT * FROM student;

ALTER TABLE student 
RENAME COLUMN name TO studentname;

SELECT * FROM student;

ALTER TABLE student
ALTER COLUMN studentname
SET DATA TYPE varchar(100);

SELECT * FROM student;

