select * from tab;

select * from emp;
select * from dept;

select * from salgrade;

--1.
select e.ename, e.deptno, d.dname from emp e inner join dept d on e.deptno=d.deptno;

--2.
select e.ename, e.job, e.deptno, d.loc from emp e inner join dept d on e.deptno=d.deptno where e.deptno=30;

--3.
select e.ename, e.comm, d.dname, d.loc from emp e inner join dept d on e.deptno=d.deptno where e.comm is not null;

--4.
select e.ename, e.job, d.dname, d.loc from emp e inner join dept d on e.deptno=d.deptno where d.loc='DALLAS';

--5.
select e.ename, d.dname from emp e inner join dept d on e.deptno=d.deptno where e.ename like '%A%';

--6.
select e.ename, e.job, e.sal, s.grade from emp e, salgrade s where e.sal >= s.losal and e.sal <= s.hisal;

--7.
select e1.ename, e1.deptno, e2.ename from emp e1, emp e2 where e1.deptno=e2.deptno and e1.ename!=e2.ename order by e1.deptno, e1.ename;



/*
    서브 쿼리
    
    - 하나의 select 문장의 안에 또 하나의 포함된 select 문장이다.
    
*/
select deptno from emp where ename='SCOTT';
select dname from dept where deptno=20;
--->
select dname from dept where deptno=(select deptno from emp where ename='SCOTT');

/*
    단일 행 서브쿼리
    - 하나의 해만 검색하여 그 결과를 메인쿼리에 보냄
*/
select deptno from emp where ename='JONES';
select dname from dept where deptno=(select deptno from emp where ename='JONES');

select ename, deptno from emp where deptno=(select deptno from emp where ename='SMITH');

select round(avg(sal)) from emp;
select ename, sal from emp where sal > (select round(avg(sal)) from emp);



/*
    다중 행 서브쿼리
    - 서브쿼리에서 반환되는 결과가 하나 이상일 때 사용하는 서브쿼리
    - 다중 행 서브쿼리는 반드시 다중 행 연산자와 함께 사용
    
    다중 행 연산자
    
    IN          : 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 하나라도 일치하면 참
    ANY, SOME   : 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 하나이상이 일치하면 참
    ALL         : 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 모든 값이 일치하면 참
    EXIST       : 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과 중에서 만족하는 값이 하나라도 존재하면 참
*/

-- in 연산자 : 결과가 2개 이상 구해지는 쿼리문을 서브쿼리로 기술할경우 다중 행 연산자와 함께 사용해야함
select distinct deptno from emp where sal>=3000;
select ename, sal, deptno from emp where deptno in (select distinct deptno from emp where sal>=3000);

select ename, hiredate from emp where deptno in (select deptno from emp where ename='BLAKE');


-- ALL 연산자
select max(sal) from emp where deptno=30;
select ename, sal from emp where sal > all (select max(sal) from emp where deptno=30);


-- ANY 연산자 : 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 하나이상이 일치하면 참
select ename, sal from emp where sal > any (select min(sal) from emp where deptno=30);



--1.
select ename, sal from emp where sal >= all (select sal from emp where ename='SCOTT');
--2.
select e.ename, e.job, e.deptno, d.loc from emp e inner join dept d on e.deptno=d.deptno where e.ename in (select ename from emp where job='CLERK');
--3.
select empno, ename, deptno from emp where ename in (select ename from emp where ename like '%T%');
--4.
select ename, deptno from emp where deptno in (select deptno from dept where loc='DALLAS');
--5.
select ename, deptno, sal from emp where deptno in (select deptno from dept where dname='SALES');
--6.
select * from emp;
select ename, sal from emp where mgr in (select empno from emp where ename='KING');
--7.
select empno, ename, sal, deptno from emp where emp.deptno in (select deptno from emp where sal >= (select avg(sal) from emp) and ename like '%S%');


/*
자료형
char
- 고정길이 문자 데이터

varchar
- 가변길이 문자 데이터


number
-최대 40자리까지의 숫자 저장
-부호는 자리 차지않함.

number(p)
-p 자리수까지 의 최대 수치로 최대 38자리까지

number(p,s)]
-p는 전체 자리수, s는 소수점 이하 자리수

date
-날짜 형식 저장

rowid
- 테이블 내 행의 고유 주소를 가지는 문자

BLOB
- 대용량 바이너리 데이터를 저장, 최대 4GB까지

CLOB
- 대용량 텍스트 데이터 저장, 최대 4GB까지

BFILE
- 대용량 바이너리 데이터를 파일형태로 저장, 최대 4GB

TIMESTAMP
- DATE 형의 확장된 형태, 백만분의 일초 단위로 표현가능.

INTERVAL YEAR TO MONTH
- 년과 원을 이용하여 기간을 저장

INTERVAL DAY TO SECOND
- 일, 시, 초를 이용하여 기간을 저장

*/

/*
    테이블명과 컬럼명을 부여하기 위한 규칙
    1. 반드시 문자로 시작
    2. 길이는 1 ~ 30자 까지
    3. A ~ Z까지의 대소문자, 0 ~ 9까지의 숫자, 특수기호는(_, $, #)만 가능
    4. 오라클에서 사용되는 예약어나 다른 객체명과 중복 불가
    5. 공백 허용 안함.
*/
select * from tab;

create TABLE EMP01 (
empno number(4),
ename varchar2(20),
sal number(7, 2)
);

select * from emp01;
desc emp01;--구조 확인

create table emp02 as select * from emp; --서브쿼리 이용한 테이블 복사 생성
desc emp02;
select * from emp02;

create table emp03 as select * from emp where 1=0; --구조만 복사하여 테이블 생성
select * from emp03;


/*
테이블의 구조 변경
alter table : 테이블에서 컬럼의 추가, 삭제, 컬럼의 자료형이나 길이를 변경할 때 사용

add column      : 새로운 컬럼 추가
modify column   : 기존 컬럼 수정
drop column     : 기존 컬럼 삭제
*/
select * from emp01;
alter table emp01 add(job varchar2(9)); --컬럼 추가

/*
modify(컬럼명, 자료형(크기))
    1. 해당 컬럼에 자료가 없는 경우
        - 컬럼의 데이터 타입을 변경
        - 컬럼의 크기 변경 가능
    2. 해당 컬럼에 자료가 있는 경우
        - 컬럼의 데이터 타입 변경 불가
        - 컬럼의 크기를 키울 수는 있지만 줄일 수는 없음
*/
alter table emp01 modify(job varchar2(30));
desc emp01;

--drop(컬럼명)
alter table emp01 drop(job);

--테이블 삭제
drop table emp01;
drop table emp02;
drop table emp03;
select * from tab;

--휴지통 비우기
desc recyclebin;
select * from recyclebin;

purge recyclebin; --휴지통 비우기

--휴지통에 넣지 않고 바로 삭제

create table emp012 as select * from emp where 1=0;
drop table emp012 purge;

select * from tab;
ROLLBACK;

--rename : 테이블 명을 변경함 - rename 1 to 2
create table emp01 as select * from emp;

select * from emp01;

rename emp01 to emp02;

drop table emp02 purge;

/*
    truncate
    - 테이블의 모든 행을 제거함
    형식 : truncate table 테이블명
    
    1. truncate 하면 모든 행이 삭제됨 + 저장되던 저장공간까지 삭제됨 (롤백 불가)
    2. DDL(데이터정의언어)의 일종인 명령이므로 롤백 데이터가 생성되지 않는다.
        delete 명령으로 지워진건 롤백으로 복구되지만 얜 안됨
    3. 행의 인덱스도 같이 삭제된다.
    4. 외래키가 참조중인 테이블에는 사용이 불가능하다.
    5. 삭제 처리하는데 예기치 못한 문제가 발생할 수도 있다.
*/
select * from emp01;
truncate table emp01;
