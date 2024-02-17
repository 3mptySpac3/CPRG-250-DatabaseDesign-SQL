set echo on 
spool C:\Users\jbsom\Documents\CPRG-250_Activity\grandHill2Output.txt


--delete existing data from tables, children followed parents
delete ghc_expertise;
delete ghc_course;
delete ghc_faculty;
delete ghc_department;

-- insert data, parents followed by children

insert into ghc_department (dept_no, dept_name)
    values(100,'Astrophysics');

insert into ghc_faculty (faculty_id, firstname, surname, date_hired, date_fired, is_active, dept_no)
    values(1001,'Danny','Faulkner','01-JAN-02',NULL,1,100);

insert into ghc_course (course_code,course_title,credits)
    values('APHY202','The Solar System',5);
insert into ghc_course (course_code,course_title,credits)
    values('APHY203','Nebula',5);
insert into ghc_course (course_code,course_title,credits)
    values('APHY204','Global Cluters',5);

insert into ghc_expertise (faculty_id, course_code)
    values(1001, 'APHY202');
insert into ghc_expertise (faculty_id, course_code)
    values(1001, 'APHY203');
insert into ghc_expertise (faculty_id, course_code)
    values(1001, 'APHY204');

-- add new row for ghc_course to update and replace old row 
insert into ghc_course (course_code,course_title,credits)
    values('APHY302','Nebula',5);

update ghc_expertise
    set course_code = 'APHY302'
    where faculty_id = 1001 AND course_code = 'APHY203';

delete from ghc_course 
    where course_code = 'APHY203';

-- delete Danny Faulker

delete from ghc_expertise 
    where faculty_id = 1001;

delete from ghc_faculty 
    where faculty_id = 1001;


COMMIT;

select * from ghc_department;
select * from ghc_course;
select * from ghc_expertise;
select * from ghc_faculty;

spool off; 

