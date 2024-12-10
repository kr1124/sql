/*
    날짜 함수
*/

select sysdate-1 as 어제, sysdate+1 as 내일 from dual;
select sysdate, hiredate, months_between(sysdate, hiredate), round(months_between(sysdate, hiredate)), trunc(months_between(sysdate, hiredate)) from emp;
select sysdate, hiredate, months_between(sysdate, hiredate), round(months_between(sysdate, hiredate)) from emp;

select ename, hiredate from emp where deptno=10;
select ename, hiredate, add_months(hiredate, 3) from emp where deptno=10;

/*
    next_day
    해당 요일에 가장 가까운 날짜를 구하는 함수
    
    일요일부터 1, 월요일 2 ...
*/
select sysdate, next_day(sysdate, 3) from dual;
select sysdate, next_day(sysdate, '화') from dual;
select sysdate, next_day(sysdate, '화요일') from dual;

alter session set NLS_LANGUAGE=AMERICAN;
alter session set NLS_LANGUAGE=KOREAN;
select sysdate, next_day(sysdate, 'Tuesday') from dual;

select sysdate, last_day(sysdate) from dual; --해당 달의 마지막 날짜
select sysdate, round(sysdate) from dual;
select sysdate, round(sysdate, 'day') from dual;
select sysdate, round(sysdate, 'month') from dual;
select sysdate, round(sysdate, 'year') from dual;

select ename, hiredate, round(hiredate, 'month') from emp;
/*
    변환함수 : 자료형을 변환함
    
    TO_CHAR : 날짜형, 숫자형을
    TO_DATE : 
    TO_NUMBER : 
*/

/*
to_char(데이터, '표시 형식')

    YYYY    : 년도 4자리
    YY      : 년도 2자리
    MM      : 월을 숫자로
    MON     : 월을 알파벳으로
    DD      : 일
    DAY     : 요일
    DY      : 요일을 약어로
*/
select sysdate, to_char(sysdate, 'yyyy-dd-mm') from dual;
select ename, hiredate, to_char(hiredate, 'yyyy dd-mm/day') from emp;

select 0.0045 * 60 * 15 as "15분" from dual;

/*
시간 출력 형식
AM, PM
A.M, P.M

HH or HH12 : 12시
HH24 : 24시
MI : 분
SS : 초
*/
select to_char(sysdate, 'yyyy/mm/dd, hh24:mi,ss') from dual; --특수문자면 중간에 막 넣어도 되는듯


/*
to_date
*/
select sysdate, trunc(sysdate-to_date('2024/01/01', 'yyyy/mm/dd')) from dual;
select ename, hiredate from emp where hiredate=to_date('1981/02/20');
select ename, hiredate from emp where hiredate=to_date('1981-02.20'); --구분만 되면 뭐든 됨

/*
to_number
*/
select '10,000' + '20,000' from dual; --안됨
select to_number('10,000', '999,999') + to_number('20,000', '999,999') from dual;

/*
일반함수

NVL     : 첫번째 인자로 받은 NULL과 같으면 두번재 인자로 변경
DECODE  : 첫번째 인자로 받은 값을 조건에 맞춰 변경함(if문과 유사)
CASE    : 조건에 맞는 문장을 수행함(switch와 유사)
*/

--nvl
select nvl(comm, -1) from emp;
select ename, sal, nvl(comm, -1), job from emp order by job;
select ename, sal, comm, sal*12+nvl(comm, 0), job from emp order by sal desc;

select * from emp;

select empno, ename, job, mgr, to_char(mgr, '9999'), nvl(to_char(mgr, '9999'), 'ceo') from emp where mgr is null;


/*
decode(표현식, 조건1, 결과1,
                조건2, 결과2,
                조건3, 결과3)
*/
select deptno,
    decode(deptno, 
    10, 'accounting',
    20, 'research',
    30, 'sales',
    40, 'operations') 
    as dname
from emp;

--직급에 따른 보너스 지급을 decode로 표현
select * from emp;
select ename, job, sal, decode(job, 'MANAGER', sal*1.15, 'CLERK', sal*1.05, sal) as new_sal from emp;

/*
case
    조건에 따라 서로 다른 처리가 가능함
    
    case 표현식 when 조건식1 then 결과1
                 when 조건식2 then 결과2
                 when 조건식3 then 결과3
                 else 결과 n
    end
*/
select ename, deptno,
    case when deptno=10 then 'accounting'
        when deptno=20 then 'reserch'
        when deptno=30 then 'sales'
        end dname from emp;

select * from emp;

select ename, job, sal,
    case when job='ANALYST' then sal*1.05
        when job='SALESMAN' then sal*1.1
        when job='MANAGER' then sal*1.15
        when job='CLERK' then sal*1.2
        when job='PRESIDENT' then sal
        end as bonus from emp;

------------------------------------그룹 함수------------------------------------        
--합계
select sum(sal) from emp;
select to_char(sum(sal), '$99,000') from emp;

--min, max
select min(sal), max(sal) from emp;

--count
select count(*), COUNT(comm) from emp;
select count(distinct job) from emp; --중복제거 

select hiredate from emp;
select distinct trunc(hiredate, 'year') from emp;
select count(trunc(hiredate, 'year')) from emp;

select to_char(trunc(hiredate, 'year'), 'yy') as 연도 from emp;

select count(*) "total", sum(decode(to_char(hiredate, 'yyyy'), 1980, 1, 0)) "1980"
from emp;

--group by : 특정 컬럼 값을 기준으로 테이블을 그룹별로 나눔
select deptno, sum(sal), round(avg(sal)) from emp group by deptno;

select deptno, count(ename), count(comm) from emp group by deptno;

--having : 그룹의 결과를 제한할 때
select deptno, avg(sal) from emp group by deptno having avg(sal) >= 2000;

select deptno, max(sal), min(sal) from emp group by deptno;
select deptno, max(sal), min(sal) from emp group by deptno having max(sal) >= 3000;


/*
join
 - 한 개 이상의 테이블에서 원하는 결과를 얻고자 할 때 사용한다.
 
 1. Equi Join    : 동일 컬럼을 기준으로 조인한다.
 2. NonEqui Join : 동일 컬럼 없이 다른 조건을 사용하여 조인함.
 3. Outer Join   : 조인 조건에 만족하지 않는 행도 출력함.
 4. Self Join    : 한 테이블 내에서 조인함.

기본적인 규칙
 1. Primary Key(기본키)와 Foreign Key(외래키)를 통한 다른 테이블 행과 연결함
 2. 연결 Key 사용으로 테이블과 테이블이 결합함.
 3. where 절에서 조인 조건을 사용함
 4. 명확성을 위해 컬럼 이름 앞에 테이블명, 또는 테이블 별칭을 붙임
*/

/*
--equi join
    - 조인 대상이 되는 두 테이블에서 
    공통적으로 존재하는 컬럼의 값이 일치되는 행을 연결하여
    결과를 만들어내는 조인
*/
select deptno from emp;
select deptno from dept;
select * from dept;


select * from emp, dept where emp.deptno=dept.deptno;
select e.empno, e.ename, e.deptno, d.deptno from emp e, dept d where e.deptno=d.deptno;
select e.empno, e.ename, d,dname, e.dpetno, ;

/*
--non equi join
    - 조인 대상이 되는 두 테이블에서 컬럼의 값을 범위로 설정하여 결과를 만듦
*/
select * from salgrade;
select e.ename, e.sal, s.grade from emp e, salgrade s where e.sal between s.losal and s.hisal;
select e.ename, e.sal, s.grade from emp e, salgrade s where e.sal >= s.losal and e.sal<=s.hisal;

/*
outer join
    -행이 조인 조건을 만족하지 않을 경우 그 행은 결과에 나타나지 않게 되는데
    조인 조건에 만족하지 않아도 출력하는 조인
*/
select deptno from dept;
select distinct(deptno) from emp;

select e.ename, d.deptno, d.dname from emp e, dept d where e.deptno(+) = d.deptno order by deptno; --oracle식 조인
select e.ename, d.deptno, d.dname from emp e right outer join dept d on e.deptno = d.deptno; -- 위와 같음
select e.ename, e.deptno as Eno, d.deptno as Dno, d.dname from emp e, dept d; --일단 카르티시안 곱을 해 두 테이블을 합치고, 그 테이블의 컬럼을 뽑아냄.

/*
self join
    -자기 자신과 조인
    from 절 다음에 동일한 테이블명을 2번 기술하고 where 절에 조인 조건을 걸어주어야 함
    이대 서로 다른 테이블인 것처럼 인식 되도록 다른 별칭을 사용함.
*/
select work.ename, mana.mgr from emp work, emp mana;
select work.ename, manager.ename from emp work, emp manager where work.mgr = manager.empno;
select work.ename || '의 매니저는 ', manager.ename || '이다.' from emp work, emp manager where work.mgr = manager.empno;
select * from emp;



/*
ANSI join
    상용 데이터베이스의 표준 언어
    다른 DBMS와의 호환성을 위해서는 ANSI join을 사용하는 것이 좋다.

1. Cross join(카르티시안 곱)
    이전에는 쉼표(,)로 테이블을 구분하였으나 그 대신 cross join으로 지정하면 된다.
*/
select * from emp e cross join dept d; --on 못 씀

/*
2. Inner Join
    공통 컬럼을 '=' 비교 연산자를 통해서 같은 값을 가지는 행을 연결하는 방법
*/
select * from emp e inner join dept d on e.deptno=d.deptno; --on은 컬럼명이 달라도 됨.
select * from emp e inner join dept d using(deptno); --using은 컬럼명이 같아야 함.

/*
3. Natural Join
    조건 절을 생략하고 natural join을 사용하면 자동적으로 모든 컬럼을 대상으로
    공통컬럼을 조사하여 내부적으로 조인문을 생성한다.
*/
select * from emp e natural join dept d;

/*
4. Outer Join
    left(right) outer join : 왼쪽(또는 오른쪽)의 테이블의 값이 누락되지 않도록 함.
*/
select e.ename, d.deptno, d.dname from emp e right outer join dept d on d.deptno=e.deptno;

-------------------------------------------------------------------------------------------

select trunc(hiredate, 'year'), count(trunc(hiredate, 'year')) from emp group by trunc(hiredate, 'year');
with hire_year as (
    select trunc(hiredate, 'year') as hire_year from emp
)
select hire_year, count(hire_year) from hire_year group by hire_year;