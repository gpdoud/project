CREATE DATABASE Education
-- this is the STUDENT table
CREATE TABLE Student (
	Id int not null identity(1,1) primary key, -- this is the primary key
	FirstName varchar(50) not null,
	LastName varchar(50) not null,
	DateRegistered DateTime not null,
	Active bit not null default 1,
	DateCreated Timestamp not null,
	DateUpdated DateTime
)

INSERT into Student (FirstName, LastName, DateRegistered)
VALUES ('Alex', 'Cobb', '2017-05-25 15:00:00')

INSERT into Student (FirstName, LastName, DateRegistered)
VALUES ('Pierson', 'D''Enbeau', '2017-05-25 15:00:00')

INSERT into Student (FirstName, LastName, DateRegistered)
VALUES ('Greg', 'Doud', '2017-05-25 15:00:00')

CREATE TABLE Major (
	Id int not null identity(1,1) primary key,
	Department varchar(50) not null,
	Description varchar(80) not null,
	Active bit not null default 1,
	DateCreated timestamp not null,
	DateUpdated DateTime
)

INSERT into Major (Description, Department)
VALUES ('Philosophy', 'Philosophy')

INSERT into Major (Description, Department)
VALUES ('CS', 'CS & ENG')

INSERT into Major (Description, Department)
VALUES ('IPS', 'Business')

ALTER TABLE Student
	ADD MajorId int foreign key references Major(Id)

select FirstName, LastName, Description 
	from student
	join major
		on student.majorid = major.id
	where major.description = 'CS'
	order by FirstName desc

UPDATE Student Set MajorId = 1
	WHERE FirstName = 'Alex'

UPDATE Student Set MajorId = 2
	WHERE FirstName = 'Pierson'

UPDATE Student Set MajorId = 3
	WHERE FirstName = 'Greg'