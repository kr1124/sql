-------------------------------- ���Ἲ ���� ���� --------------------------------

/*
 - �߸��� �����Ͱ� �Էµ��� �ʵ��� ���Ἲ ���������� ������
 
 1. NOT NULL : NULL�� ������� ����
 2. UNIQUE : �׻� �����ؾ��ϴ� ����Ű�� ����
 3. PRIMARY KEY(�⺻Ű) : �÷����� �ݵ�� �����ؾ��ϰ� �����ϵ��� �Ϸ���
 4. FOREIGN KEY(�ܷ�Ű) : �ش� �÷����� �����Ǵ� ���̺��� �÷��� �ϳ� �̻�� ��ġ�ϵ��� �Ϸ���
 
 - ���Ἲ ���������� ����� ����
    ���Ἲ ���������� �����͸� �߰�, ����, �����ϴ� ��������
    ���Ἲ�� ������ �� �ֵ��� ������ �ִ� ���� �ǹ���
    
 - ���Ἲ
   - �����ͺ��̽� ���� �������� Ȯ�强�� �����ϴ� ���� �ǹ��ϰ�,
     ���������� �ٶ������� ���� �����Ͱ� ����Ǵ� ���� �����ϴ� ���� �ǹ���.
     
 - ���Ἲ ���������� ������ ����

    NOT NULL
    - NULL ���� ������� ����.
    
    UNIQUE
    - �ߺ��� ���� ������� ����.
    
    PRIMARY KEY
    - NOT NULL + UNIQUE
 
    FOREIGN KEY
    - �����Ǵ� ���̺��� �÷��� ���� �����ϸ� ���
    
    CHECK
    - ���� ������ �������� ������ ������ �����Ͽ� ������ ���� ����ϴ� ���� �ǹ�
*/

select * from tab;

drop table dept01;
drop table emp01 purge;

purge RECYCLEBIN;


-- NOT NULL
-- �����ȣ 4, ����� 10, ���� 9, �μ���ȣ 4
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
    ������̺� ����� ������ ������ �� �����ȣ�� ����̸��� �ݵ�� ����ǵ��� �ϱ� ���ؼ�
    ������̺��� ���� ��, �����ȣ�� �̸��� NOT NULL ���������� �����ؾ���.
    
    NOT NULL
    �ش� �÷��� NULL���� �߰��ϰų� NULL������ �����ϴ� ���� ���´�.
    ���������� ���̺� ��� �÷���, �ڷ��� ���Ŀ� NOT NULL �̶�� ���
    
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
    - Ư�� �ķ��� ���� �ڷᰡ �ߺ����� �ʰ� �ϴ� ���� �ǹ���.
    ��, ������ �÷��� ������ ������ ����ǰ� �ϴ� ��
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
    UNIQUE�� NULL�� ����
    - UNIQUE�� NULL���� ���ܷ� ������ -> NULL�� �ߺ�������
    
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

--���̺��� ������ �˾ƺ��� ��ɾ�
desc user_tables;
select TABLE_NAME FROM USER_TABLES ORDER BY TABLE_NAME DESC;

/*
    ���� ���� Ȯ��
    
    ���������� ���� �޽����� ���� ��Ȯ�� ������ �˱� ����
    ����Ŭ���� �������ִ� USER_CONSTRAINTS ������ ��ųʸ��� ����
    
    type
    C : check not null
    U : unique
    P : primary key
    R : foreign key
*/

select constraint_name, constraint_type, table_name from user_constraints;

-- ���� ������ ������ �÷� Ȯ��, position�� null�̸� check not null�ε� �ϴ�.
select * from user_cons_columns;


/*
    PRIMARY KEY ���� ����

    - �������� ������ ����
    - �ĺ� ����� ���� �÷��� �����ϸ鼭�� NULL�� ������ �ȵ�.
    - ��, UNIQUE �������ǰ� NOT NULL ���������� ��� �����ؾ���.
    
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
    ���� ���Ἲ ��������(�ܷ�Ű : FOREIGN KEY)
    
    ���� ���Ἲ
        �� ���̺� ������ �������迡�� ������
        
    �� : ���� �����ؾ��ϴ� ���̺� -> �� ���̺�
    �� : �ָ� �����ϴ� ���̺�     -> �ڽ� ���̺�
    
    �Ҽ�
        �� ���̺� ���� ���� ���Ἲ�̶� ������ ������ �ܷ�Ű ���������� ����ؾ߸� ����
        
        �ܷ�Ű ��������
        - �ڽ� ���̺��� ������̺��� �μ���ȣ �÷��� �θ����̺��� �μ����̺��� �μ���ȣ�� �θ�Ű�� �����ϴ� ���� �ǹ���
        
        �θ�Ű�� �Ǳ����� �÷��� �ݵ�� �θ����̺��� �⺻Ű�� ����Ű������
*/
select * from emp05;
insert into emp05 values(7566, 'jones', 'manager', 50); --foreign key ������ �ȵǾ� �־� �߰��� ������

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

--�ܷ�Ű ������ references�� ����ϸ� ��
create table emp05(
empno number(4) primary key,
ename varchar2(10) not null,
);
insert into emp05 values(7499, 'allen', 'salesman', 50); --50���� ���� �Է��� �Ұ���.
select constraint_name, constraint_type, table_name, r_constraint_name from user_constraints;


/*
    check ���� ����
    - �ԷµǴ� ���� üũ�Ͽ� ������ �� �̿��� ���� ������
    ���� �޽����� �Բ� ����� ������� ���ϰ� �ϴ� ��
0ppxlf   

*/

create table emp06(
empno number(4) primary key,
ename varchar2(10) not null,
gender varchar2(1) check (gender in('M', 'F'))
);
insert into emp06 values(1234, 'qwer', 'M');
insert into emp06 values(2345, 'asd', 'S'); --S�� �ȵ�


create table emp07(
empno number(4) primary key,
ename varchar2(10) not null,
sal number(7, 2) check (sal between 500 and 5000),
deptno number(4) references dept01(deptno)
);
insert into emp07 values(1234, 'qwer', 900, 20);
insert into emp07 values(14, 'qr', 100, 20); --���� ���
select constraint_name, constraint_type, table_name, search_condition, r_constraint_name from user_constraints;

/*
    ���������� �̸����� �����ϱ�
    - ����ڰ� �ǹ��ְ� ���� ���Ǹ��� ����Ͽ� ���� ���Ǹ����ε�
    � ���������� �����ߴ��� �� �� �ְ� �����ϴ� ���
    
    ����
        �÷��� ������ Ÿ�� constraint �������Ǹ� ��������Ÿ��
        
    ���� ���Ǹ��� ����Ģ
        ���̺�� �÷��� ������������
        
        ��) �⺻Ű ���� ���Ǹ� emp05_empno_pk�� �����ߴٸ�
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

--���̺� ������ ���� ������ �����ϴ� ���

create table empo04(
empno number(4),
ename varchar2(10) not null,
job varchar2(9),
deptno number(4),
primary key(empno),
unique(job),
foreign key(deptno) references dept01(deptno)
);

-- ���̺� �������� �÷��� ���� ���Ǹ��� ��������� �������� ���
-- constraint Ű���带 ����ϸ� ��

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
    �������� �����ϱ�
    
    1. �������� �߰�
        - ���̺� ������ ���� �Ŀ� ���������� �߰��ϱ� ���ؼ���
          alter table�� �߰��ؾ���
        - ����
            alter table ���̺��
            add constraint �������Ǹ� ��������Ÿ��(�÷���)
*/
create table emp01(
empno number(4),
ename varchar2(10),
job varchar2(9),
deptno number(4)
);

select constraint_name, constraint_type, table_name, r_constraint_name from user_constraints;
select * from user_constraints;

--�⺻Ű �߰�
alter table emp01 add primary key(empno);

--�ܷ�Ű �߰�, ���� �ѹ��� �ȵǿ�
alter table emp01 add constraint emp01_deptno_fk foreign key(deptno) references dept01(deptno);

/*
    ���� ���� �����ϱ�
        - ���� ������ �����ϱ� ���ؼ���
          drop constraint ������ �����ϰ��� �ϴ� ���� ���Ǹ��� ����ϸ� ��.
          
        - ����
          alter table ���̺��
          drop constraint �������Ǹ�
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

--�������� ���� ����
alter table emp05 drop constraint SYS_C0011111;

--�������Ǹ��� �ִ� ���
alter table emp05 drop constraint emp05_deptno_fk;


select * from user_constraints;
/*
    ���������� ��Ȱ��ȭ�� CASCADE
    - ������ ���� ������ ��� ������� �ʰ� �ϴ� ���� �ǹ���
    
    1. DISABLE CONSTRAINT : ���� ������ �Ͻ� ��Ȱ��ȭ
    2. ENABLE  CONSTRAINT : ��Ȱ���� ���������� �ٽ� Ȱ��ȭ
*/

DROP table dept01; --�����Ǵ� �⺻Ű�� �־� ��� �ȵ�.
alter table dept01 drop constraint SYS_C0011062; --���������� �ȵ�.

--�����ϴ� �ܷ�Ű�� ���� ã�Ƽ� ���
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

delete from dept01 where deptno=10; --���� : �ڽ� ���ڵ� ����
/*
������ ���ؼ��� ������ ���� ����� �ִ�.
    1.  emp01���� 10�� �μ��� �ش��ϴ� ����� ���� ��
        dept01���� 10�� �μ��� ����
    2.  ���� ���Ἲ�� �����̹Ƿ� �ܷ�Ű�� �����ϰ� ����
*/


/*
    �������� ��Ȱ��ȭ�� Ȱ��ȭ
    
    ���� ������ �����Ǹ� �׻� �� ��Ģ�� ���� ������ ���Ἲ�� �����
    ����Ŭ������ ���������� ��Ȱ��ȭ ��Ŵ���ν� ���������� �������� �ʰ�
    ���������� ����� ��� ������ �� ������, ��Ȱ��ȭ�� ���������� ���ϴ�
    �۾��� �� �Ŀ��� �ٽ� Ȱ��ȭ ���·� ����� �ָ� �ȴ�.
    
    -��Ȱ��ȭ�� ����
    alter table ���̺�� disable constraint �������Ǹ�;
    -Ȱ��ȭ�� ����
    alter table ���̺�� enable constraint �������Ǹ�;
*/

-- ��Ȱ��ȭ
alter table emp01 disable constraint emp01_empno_pk;
alter table emp01 disable constraint emp01_deptno_fk;

select constraint_name, constraint_type, table_name, r_constraint_name, status from user_constraints;

select * from dept01;
delete from dept01 where deptno=10;
rollback;

-- Ȱ��ȭ
alter table emp01 enable constraint emp01_deptno_fk;

/*
    cascade �ɼ�
    
    �θ� ���̺�� �ڽ� ���̺� ���� ���� ������ �Ǿ� ���� ��
    �θ� ���̺��� ���������� ��Ȱ��ȭ�ϸ� �̸� �����ϰ� �ִ�
    �ڽ� ���̺��� �������Ǳ��� ���� ��Ȱ��ȭ ��Ű�� �ɼ���

    ������ �θ� ���̺��� �⺻Ű�� ��Ȱ��ȭ �ϱ� ���� �ڽ� ���̺��� �ܷ�Ű�� ��Ȱ��ȭ�ؾ���
*/

--��Ȱ��ȭ
alter table dept01 disable primary key cascade;
--����
alter table dept01 drop primary key cascade;



