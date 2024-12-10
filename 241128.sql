show user;

create table department(
deptno number(3) not null,
dname varchar2(30) not null,
college number(3) not null,
loc varchar2(10) not null,
constraint department_pk primary key(deptno)
);

select * from department;
select * from professor;

create table professor (
profno      number(5) not null,
name        varchar2(10) not null, --한글 이름
ename       varchar2(20) not null, --english name
position    varchar2(20) not null, --시간강사, 겸임, 전임
sal         number(4) not null,
hiredate    date not null,
age         number(3) not null,
deptno      number(3) not null,
constraint  professor_pk primary key(profno)
);

alter table professor add constraint professor_fk foreign key(deptno) references department(deptno);