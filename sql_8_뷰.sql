------------------------------ ��(VIEW) ------------------------------

/*
    ���� ����
    
    ��� ���� ���̺� ����� �����͸� �並 ���ؼ� �� �� �ִ� ���̴�.
    
    �並 ���� ���� ���̺��̶�� �θ��µ�,
    �̴� �並 ���� ���̺�� �����ϰ� ����ϱ� �����̴�.
    
    ��� �������� ���� ���̺���� �޸� ������ ���� ������ ����.
    ��� ���� �������� �����ϰ� �ִ� ��ü��� ǥ���� �� �ִ�.
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
    ���� ��� ����
    - �������� ���̺� ������ �����ϱ� ���ؼ�
    - ������ ���Ǹ� ���� ����� ���ؼ�
    
    ���� Ư¡
    - ��� ���̺� ���� ������ ������ ���̺��� �Ϻθ� ���� �� �ִ� ���� ���̺��̴�.
    - ��� ���� �ڷḦ ���� ���� ������, �並 ���� ���̺��� ������ �� �ִ�.
    - �ϳ��� ���̺� ���� ������ ������ ����.
    
    ���� ������ ��ȸ
    - �並 �����ϱ� ���ؼ��� ���̺������ ���� create���� ����Ѵ�.
    
    �⺻ ���̺�
    - �信 ���� ���������� �����ؼ� ����ϴ�, ���������� �����͸� �����ϰ� �ִ� ������ ���̺��� �ǹ�


    
    �� ����
    ��� ���̺�ó�� �ϳ��� ��ü�μ� ���̺��� ������ ���� �����ϰ� create view ��ɾ ���
    
    ����
    create [or replace][force:no force] view view_name
    as subquery
    [with check option]
    [with read only];
    -> �ش� �並 ���ؼ��� select�� �����ϸ�
    -> insert/update/delete�� ����� �� ����.
    
    or replace : ���ο� �並 ���� �� ���� �Ӹ� �ƴ϶�, ������ �䰡 �����ϴ���
                �������� �ʰ� ���ο� ������ ��� ������ �� ����.    
    
    force : �⺻ ���̺��� ���� ���ο� ������� �並 �����Ѵ�.
    
    with check opton : �ش� �並 ���ؼ� �� �� �ִ� ������������ updat �Ǵ� insert�� ������.
*/

select * from tab;
purge RECYCLEBIN;

create view view_emp10
as
select empno, ename, sal, deptno from emp01 where deptno=10;
select * from view_emp10;

--view Ž��
select * from user_views;

/*
�信 ���õ� ������ ����
    ������ ���� user_views�� ����ڰ� ������ ��� �信 ���� ���ǰ� ����Ǿ� ����.
    view_name : ���� �̸�
    text :      Į���� �並 �ۼ��� �� ����� ������������ ����Ǿ��ִ� ��
*/


/*
2. ���� ���� ����
    - ����ڰ� �信 ���ؼ� ���Ǹ� �ϸ� user_views���� �信 ���� ���Ǹ� ��ȸ��
    - �⺻ ���̺� ���� ���� ���� ������ ���ɴ�.
    - �信 ���� ���Ǹ� �⺻ ���̺� ���� ���Ƿ� ��ȯ��
    - �⺻ ���̺� ���� ���Ǹ� ��� �����͸� �˻���
    - �˻� ��� ���

���� ���� (�並 �����ϱ� ���ؼ� ���Ǵ� �⺻ ���̺�,
            ���� ���� �ܼ� ��� ���� ��� ����);
            
        �ܼ� ��                           ���� ��
------------------------------------------------------------
�ϳ��� ���̺�� ����            �������� ���̺�� ����
�׷� �Լ� ��� �Ұ�             �׷� �Լ� ��� ����
distinct ��� �Ұ�              �׷� �Լ��� ��� ����
DML(insert\update\delete) ��� ����   DML(              ) ��� �Ұ���  
*/

--�ܼ� ��, dml ��ɾ��� ��� ���� ���̺��� ������ ��ħ
select * from view_emp10;
insert into view_emp10 values(8000, 'angel', 7000, 10);

select * from emp01;

--�ܼ� ���� �÷��� ��Ī �ο�
desc view_emp10;

create or replace
view view_emp(�����ȣ, �����, �޿�, �μ���ȣ)
as
select empno, ename, sal, deptno from emp01;

select * from view_emp where �μ���ȣ=10;

--�׷� �Լ��� ����� �ܼ� ��
create view view_sal
as
select deptno, sum(sal) as "SalSum", round(avg(sal)) as "SalAvg"
from emp01 group by deptno;

select * from view_sal;

/*
�ܼ� �信 DML ��ɾ�� ������ �Ұ����� ���
1. �� ���ǿ� ���Ե��� ���� �÷� �߿� �⺻ ���̺��� �÷��� NOT NULL ���� ������ �����Ǿ� �ִ� ���
2. sal*12�� ���� ��� ǥ�������� ���ǵ� ���� �÷��� �信 ���ǵǸ� insert�� update�� �Ұ�
3. distinct�� ������ ��쿡�� dml ����� ����� �� ����.
4. �׷��Լ��� group by�� ���Ե� ��쿡�� dml ����� ����� �� ����.
*/

--���� �� : �ΰ� �̻��� �⺻ ���̺� ���� ���ǵ� ��

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

--���� �� ����
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
    �� ����
    
    ��� ��ü�� ���� ���� ���̺��̱� ������ �並 �����Ѵٴ� ���� 
    USER_VIEWS ������ ��ųʸ��� ����Ǿ� �ִ� ���� ���Ǹ� �����ϴ� ���̴�.
*/
drop view view_emp_dept;

select * from tab;
purge RECYCLEBIN;
/*
    OR REPLACE : �� ����
    
    - create view ��� create or replace view�� ����ϸ�
    �������� ���� ���̸� ���ο� �並 �����ϰ�,
    ������ �����ϴ� ���� �� ������ ������
*/

create or replace view view_emp10
as
select empno, ename, job, deptno from emp01 
where deptno=10;

select view_name, text from user_views;

/*
    FORCE
    - �⺻ ���̺� ���� �並 �����ϱ� ���� �ɼ�
*/

--�������� �ʴ� emp08 ���̺�� �� ����
create or replace force view view_notable 
as 
select empno, ename, deptno from emp08 where deptno=10;

select * from view_notable;

/*
    WITH CHECK OPTION
    �� ������ �������� ������ �÷� ���� �������� ���ϵ��� �ϴ� ��
*/

create or replace view view_chk20 
as 
select empno, ename, job, deptno from emp01 where deptno=20 with check option;

select * from view_chk20;

select * from emp01 where deptno=10;

update view_chk20 set deptno=20 where job='SALESMAN'; --0�� �� ���� : �Ѹ���� �ȹٲ�

/*
    WITH READ ONLY
    �並 ���ؼ��� �⺻���̺��� � �÷��� ���ؼ���
    ������ ���� ������ �� ������ �ϴ� ��
*/

create or replace view view_read30 
as 
select empno, ename, sal, comm, deptno from emp where deptno=30 with read only;

update view_read30 set comm=1000;

/*
    �� Ȱ��
    ROWNUM : �÷� �̿�, ����Ŭ���� ���������� �ο��Ǵµ�
    insert ���� ���� �Է��� ������ ���� 1�� �����Ǹ鼭 ���� �����.
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
    �Ի����� �������� �������� ������ �ص� �ش� ���� rownum�� ������ �ʴ´�.
    ������ �Է� �������� �����Ǹ� �ٽô� ���� �ٲ��� �ʱ� �����̴�.
    
    ���ο� ���̺� �Ի��� �������� �������� ������ �������� ����� �����ϸ�
    �Ի����� ���� ���� ����� ���� ó������ �ԷµǹǷ� 
    rownum �÷� ���� 1���� �ο���.
*/
select rownum, empno, ename, hiredate from view_hire where rownum<=5;


-- �ζ��� ��� TOP-N �м�
/*
    �ζ��� ��� SQL���忡�� ����ϴ� ���������� ��������
    ���� from ���� ��ġ�� ���̺�ó�� ����ϴ� ����
    
    ���������� select ���� from�� ���ο� ���� ���������� ����
    
    create view�� �����ϴ� ���� �ƴ϶� �ζ��κ�� sql�� ���ο� �並 �����ϰ�
    �̸� ���̺�ó�� ����ϴ� ���̴�.
*/

select deptno, max(hiredate) max_hiredate from emp08 group by deptno;

--���� �������� ���� ������, �� �ζ��� ��� ����, �� �μ����� ���� �ֱٿ� �Ի��� ������� ���� �Ի��� ����� ���� ���
select src.empno, src.ename, src.hiredate, src.deptno, max_hiredate 
from emp08 src, (select deptno, max(hiredate) max_hiredate from emp08 group by deptno) des 
where src.deptno=des.deptno and src.hiredate < des.max_hiredate;


-- rowid  : row�� ������ ����Ǿ��ִ� �������� ���̺� ���� ���� �ּҸ� �ǹ� (�ּ���)
-- rownum : ���� �ּ� ������� �ο���. �ٵ� select ������ �Ҷ����� ���� ����°� ���� �ӽð��ε� (������)
select rowid, rownum, empno from emp08;


--���� �޿��� ���� ��� 3�� ����
select rownum, ename, sal from (select ename, sal from emp08 order by sal desc) where rownum<=3;

--���� �ֱ� �Ի��� 5��
select rownum, ename, hiredate from (select ename, hiredate from emp08 order by hiredate desc) where rownum<=5;
