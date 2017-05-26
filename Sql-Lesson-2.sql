
-- agregating data
/*
select sat, avg(gpa) as 'AVG', count(gpa) as 'COUNT', min(gpa) as 'MIN', max(gpa) as 'MAX' from student
--where gpa >= 2.6
group by sat
having avg(gpa) >= 3.0
/*

--select * from student



-- subselect query: display all students that have GPAs greater than the average of all students GPAs
/*
select * from student
where gpa >= (select avg(gpa) from student)

select * from class
where section in (select section from class where subject = 'English' and section < '200')
*/


-- contrived union example
/*
select concat(subject, ' ', section) as Class, concat(first_name, ' ', last_name) as Instructor 
from class
join instructor
	on instructor.id = class.instructor_id
where subject = 'English' and instructor_id is not null
union
select concat(subject, ' ', section) as Class, concat(first_name, ' ', last_name) as Instructor 
from class
join instructor
	on instructor.id = class.instructor_id
where subject = 'Math' and instructor_id is not null
*/
-- Outer join
/*
select concat(first_name, ' ', last_name), ISNULL(description, 'Undeclared') as 'Major'
from student
left join major
	on major.id = student.major_id
*/
-- query: show all majors which require Math 201
/*
select concat(subject, ' ', section) as 'Class', description as 'Required by Major'
from class
join major_class_relationship
	on major_class_relationship.class_id = class.id
join major	
	on major.id = major_class_relationship.major_id
where subject = 'Math' and section = '201'
*/
-- query: show all required classes for the Engineering major
/*
select description, subject, section
from major
join major_class_relationship
	on major_class_relationship.major_id = major.id
join class
	on class.id = major_class_relationship.class_id
where major.description = 'Engineering'
*/
/*
select * from major
select * from class
select * from major_class_relationship
*/
-- query: show class info with instructor name (first & last) in instructor last name seq
/*
select subject as 'Department', section as 'Section', CONCAT(first_name, ' ', last_name) as 'Instructor Name'
from instructor
join class
	on class.instructor_id = instructor.id
order by last_name
*/
-- query: display first_name, last_name, description(major) in description sequence
/*
select first_name, last_name, description
from student
join major
	on student.major_id = major.id
where student.sat >= 1200
*/
-- query: all all columns for students with an assigned major
/*
select * from student 
where major_id is not null
--where not (major_id is null)
*/
-- query: all all columns for students without an assigned major
/*
select * from student 
where major_id is null
*/
/*
update student set major_id = 5 where id = 160
select * from student
select * from major
*/
-- Queries the Major table
/*
select req_sat, description from education.dbo.major
where description = 'math' or description = 'finance'
order by req_sat desc
*/
-- This might describe the query
/*
select first_name, last_name, sat, gpa from student
where gpa >= 3.0 and gpa <= 3.5
order by sat desc
*/