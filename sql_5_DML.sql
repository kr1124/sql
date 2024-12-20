-------------------------------DML(데이터 조작어)-------------------------------
/*
    insert, update, delete, select
    
    insert : 행 추가
    update : 내용 수정
    delete : 행 삭제
    select : 조회
*/
/*
    INSERT
    
    1. 특정한 컬럼에만 데이터를 입력하는 경우
        형식 : insert into 테이블명(컬럼명1, 컬럼명2, 컬럼명3....) values(컬럼값1, 컬럼값2, 컬럼값3....);
        
    2. 모든 컬럼에 데이터를 입력하는 경우
        형식 : insert into 테이블명 values(컬럼값1, 컬럼값2, 컬럼값3....);
        
    - 문자와 날짜 값은 반드시 싱글쿼터('') 사용
*/

create table dept01 (
    deptno  number(2),
    dname   varchar2(14),
    loc     varchar2(13)
);
desc dept01;
select * from dept01;

insert into dept01(deptno, dname, loc) values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept01 values(20, 'RESEARCH', 'DALLAS');
delete from dept01;

insert into dept01 select * from SCOTT.dept; --다른 테이블 데이터 전부 추가
--컬럼과 컬럼값의 개수가 안 맞으면 에러 발생

/*
     null 값의 삽입
     - 데이터 입력 시점에 해당 컬럼값을 모르거나 확정되지 않았을 때 사용
     - 암시적 방법, 명시적 방법
*/
desc dept01;
desc dept;

select * from dept01;

insert into dept01(deptno, dname) values('30', 'SALES'); --암시적 삽입
insert into dept01 values('40', 'OPERATIONS', null); --명시적
insert into dept01 values('40', '', null); --null 대신 싱글쿼터도 가능

/*
    update - 테이블의 내용을 수정하기 위함
    형식 : update 테이블명 set 컬럼명1=값1, 컬럼명2=값2, 컬럼명3=값3... where 조건
    where 조건을 사용하지 않을 경우는 모든 데이터가 수정된
    데이터를 모두 수정하지 안을 경우는 where 절을 사용하여 수정하고자하는 데이터만 수정한다.
*/
select * from emp01;

insert into emp01 select * from SCOTT.emp;

update emp01 set deptno=30; -- 모든 행의 값 수정
update emp01 set sal=sal * 1.1;

--update에 where를 추가하면 조건을 ㅁ나족하는 테이블의 특정 행만 변경할 수 있다.

update emp01 set hiredate=sysdate where substr(hiredate, 1, 2)='87';

/*
    테이블에서 2개 이상의 컬럼값 변경
        복수개의 컬럼값을 변경하려면 기존 set절에 컴마를 추가하고 컬럼명=값 추가 
*/
update emp01 set job='MANAGER', deptno=30 where dname='SCOTT';
update emp01 set hiredate=sysdate, sal=50, comm=4000 where dname='SCOTT';

/*
    테이블에 불필요한 행을 삭제하기 위한 delete
    - 테이블에 특정 행의 데이터를 삭제함
    형식
        delete from 테이블명
        where 조건식;
        
    -모든 데이터 삭제 -> delete 테이블명
*/

drop table dept01;
create table dept01 as select * from dept;

select * from dept01;

--데이터 전체 삭제
delete from dept01;
delete dept01;
rollback;

--일부 삭제
delete from dept01 where deptno=30;

purge recyclebin;