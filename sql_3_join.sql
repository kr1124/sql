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