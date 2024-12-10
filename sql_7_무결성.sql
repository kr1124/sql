-------------------------------- 무결성 제약 조건 --------------------------------

/*
 - 잘못된 데이터가 입력되지 않도록 무결성 제약조건을 지정함
 
 1. NOT NULL : NULL을 허용하지 않음
 2. UNIQUE : 항상 유일해야하는 고유키를 지정
 3. PRIMARY KEY(기본키) : 컬럼값은 반드시 존재해야하고 유일하도록 하려면
 4. FOREIGN KEY(외래키) : 해당 컬럼값이 참조되는 테이블의 컬럼에 하나 이상과 일치하도록 하려면
 
 - 무결성 제약조건의 개념과 종류
    무결성 제약조건은 데이터를 추가, 수정, 삭제하는 과정에서
    무결성을 유지할 수 있도록 제약을 주는 것을 의미함
    
 - 무결성
   - 데이터베이스 내에 데이터의 확장성을 유지하는 것을 의미하고,
     제약조건은 바람직하지 못한 데이터가 저장되는 것을 방지하는 것을 의미함.
     
 - 무결성 제약조건의 종류와 조건

    NOT NULL
    - NULL 값을 허용하지 않음.
    
    UNIQUE
    - 중복된 값을 허용하지 않음.
    
    PRIMARY KEY
    - NOT NULL + UNIQUE
 
    FOREIGN KEY
    - 참조되는 테이블의 컬럼의 값이 존재하면 허용
    
    CHECK
    - 저장 가능한 데이터의 범위나 조건을 지정하여 설정된 값만 허용하는 것을 의미
*/

select * from tab;

drop table dept01;
drop table emp01 purge;

purge RECYCLEBIN;


-- NOT NULL
-- 사원번호 4, 사원명 10, 직급 9, 부서번호 4
create table emp01(
empno number(4),
ename varchar2(10),
job varchar2(9),
deptno number(4)
);

desc emp01;
insert into emp01 values(NULL, NULL, 'SALESMAN', 30);
select * from emp01;

/*
    사원테이블에 사원의 정보를 저장할 때 사원번호와 사원이름이 반드시 저장되도록 하기 위해서
    사원테이블을 만들 때, 사원번호와 이름을 NOT NULL 제약조건을 지정해야함.
    
    NOT NULL
    해당 컬럼에 NULL값을 추가하거나 NULL값으로 변경하는 것을 막는다.
    제약조건은 테이블 명과 컬럼명, 자료형 이후에 NOT NULL 이라과 기술
    
*/

create table emp02(
empno number(4) NOT NULL,
ename varchar2(10) NOT NULL,
job varchar2(9),
deptno number(4)
);

insert into emp02 values(NULL, NULL, 'SALESMAN', 30);

/*  
    UNIQUE
    - 특정 컴럼에 대해 자료가 중복되지 않게 하는 것을 의미함.
    즉, 지정된 컬럼에 유일한 값들이 저장되게 하는 것
*/

create table emp03(
empno number(4) NOT NULL UNIQUE,
ename varchar2(10) NOT NULL,
job varchar2(9),
deptno number(4)
);
desc emp03;

select * from emp;

insert into emp03 values(7777, 'jay', 'sale', 80);
insert into emp03 values(7777, 'kay', 'manage', 80);

/*
    UNIQUE와 NULL의 관계
    - UNIQUE는 NULL값을 예외로 간주함 -> NULL은 중복가능함
    
*/

create table emp04(
empno number(4) UNIQUE,
ename varchar2(10) NOT NULL,
job varchar2(9),
deptno number(4)
);

select * from emp04;

insert into emp04 values(null, 'jay', 'sale', 80);
insert into emp04 values(null, 'kay', 'manage', 80);

--테이블의 정보를 알아보는 멸령어
desc user_tables;
select TABLE_NAME FROM USER_TABLES ORDER BY TABLE_NAME DESC;

/*
    제약 조건 확인
    
    제약조건의 에러 메시지에 대한 정확한 원인을 알기 위해
    오라클에서 제공해주는 USER_CONSTRAINTS 데이터 딕셔너리에 있음
    
    type
    C : check not null
    U : unique
    P : primary key
    R : foreign key
*/

select constraint_name, constraint_type, table_name from user_constraints;

-- 제약 조건이 지정된 컬럼 확인, position이 null이면 check not null인듯 하다.
select * from user_cons_columns;


/*
    PRIMARY KEY 제약 조건

    - 데이터의 구분을 위함
    - 식별 기능을 갖는 컬럼은 유일하면서도 NULL이 있으면 안됨.
    - 즉, UNIQUE 제약조건과 NOT NULL 제약조건을 모두 충족해야함.
    
*/
create table emp05(
empno number(4) primary key,
ename varchar2(10) not null,
job varchar2(9),
deptno number(4)
);
desc emp05;

insert into emp05 values(7499, 'allen', 'salesman', 30);


/*
    참조 무결성 제약조건(외래키 : FOREIGN KEY)
    
    참조 무결성
        두 테이블 사이의 주종관계에서 설정됨
        
    주 : 먼저 존재해야하는 테이블 -> 부 테이블
    종 : 주를 참조하는 테이블     -> 자식 테이블
    
    소속
        두 테이블 간의 참조 무결성이란 개념을 포함한 외래키 제약조건을 명시해야만 설정
        
        외래키 제약조건
        - 자식 테이블인 사원테이블의 부서번호 컬럼에 부모테이블인 부서테이블의 부서번호를 부모키로 설정하는 것을 의미함
        
        부모키가 되기위한 컬럼은 반드시 부모테이블의 기본키나 유일키여야함
*/
select * from emp05;
insert into emp05 values(7566, 'jones', 'manager', 50); --foreign key 설정이 안되어 있어 추가가 가능함

drop table emp05;
select * from tab;
desc dept;

create table dept01(
deptno number(2) primary key,
dname varchar2(14),
loc varchar2(13)
);
insert into dept01 values(10, 'accouonting', 'new york');
delete from dept01 where deptno=10;

insert into dept01 select * from SCOTT.dept;

select * from dept01;

--외래키 설정은 references를 기술하면 됨
create table emp05(
empno number(4) primary key,
ename varchar2(10) not null,
);
insert into emp05 values(7499, 'allen', 'salesman', 50); --50번이 없어 입력이 불가함.
select constraint_name, constraint_type, table_name, r_constraint_name from user_constraints;


/*
    check 제약 조건
    - 입력되는 값을 체크하여 설정된 값 이외의 값이 들어오면
    오류 메시지와 함께 명령이 수행되지 못하게 하는 것
0ppxlf   

*/

create table emp06(
empno number(4) primary key,
ename varchar2(10) not null,
gender varchar2(1) check (gender in('M', 'F'))
);
insert into emp06 values(1234, 'qwer', 'M');
insert into emp06 values(2345, 'asd', 'S'); --S는 안됨


create table emp07(
empno number(4) primary key,
ename varchar2(10) not null,
sal number(7, 2) check (sal between 500 and 5000),
deptno number(4) references dept01(deptno)
);
insert into emp07 values(1234, 'qwer', 900, 20);
insert into emp07 values(14, 'qr', 100, 20); --범위 벗어남
select constraint_name, constraint_type, table_name, search_condition, r_constraint_name from user_constraints;

/*
    제약조건을 이름으로 지정하기
    - 사용자가 의미있게 제약 조건명을 명시하여 제약 조건명만으로도
    어떤 제약조건을 위배했는지 알 수 있게 지정하는 방법
    
    형식
        컬럼명 데이터 타입 constraint 제약조건명 제약조건타입
        
    제약 조건명의 명명규칙
        테이블명 컬럼명 제약조건유형
        
        예) 기본키 제약 조건명 emp05_empno_pk로 지정했다면
        -> EMP05 EMPNO PK -> EMP05_EMPNO_PK
*/

/*
select * from tab;
drop table emp05;

create table empo05(
emb varchar2(9) constraint emp05_job_UK ui,references dept01(deptno)
);
EMPNO PK -> EMP05_EMPNO_PK

*/

select * from tab;
drop table emp05;

create table emp05(
job varchar2(9),
deptno number(4) constraint emp05_job_UK references dept01(deptno)
);
insert into emp05 values('wlke', 20);
select * from emp05;

--테이블 레벨로 제약 조건을 지정하는 방식

create table empo04(
empno number(4),
ename varchar2(10) not null,
job varchar2(9),
deptno number(4),
primary key(empno),
unique(job),
foreign key(deptno) references dept01(deptno)
);

-- 테이블 레벨에서 컬럼의 제약 조건명을 명시적으로 지정해줄 경우
-- constraint 키워드를 사용하면 됨

create table emp03 (
empno number(4),
ename varchar2(10) constraint emp03_ename_nn not null,
job varchar2(9),
deptno number(4),
constraint emp03_empno_pk primary key(empno),
constraint emp03_job_uk unique(job),
constraint emp03_deptno_fk foreign key(deptno) references dept01(deptno)
);

select constraint_name, constraint_type, table_name, search_condition, r_constraint_name from user_constraints;

/*
    제약조건 변경하기
    
    1. 제약조건 추가
        - 테이블 생성이 끝난 후에 제약조건을 추가하기 위해서는
          alter table로 추가해야함
        - 형식
            alter table 테이블명
            add constraint 제약조건명 제약조건타입(컬럼명)
*/
create table emp01(
empno number(4),
ename varchar2(10),
job varchar2(9),
deptno number(4)
);

select constraint_name, constraint_type, table_name, r_constraint_name from user_constraints;
select * from user_constraints;

--기본키 추가
alter table emp01 add primary key(empno);

--외래키 추가, 뭐야 롤백이 안되요
alter table emp01 add constraint emp01_deptno_fk foreign key(deptno) references dept01(deptno);

/*
    제약 조건 제거하기
        - 제약 조건을 제거하기 위해서는
          drop constraint 다음에 제거하고자 하는 제약 조건명을 명시하면 됨.
          
        - 형식
          alter table 테이블명
          drop constraint 제약조건명
*/


select * from tab;
create table emp05(
empno number(4),
ename varchar2(10),
job varchar2(9),
deptno number(4)
);
select * from emp05;

alter table emp05 add constraint emp05_deptno_fk foreign key(deptno) references dept01(deptno);

insert into emp05 values(7499, 'allen', 'MANAGER', 50);
delete from emp05;

--제약조건 제거 예시
alter table emp05 drop constraint SYS_C0011111;

--제약조건명이 있는 경우
alter table emp05 drop constraint emp05_deptno_fk;


select * from user_constraints;
/*
    제약조건의 비활성화와 CASCADE
    - 설정된 제약 조건을 잠시 사용하지 않게 하는 것을 의미함
    
    1. DISABLE CONSTRAINT : 제약 조건을 일시 비활성화
    2. ENABLE  CONSTRAINT : 비활성된 제약조건을 다시 활성화
*/

DROP table dept01; --참조되는 기본키가 있어 드랍 안됨.
alter table dept01 drop constraint SYS_C0011062; --마찬가지로 안됨.

--참조하는 외래키들 전부 찾아서 드랍
select constraint_name, constraint_type, table_name, r_constraint_name from user_constraints where r_constraint_name='SYS_C0011062';
alter table emp01 drop constraint emp01_deptno_fk;
alter table emp03 drop constraint emp03_deptno_fk;
alter table emp07 drop constraint sys_c0011072;


create table dept01(
deptno number(2) constraint dept01_deptno_pk primary key,
dname varchar2(14),
loc varchar2(13)
);

select constraint_name, constraint_type, table_name, r_constraint_name from user_constraints;

insert into dept01 select * from SCOTT.dept;

drop table emp01;
create table emp01(
empno number(4) constraint emp01_empno_pk primary key,
ename varchar2(10) constraint emp01_ename_nn not null,
job varchar2(9),
deptno number(2) constraint emp01_deptno_fk references dept01(deptno)
);

insert into emp01 values(7499, 'ALLEN', 'SALESMAN', 10);
insert into emp01 values(7369, 'SMITH', 'CLERK', 20);
select * from emp01;

delete from dept01 where deptno=10; --오류 : 자식 레코드 존재
/*
삭제를 위해서는 다음과 같은 방법이 있다.
    1.  emp01에서 10번 부서에 해당하는 사원을 삭제 후
        dept01에서 10번 부서를 삭제
    2.  참조 무결성이 문제이므로 외래키를 제거하고 삭제
*/


/*
    제약조건 비활성화와 활성화
    
    제약 조건이 설정되면 항상 그 규칙에 따라 데이터 무결성이 보장됨
    오라클에서는 제약조건을 비활성화 시킴으로써 제약조건을 삭제하지 않고도
    제약조건의 사용을 잠시 보류할 수 있으며, 비활성화된 제약조건은 원하는
    작업을 한 후에는 다시 활성화 상태로 만들어 주면 된다.
    
    -비활성화의 형식
    alter table 테이블명 disable constraint 제약조건명;
    -활성화의 형식
    alter table 테이블명 enable constraint 제약조건명;
*/

-- 비활성화
alter table emp01 disable constraint emp01_empno_pk;
alter table emp01 disable constraint emp01_deptno_fk;

select constraint_name, constraint_type, table_name, r_constraint_name, status from user_constraints;

select * from dept01;
delete from dept01 where deptno=10;
rollback;

-- 활성화
alter table emp01 enable constraint emp01_deptno_fk;

/*
    cascade 옵션
    
    부모 테이블과 자식 테이블 간의 참조 설정이 되어 있을 때
    부모 테이블의 제약조건을 비활성화하면 이를 참조하고 있는
    자식 테이블의 제약조건까지 같이 비활성화 시키는 옵션임

    원래는 부모 테이블의 기본키를 비활성화 하기 전에 자식 테이블의 외래키를 비활성화해야함
*/

--비활성화
alter table dept01 disable primary key cascade;
--삭제
alter table dept01 drop primary key cascade;



