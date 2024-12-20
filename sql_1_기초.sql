/*
    sys - 오라클 슈퍼 사용자명, 데이터베이스에서 모든 일을 할 수 있음
    
    system - 유지 보수용 계정으로, 데이터베이스를 생성, 삭제할 수 있는 권한은 없음.
*/

show user;

select * from tab;
desc dept;
select * from dept;
/*
    number(3)
    number(precision, scale)
        - precision : 소수점을 포함한 전체 자릿수
        - scale : 소수점 이하 자릿수
        
    date - yy/mm/dd
    varchar2
        - 가변 길이 문자열 데이터
*/

select * from emp;

select ename, sal, comm, sal +comm, sal - 100, sal * 12, sal/2 from emp;
-- null은 연산, 할당, 비교 안되는 아무튼 존재하는 알 수 없는 값이다.

--별칭, 특수문자나 대소문자를 구분하고 싶다면 ""를 사용함
select ename, sal * 12 + comm as Annsal, sal as "Sa-la*ry" from emp;

select ename || ' is a ' || job from emp;
select ename || ' is a ' from emp;

--중복 제거
select distinct deptno from emp;

/*  
    조건 부여 : where
    = 같다.
    <> 같지 않다.
*/
select * from emp;
select empno, ename, sal from emp where sal>=2000;

/*
    문자열 데이터는 싱글쿼터로 사용
*/
select empno, ename from emp where ename='FORD';
select empno, ename from emp where ename>'FORD';

/*
    날짜 데이터 조회
*/
select ename, hiredate from emp;
select ename, hiredate from emp where hiredate >= '1982/01/01';
select ename, hiredate from emp where hiredate <= '1985/01/01';

/*
    논리 연산자
*/
select * from emp;
select ename, deptno, job from emp where deptno=10 and job='MANAGER';
select * from emp where deptno=10 or job='MANAGER';
select * from emp where not deptno=10;

select * from emp where sal>=1000 and sal<=3000;
--between
select empno as "사원번호", ename as "사원이름", sal as "급여" , comm as "커미션" from emp where sal between 1000 and 3000;

--in : 특정 필드가 여러개의 값중에 하나인 경우를 검색하고자 할때 사용
select ename, sal from emp where empno in(7844, 7654, 7521);

select ename, sal, comm from emp where comm in(300, 500, 1400);

--null을 위한 연산자 - is null, is not null
select ename, sal, comm from emp where comm=null; --일반 비교연산자 같은건 안됨
select ename, sal, comm from emp where comm is null; 
select ename, sal, comm from emp where comm is not null;



/*
    order by : 정렬
    쿼리문 맨 뒤에 기술.
    정렬의 기준이 되는 컬럼 이름 또는 select 절에서 명시된 별칭을 사용해야함
    
*/
select * from emp;
select * from emp order by sal;
select * from emp order by hiredate desc;


/*
    like 연산자
    - 검색하고자 하는 값을 정확히 모를 경우 와일드 카드와 같이 사용하여
    원하는 내용을 검색
    
    와일드 카드 : 
        % : 문자가 없거나, 하나 이상의 문자가 어떤 값이 오든 상관없다.
        _ : 하나의 문자가 어떤 값이 오든 상관 없다.    
*/
select * from emp;
select empno, ename from emp where ename like 'A%';
select empno, ename from emp where ename like '%K%'; --K가 포함됨
select empno, ename from emp where ename like '_LA__';
select empno, ename from emp where ename like '_A%'; --두번째가 A

select empno, ename from emp where not ename like '%A%';