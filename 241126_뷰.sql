------------------------------ 뷰(VIEW) ------------------------------

/*
    뷰의 개념
    
    뷰란 실제 테이블에 저장된 데이터를 뷰를 통해서 볼 수 있는 것이다.
    
    뷰를 흔히 가상 테이블이라고 부르는데,
    이는 뷰를 거의 테이블과 동일하게 사용하기 때문이다.
    
    뷰는 물리적인 구조 테이블과는 달리 데이터 저장 공간이 없다.
    뷰는 단지 쿼리문을 저장하고 있는 객체라고 표현할 수 있다.
*/

create view view_emp01
as
select empno, ename, job, deptno from emp01 where deptno=10;

drop view view_emp01;

select * from view_emp01;
select empno from view_emp01;

drop table emp01;
create table emp01 as select * from emp;

select * from emp01;
/*
    뷰의 사용 목적
    - 직접적인 테이블 접근을 제한하기 위해서
    - 복잡한 질의를 쉽게 만들기 위해서
    
    뷰의 특징
    - 뷰는 테이블에 대한 제한을 가지고 테이블의 일부만 보일 수 있는 가상 테이블이다.
    - 뷰는 실제 자료를 갖고 있지 않지만, 뷰를 통해 테이블을 관리할 수 있다.
    - 하나의 테이블에 뷰의 개수는 제한이 없다.
    
    뷰의 생성과 조회
    - 뷰를 생성하기 위해서는 테이블생성과 같이 create문을 사용한다.
    
    기본 테이블
    - 뷰에 의해 제한적으로 접근해서 사용하는, 실질적으로 데이터를 저장하고 있는 물리적 테이블을 의미


    
    뷰 생성
    뷰는 테이블처럼 하나의 개체로서 테이블을 생성할 때와 유사하게 create view 명령어를 사용
    
    형식
    create [or replace][force:no force] view view_name
    as subquery
    [with check option]
    [with read only];
    -> 해당 뷰를 통해서는 select만 가능하며
    -> insert/update/delete를 사용할 수 없다.
    
    or replace : 새로운 뷰를 만들 수 있을 뿐만 아니라, 기존에 뷰가 존재하더라도
                삭제하지 않고 새로운 구조의 뷰로 변경할 수 있음.    
    
    force : 기본 테이블의 존재 여부에 상관없이 뷰를 생성한다.
    
    with check opton : 해당 뷰를 통해서 볼 수 있는 범위내에서만 updat 또는 insert가 가능함.
*/

select * from tab;
purge RECYCLEBIN;

create view view_emp10
as
select empno, ename, sal, deptno from emp01 where deptno=10;
select * from view_emp10;

--view 탐색
select * from user_views;

/*
뷰에 관련된 데이터 사전
    데이터 사전 user_views에 사용자가 생성한 모든 뷰에 대한 정의가 저장되어 있음.
    view_name : 뷰의 이름
    text :      칼럼과 뷰를 작성할 때 기술한 서브쿼리문이 저장되어있는 거
*/


/*
2. 뷰의 동작 원리
    - 사용자가 뷰에 대해서 질의를 하면 user_views에서 뷰에 대한 정의를 조회함
    - 기본 테이블에 대한 뷰의 접근 권한을 살핀다.
    - 뷰에 대한 질의를 기본 테이블에 대한 질의로 변환함
    - 기본 테이블에 대한 질의를 토앻 데이터를 검색함
    - 검색 결과 출력

뷰의 종류 (뷰를 정의하기 위해서 사용되는 기본 테이블,
            수에 따라 단순 뷰와 복합 뷰로 나눔);
            
        단순 뷰                           복합 뷰
------------------------------------------------------------
하나의 테이블로 샐성            여러개의 테이블로 생성
그룹 함수 사용 불가             그룹 함수 사용 가능
distinct 사용 불가              그룹 함수의 사용 가능
DML(insert\update\delete) 사용 가능   DML(              ) 사용 불가능  
*/

--단순 뷰, dml 명령어의 경우 기존 테이블에도 영향을 미침
select * from view_emp10;
insert into view_emp10 values(8000, 'angel', 7000, 10);

select * from emp01;

--단순 뷰의 컬럼에 별칭 부여
desc view_emp10;

create or replace
view view_emp(사원번호, 사원명, 급여, 부서번호)
as
select empno, ename, sal, deptno from emp01;

select * from view_emp where 부서번호=10;

--그룹 함수를 사용한 단순 뷰
create view view_sal
as
select deptno, sum(sal) as "SalSum", round(avg(sal)) as "SalAvg"
from emp01 group by deptno;

select * from view_sal;

/*
단순 뷰에 DML 명령어로 조작이 불가능한 경우
1. 뷰 정의에 포함되지 않은 컬럼 중에 기본 테이블을 컬럼이 NOT NULL 제약 조건이 지정되어 있는 경우
2. sal*12와 같이 산술 표현식으로 정의된 가상 컬럼이 뷰에 정의되면 insert나 update가 불가
3. distinct를 포함한 경우에도 dml 명령을 사용할 수 없다.
4. 그룹함수나 group by가 포함된 경우에도 dml 명령을 사용할 수 없다.
*/

--복합 뷰 : 두개 이상의 기본 테이블에 의해 정의된 뷰

create table dept01 as select * from dept;
create table dept01(
deptno number(2) constraint dept01_deptno_pk primary key,
dname varchar2(14),
loc varchar2(13)
);
select * from dept01;
drop table dept01;
drop table emp01;

create table emp01 (
empno number(4) constraint emp01_empno_pk primary key,
ename varchar2(10) constraint emp01_ename_nn not null,
job varchar2(9),
deptno number(2) constraint emp01_deptno_fk references dept01(deptno)
);

insert into dept01 select * from dept;
insert into emp01 select empno, ename, job, deptno from emp;

--복합 뷰 생성
create view view_emp_dept
as
select e.empno, e.ename, e.deptno, d.dname, d.loc from emp01 e, dept01 d where e.deptno=d.deptno order by e.empno desc;

create view view_emp_dept
as
select e.empno, e.ename, e.deptno, d.dname, d.loc from emp01 e inner join dept01 d on e.deptno=d.deptno order by e.empno desc;

select * from emp01;
select * from dept01;

select * from view_emp_dept;

select * from user_views;
/*
    뷰 삭제
    
    뷰는 실체가 없는 가상 테이블이기 때문에 뷰를 삭제한다는 것은 
    USER_VIEWS 데이터 딕셔너리에 저장되어 있는 뷰의 정의를 삭제하는 것이다.
*/
drop view view_emp_dept;

select * from tab;
purge RECYCLEBIN;
/*
    OR REPLACE : 뷰 수정
    
    - create view 대신 create or replace view를 사용하면
    존재하지 않은 뷰이면 새로운 뷰를 생성하고,
    기존에 존재하는 뷰라면 그 내용을 변경함
*/

create or replace view view_emp10
as
select empno, ename, job, deptno from emp01 
where deptno=10;

select view_name, text from user_views;

/*
    FORCE
    - 기본 테이블 없이 뷰를 생성하기 위한 옵션
*/

--존재하지 않는 emp08 테이블로 뷰 생성
create or replace force view view_notable 
as 
select empno, ename, deptno from emp08 where deptno=10;

select * from view_notable;

/*
    WITH CHECK OPTION
    뷰 생성시 조건으로 지정한 컬럼 값을 변경하지 못하도록 하는 것
*/

create or replace view view_chk20 
as 
select empno, ename, job, deptno from emp01 where deptno=20 with check option;

select * from view_chk20;

select * from emp01 where deptno=10;

update view_chk20 set deptno=20 where job='SALESMAN'; --0개 행 변경 : 한마디로 안바뀜

/*
    WITH READ ONLY
    뷰를 통해서는 기본테이블의 어떤 컬럼에 대해서도
    내용을 절대 변경할 수 없도록 하는 것
*/

create or replace view view_read30 
as 
select empno, ename, sal, comm, deptno from emp where deptno=30 with read only;

update view_read30 set comm=1000;

/*
    뷰 활용
    ROWNUM : 컬럼 이용, 오라클에서 내부적으로 부여되는데
    insert 문에 의해 입력한 순서에 따라 1씩 증가되면서 값이 저장됨.
*/

select * from emp;
select * from tab;

create table emp08 
as 
select * from emp;

create or replace view view_hire 
as 
select empno, ename, hiredate from emp08 
order by hiredate;

select rownum, empno, ename, hiredate from view_hire;

/*
    입사일을 기준으로 오름차순 정렬을 해도 해당 행의 rownum은 변하지 않는다.
    데이터 입력 시점에서 결정되면 다시는 값이 바뀌지 않기 때문이다.
    
    새로운 테이블에 입사일 기준으로 오름차순 정렬한 쿼리문의 결과를 저장하면
    입사일이 가장 빠른 사원이 제일 처음으로 입력되므로 
    rownum 컬럼 값이 1부터 부여됨.
*/
select rownum, empno, ename, hiredate from view_hire where rownum<=5;


-- 인라인 뷰로 TOP-N 분석
/*
    인라인 뷰는 SQL문장에서 사용하는 서브쿼리의 일종으로
    보통 from 절에 위치해 테이블처럼 사용하는 것임
    
    메인쿼리의 select 문의 from절 내부에 사용된 서브쿼리를 말함
    
    create view로 생성하는 것이 아니라 인라인뷰는 sql문 내부에 뷰를 정의하고
    이를 테이블처럼 사용하는 것이다.
*/

select deptno, max(hiredate) max_hiredate from emp08 group by deptno;

--위의 쿼리문을 안쪽 쿼리문, 즉 인라인 뷰로 지정, 각 부서별로 가장 최근에 입사한 사원보다 먼저 입사한 사원의 정보 출력
select src.empno, src.ename, src.hiredate, src.deptno, max_hiredate 
from emp08 src, (select deptno, max(hiredate) max_hiredate from emp08 group by deptno) des 
where src.deptno=des.deptno and src.hiredate < des.max_hiredate;


-- rowid  : row가 실제로 저장되어있는 공간으로 테이블 내의 고유 주소를 의미 (주소임)
-- rownum : 행의 주소 순서대로 부여됨. 근데 select 같은거 할때마다 새로 생기는거 보니 임시값인듯 (순서임)
select rowid, rownum, empno from emp08;


--가장 급여가 많은 사원 3명만 추출
select rownum, ename, sal from (select ename, sal from emp08 order by sal desc) where rownum<=3;

--가장 최근 입사자 5명
select rownum, ename, hiredate from (select ename, hiredate from emp08 order by hiredate desc) where rownum<=5;
