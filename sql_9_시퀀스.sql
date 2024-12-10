/*
    시퀀스
    
    오라클에만 있음.(MySQL에는 Auto increment)
  
    -시퀀스는 유일한 값을 생성해 주는 오라클의 객체  
    시퀀스를 생성하면 기본키와 같이 순차적으로 증가하는 컬럼을 자동적으로 생성할 수 있음
    
    
    시퀀스 생성 형식
    
    create sequence 시퀀스명
    start with n
    increment by n
    maxvalue n | no maxvalue
    minvalue n | no minvalue
    cycle | no cycle
    cache | no cache
    
    1. start with n
        시퀀스의 시작값을 지정함
        n을 1로 지정하면 1부터 순차적으로 번호가 증가함
        
    2. increment by n
        시퀀스의 증가값
        n이 2면 2씩 증가함 (1, 3, 5 ....)
    
    3. maxvalue n | no maxvalue
        시퀀스가 증가할 수 있는 최대값
        no maxvalue는 제한 없음
        
    4. minvalue n | no minvalue
        시퀀스 최소값 / no하면 제한 없음
        
    5. cycle | no cycle
        지정된 시퀀스값이 최대치에 도달하면 다시 최소값으로 돌아가도록 지정
        no면 최대값을 넘어서면 오류 발생 - 기본값
        
    6. cache | no cache
        메모리상의 시퀀스 값을 관리하도록 함
        기본값은 20
        no cache는 원칙적으로 메모리상에서 시퀀스를 관리하지 않음
    
*/
desc user_sequences;

-- 시퀀스 생성
create sequence emp_seq
start with 1 
increment by 1 
maxvalue 1000000;

-- 시퀀스를 사용하기 위해 emp 테이블에서 일부 컬럼의 구조만 복사해 테이블 생성
create table emp01 
as 
select empno, ename, hiredate from emp where 1=0; --내용은 뺌

-- 시퀀스를 통해 사원번호 자동 할당
insert into emp01 values(emp_seq.nextval, 'JULIA', SYSDATE);
select * from emp01;

-- emp_seq의 현재값을 알고싶을 때 : CURRVAL
select emp_seq.currval from dual;

/*
    currval - 현재 시퀀스 값
    nextval - 현재 시퀀스 값의 다음 값
    
    currval, nextval을 사용할 수 있는 경우
        1. 서브쿼리가 아닌 select 문
        2. insert문의 select 절
        2. insert문의 values 절
        4. update문의 set 절
        
    currval, nextval을 사용할 수 없는 경우
        1. view의 select 절
        2. distinct 키워드가 있는 select 절
        3. group by, having, order by 절이 있는 select 절
        4. select, delete, update의 서브쿼리
        5. create table, alter table 명령
*/


/*
    시퀀스 수정 및 삭제
*/
create table dept01 as select * from dept where 1=0; --내용은 뺌

create sequence dept_seq 
start with 10 
increment by 10 
maxvalue 30;

insert into dept01 values(dept_seq.nextval, 'ACCOUNTING', 'NEW YORK');
insert into dept01 values(dept_seq.nextval, 'RESEARCH', 'DALLAS');
insert into dept01 values(dept_seq.nextval, 'SALES', 'CHICAGO'); --최대값 초과 오류

/*
    nextval은 해당 시퀀스의 다음값을 자동으로 할당하면서 유효성을 검사함. currval++
    currval은 현재 값을 반환하고 그 값을 유지한다.
    
    시퀀스에 관한 데이터 딕셔너리(사전) user_sequences
    - 생성된 시퀀스의 정보를 확인하기 위한 데이터 사전
*/
--데이터 사전으로 시퀀스 정보 확인
select sequence_name, min_value, max_value, increment_by, cycle_flag from user_sequences;
select * from user_sequences;

/*
    시퀀스 값을 변경하려면 ALTER SEQUENCE 문을 사용해야한다.
    
    alter sequence 시퀀스명
    increment by n
    maxvalue n | no maxvalue
    minvalue n | no minvalue
    cycle | no cycle
    cache | no cache
*/
--dept_seq의 최대값 변경
alter sequence dept_seq
maxvalue 100000;

insert into dept01 values(dept_seq.nextval, 'SALES', 'CHICAGO'); 
insert into dept01 values(dept_seq.nextval, 'OPERATIONS', 'BOSTON'); 
insert into dept01 values(dept_seq.currval, 'a', 'a');
insert into dept01 values(dept_seq.currval, 'b', 'b'); 
insert into dept01 values(dept_seq.currval, 'c', 'c'); 

select * from dept01;



/*
    시퀀스 삭제는 drop
*/
drop sequence dept_seq;
drop table dept01;
