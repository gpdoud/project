-- Education DB
drop database if exists education;
GO
Create Database education;
GO

-- drop all tables
drop table if exists major_class_relationship;
drop table if exists student_class_relationship;
drop table if exists student;
drop table if exists major;
drop table if exists assignment;
drop table if exists class;
drop table if exists instructor;
drop table if exists classgrade;
GO
-- create the tables
create table classgrade (
	grade varchar(3) primary key,
	gpa_value decimal(4,2) not null default 0.0
);

create table major (
	id int primary key identity(1,1),
	description varchar(50) not null,
	req_sat int not null
);

create table student (
	id int primary key identity(1,1),
	first_name varchar(30) not null,
	last_name varchar(30) not null,
	sat int,
	gpa decimal(4,2) not null,
	major_id int,
	foreign key (major_id) references major(id)
);

create table instructor (
	id int primary key identity(1,1),
	first_name varchar(30) not null,
	last_name varchar(30) not null,
	years_experience int not null default 0,
	is_tenured tinyint not null default 0
);

create table class (
	id int primary key identity(1,1),
	subject varchar(30) not null,
	section int not null,
	instructor_id int,
	foreign key (instructor_id) references instructor(id)
);

create table assignment (
	id int primary key identity(1,1),
	description varchar(30) not null,
	class_id int not null,
	foreign key (class_id) references class(id)
);

create table major_class_relationship (
	id int primary key identity(1,1),
	major_id int not null,
	class_id int not null,
	foreign key (major_id) references major(id),
	foreign key (class_id) references class(id)
);

create table student_class_relationship (
	id int primary key identity(1,1),
	student_id int not null,
	class_id int not null,
	classgrade_grade varchar(3),
	foreign key (student_id) references student(id),
	foreign key (class_id) references class(id),
	foreign key (classgrade_grade) references classgrade(grade)
);
GO

-- CLASSGRADE: Data
INSERT classgrade (grade, gpa_value) VALUES ('A+',4.35);
INSERT classgrade (grade, gpa_value) VALUES ('A',4.0);
INSERT classgrade (grade, gpa_value) VALUES ('A-',3.7);
INSERT classgrade (grade, gpa_value) VALUES ('B+',3.35);
INSERT classgrade (grade, gpa_value) VALUES ('B',3.0);
INSERT classgrade (grade, gpa_value) VALUES ('B-',2.7);
INSERT classgrade (grade, gpa_value) VALUES ('C+',2.35);
INSERT classgrade (grade, gpa_value) VALUES ('C',2.0);
INSERT classgrade (grade, gpa_value) VALUES ('C-',1.7);
INSERT classgrade (grade, gpa_value) VALUES ('D+',1.35);
INSERT classgrade (grade, gpa_value) VALUES ('D',1.0);
INSERT classgrade (grade, gpa_value) VALUES ('D-',0.5);
INSERT classgrade (grade, gpa_value) VALUES ('F',0.0);
Go

SET Identity_Insert major on;
GO
-- MAJOR: Sample data
INSERT major (id, description, req_sat) VALUES (1,'General Business',800);
INSERT major (id, description, req_sat) VALUES (2,'Accounting', 1000);
INSERT major (id, description, req_sat) VALUES (3,'Finance', 1100);
INSERT major (id, description, req_sat) VALUES (4,'Math', 1300);
INSERT major (id, description, req_sat) VALUES (5,'Engineering', 1350);
INSERT major (id, description, req_sat) VALUES (6,'Education', 900);
INSERT major (id, description, req_sat) VALUES (7,'General Studies', 500);
Go

SET Identity_Insert major off
Go

SET Identity_Insert student on;
GO

-- STUDENT: Sample data
INSERT student (id, first_name, last_name, sat, gpa, major_id) VALUES(100,'Eric','Ephram',1200,3.0,1);
INSERT student (id, first_name, last_name, sat, gpa, major_id)  VALUES(110,'Greg','Gould',1100,2.5,null);
INSERT student (id, first_name, last_name, sat, gpa, major_id)  VALUES(120,'Adam','Ant',1300,3.2,null);
INSERT student (id, first_name, last_name, sat, gpa, major_id)  VALUES(130,'Howard','Hess',1600,3.7,null);
INSERT student (id, first_name, last_name, sat, gpa, major_id)  VALUES(140,'Charles','Caldwell',900,2.1,null);
INSERT student (id, first_name, last_name, sat, gpa, major_id)  VALUES(150,'James','Joyce',1100,2.5,null);
INSERT student (id, first_name, last_name, sat, gpa, major_id)  VALUES(160,'Doug','Dumas',1350,3.1,null);
INSERT student (id, first_name, last_name, sat, gpa, major_id)  VALUES(170,'Kevin','Kraft',1000,2.7,null);
INSERT student (id, first_name, last_name, sat, gpa, major_id)  VALUES(180,'Frank','Fountain',1000,2.5,null);
INSERT student (id, first_name, last_name, sat, gpa, major_id)  VALUES(190,'Brian','Biggs',950,2.3,null);

SET Identity_Insert student off
Go

SET Identity_Insert instructor on
Go

-- INSTRUCTOR: Sample data
INSERT instructor (id, first_name, last_name, years_experience, is_tenured) VALUES (10,'Joe','Downey',10,1);
INSERT instructor (id, first_name, last_name, years_experience, is_tenured) VALUES (20,'Jane','Jones',6,1);
INSERT instructor (id, first_name, last_name, years_experience, is_tenured) VALUES (30,'Bill','Tensi',3,0);
INSERT instructor (id, first_name, last_name, years_experience, is_tenured) VALUES (40,'Sherry','Nagy',14,1);
INSERT instructor (id, first_name, last_name, years_experience, is_tenured) VALUES (50,'Frank','Schell',23,1);
INSERT instructor (id, first_name, last_name, years_experience, is_tenured) VALUES (60,'Michelle','Bellman',35,1);
INSERT instructor (id, first_name, last_name, years_experience, is_tenured) VALUES (70,'George','Hunt',2,0);
INSERT instructor (id, first_name, last_name, years_experience, is_tenured) VALUES (80,'Amy','Brock',7,0);
INSERT instructor (id, first_name, last_name, years_experience, is_tenured) VALUES (90,'Larry','Seger',11,1);
INSERT instructor (id, first_name, last_name, years_experience, is_tenured) VALUES (100,'Kathy','Miller',21,1);
Go

SET Identity_Insert instructor off
Go

SET Identity_Insert class on
Go

-- CLASS: Sample data
-- English
INSERT class (id,subject,section,instructor_id) VALUES(10101,'English',101,10);
INSERT class (id,subject,section,instructor_id) VALUES(10102,'English',102,NULL);
INSERT class (id,subject,section,instructor_id) VALUES(10103,'English',103,NULL);
INSERT class (id,subject,section,instructor_id) VALUES(10201,'English',201,10);
INSERT class (id,subject,section,instructor_id) VALUES(10202,'English',202,NULL);
INSERT class (id,subject,section,instructor_id) VALUES(10203,'English',203,NULL);
INSERT class (id,subject,section,instructor_id) VALUES(10301,'English',301,10);
INSERT class (id,subject,section,instructor_id) VALUES(10302,'English',302,NULL);
INSERT class (id,subject,section,instructor_id) VALUES(10303,'English',303,NULL);
-- Math
INSERT class (id,subject,section,instructor_id) VALUES(20201,'Math',201,50);
INSERT class (id,subject,section,instructor_id) VALUES(20202,'Math',202,NULL);
INSERT class (id,subject,section,instructor_id) VALUES(20203,'Math',203,NULL);
INSERT class (id,subject,section,instructor_id) VALUES(20204,'Math',204,NULL);
INSERT class (id,subject,section,instructor_id) VALUES(20401,'Math',401,50);
INSERT class (id,subject,section,instructor_id) VALUES(20402,'Math',402,NULL);
INSERT class (id,subject,section,instructor_id) VALUES(20403,'Math',403,NULL);
INSERT class (id,subject,section,instructor_id) VALUES(20404,'Math',404,NULL);
-- History
INSERT class (id,subject,section,instructor_id) VALUES(30101,'History',101,80);
INSERT class (id,subject,section,instructor_id) VALUES(30202,'History',201,80);
INSERT class (id,subject,section,instructor_id) VALUES(30303,'History',301,80);
-- Computer Science
INSERT class (id,subject,section,instructor_id) VALUES(40311,'Computer Science',311,40);
INSERT class (id,subject,section,instructor_id) VALUES(40312,'Computer Science',312,40);
INSERT class (id,subject,section,instructor_id) VALUES(40313,'Computer Science',313,40);
INSERT class (id,subject,section,instructor_id) VALUES(40441,'Computer Science',441,40);
INSERT class (id,subject,section,instructor_id) VALUES(40442,'Computer Science',442,40);
INSERT class (id,subject,section,instructor_id) VALUES(40443,'Computer Science',443,40);
-- Psychology
INSERT class (id,subject,section,instructor_id) VALUES(50101,'Psychology',101,20);
INSERT class (id,subject,section,instructor_id) VALUES(50102,'Psychology',102,20);
INSERT class (id,subject,section,instructor_id) VALUES(50231,'Psychology',231,20);
INSERT class (id,subject,section,instructor_id) VALUES(50232,'Psychology',232,20);
-- Education
INSERT class (id,subject,section,instructor_id) VALUES(60221,'Education',221,60);
INSERT class (id,subject,section,instructor_id) VALUES(60222,'Education',222,60);
INSERT class (id,subject,section,instructor_id) VALUES(60223,'Education',223,60);
INSERT class (id,subject,section,instructor_id) VALUES(60351,'Education',351,70);
INSERT class (id,subject,section,instructor_id) VALUES(60352,'Education',352,70);
INSERT class (id,subject,section,instructor_id) VALUES(60353,'Education',353,70);

SET Identity_Insert class off
Go

--SET Identity_Insert major_class_relationship on
--Go

-- Classes needed for major: General Business
INSERT major_class_relationship (major_id, class_id) VALUES(1,10101); -- Gen bus | Eng 101
INSERT major_class_relationship (major_id, class_id) VALUES(1,10102); -- Gen bus | Eng 102
INSERT major_class_relationship (major_id, class_id) VALUES(1,10103); -- Gen bus | Eng 103
INSERT major_class_relationship (major_id, class_id) VALUES(1,20201); -- Gen bus | Mat 201
INSERT major_class_relationship (major_id, class_id) VALUES(1,20202); -- Gen bus | Mat 202
INSERT major_class_relationship (major_id, class_id) VALUES(1,20203); -- Gen bus | Mat 203
INSERT major_class_relationship (major_id, class_id) VALUES(1,30101); -- Gen bus | His 101

-- Classes needed for major: Accounting
INSERT major_class_relationship (major_id, class_id) VALUES(2,10101); -- Acct | Eng 101
INSERT major_class_relationship (major_id, class_id) VALUES(2,10102); -- Acct | Eng 101
INSERT major_class_relationship (major_id, class_id) VALUES(2,10103); -- Acct | Eng 101
INSERT major_class_relationship (major_id, class_id) VALUES(2,20201); -- Acct | Mat 201
INSERT major_class_relationship (major_id, class_id) VALUES(2,20202); -- Acct | Mat 202
INSERT major_class_relationship (major_id, class_id) VALUES(2,20203); -- Acct | Mat 203
INSERT major_class_relationship (major_id, class_id) VALUES(2,30101); -- Acct | His 101

-- Classes needed for major: Finance
INSERT major_class_relationship (major_id, class_id) VALUES(3,10101); -- Fin | Eng 101
INSERT major_class_relationship (major_id, class_id) VALUES(3,10102); -- Fin | Eng 101
INSERT major_class_relationship (major_id, class_id) VALUES(3,10103); -- Fin | Eng 101
INSERT major_class_relationship (major_id, class_id) VALUES(3,20201); -- Fin | Mat 201
INSERT major_class_relationship (major_id, class_id) VALUES(3,20202); -- Fin | Mat 202
INSERT major_class_relationship (major_id, class_id) VALUES(3,20203); -- Fin | Mat 203
INSERT major_class_relationship (major_id, class_id) VALUES(3,30101); -- Fin | His 101

-- Classes needed for major: Finance
INSERT major_class_relationship (major_id, class_id) VALUES(4,10101); -- Math | Eng 101
INSERT major_class_relationship (major_id, class_id) VALUES(4,10102); -- Math | Eng 101
INSERT major_class_relationship (major_id, class_id) VALUES(4,10103); -- Math | Eng 101
INSERT major_class_relationship (major_id, class_id) VALUES(4,20201); -- Math | Mat 201
INSERT major_class_relationship (major_id, class_id) VALUES(4,20202); -- Math | Mat 202
INSERT major_class_relationship (major_id, class_id) VALUES(4,20203); -- Math | Mat 203
INSERT major_class_relationship (major_id, class_id) VALUES(4,20204); -- Math | Mat 204
INSERT major_class_relationship (major_id, class_id) VALUES(4,20401); -- Math | Mat 201
INSERT major_class_relationship (major_id, class_id) VALUES(4,20402); -- Math | Mat 202
INSERT major_class_relationship (major_id, class_id) VALUES(4,20403); -- Math | Mat 203
INSERT major_class_relationship (major_id, class_id) VALUES(4,20404); -- Math | Mat 204
INSERT major_class_relationship (major_id, class_id) VALUES(4,30101); -- Math | His 101

-- Classes needed for major: Finance
INSERT major_class_relationship (major_id, class_id) VALUES(5,10101); -- Eng | Eng 101
INSERT major_class_relationship (major_id, class_id) VALUES(5,10102); -- Eng | Eng 101
INSERT major_class_relationship (major_id, class_id) VALUES(5,10103); -- Eng | Eng 101
INSERT major_class_relationship (major_id, class_id) VALUES(5,20201); -- Eng | Mat 201
INSERT major_class_relationship (major_id, class_id) VALUES(5,20202); -- Eng | Mat 202
INSERT major_class_relationship (major_id, class_id) VALUES(5,20203); -- Eng | Mat 203
INSERT major_class_relationship (major_id, class_id) VALUES(5,30101); -- Eng | His 101

-- Classes needed for major: Finance
INSERT major_class_relationship (major_id, class_id) VALUES(6,10101); -- Educ | Eng 101
INSERT major_class_relationship (major_id, class_id) VALUES(6,10102); -- Educ | Eng 101
INSERT major_class_relationship (major_id, class_id) VALUES(6,10103); -- Educ | Eng 101
INSERT major_class_relationship (major_id, class_id) VALUES(6,20201); -- Educ | Mat 201
INSERT major_class_relationship (major_id, class_id) VALUES(6,20202); -- Educ | Mat 202
INSERT major_class_relationship (major_id, class_id) VALUES(6,20203); -- Educ | Mat 203
INSERT major_class_relationship (major_id, class_id) VALUES(6,30101); -- Educ | His 101

-- Classes needed for major: Finance
INSERT major_class_relationship (major_id, class_id) VALUES(7,10101); -- GS | Eng 101
INSERT major_class_relationship (major_id, class_id) VALUES(7,10102); -- GS | Eng 101
INSERT major_class_relationship (major_id, class_id) VALUES(7,10103); -- GS | Eng 101
INSERT major_class_relationship (major_id, class_id) VALUES(7,20201); -- GS | Mat 201
INSERT major_class_relationship (major_id, class_id) VALUES(7,20202); -- GS | Mat 202
INSERT major_class_relationship (major_id, class_id) VALUES(7,20203); -- GS | Mat 203
INSERT major_class_relationship (major_id, class_id) VALUES(7,30101); -- GS | His 101
Go

--SET Identity_Insert major_class_relationship off
--Go

--SET Identity_Insert student_class_relationship on
--Go

-- Classes taken by a student
INSERT student_class_relationship (student_id,class_id,classgrade_grade) VALUES (100,10101,'A+');
GO

--SET Identity_Insert student_class_relationship off
--Go


select m.description as 'Major', m.req_sat as 'SAT', c.subject as 'Subject', c.section as 'Section'
	from major m 
	join major_class_relationship mc  
		on mc.major_id = m.id 
	join class c
		on c.id = mc.class_id
	where m.description in ('General Business','Math');

-- Classes remaining for a student of a major
select concat(s.first_name,' ',s.last_name) as 'Name', concat(c.subject, ' ',c.section) as 'Class'
	from student s
	join major m
		on s.major_id = m.id
	join major_class_relationship mc
		on m.id = mc.major_id
	join class c
		on c.id = mc.class_id
where c.id not in (
			select c.id
				from student s
				join student_class_relationship sc
					on s.id = sc.student_id
				join class c
					on c.id = sc.class_id
		);

select concat(s.first_name,' ',s.last_name) as 'Name', c.Subject as 'Class'
	, i.last_name as 'Instructor', cg.grade as 'Grade', cg.gpa_value as 'GPA Value'
	from student s
	join student_class_relationship sc
		on s.id = sc.student_id
	join class c 
		on c.id = sc.class_id
	join classgrade cg 
		on sc.classgrade_grade = cg.grade
	join instructor i
		on i.id = c.instructor_id
where s.id = 100;

select concat(s.first_name,' ',s.last_name) as 'Name', concat(c.subject,' ',c.section) as 'Class'
		,  i.last_name as 'Instructor'
	from student s 
	join student_class_relationship sc 
		on s.id = sc.student_id
	join class c 
		on c.id = sc.class_id
	left join instructor i 
		on i.id = c.instructor_id;