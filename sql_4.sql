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
    ���� ����
    
    - �ϳ��� select ������ �ȿ� �� �ϳ��� ���Ե� select �����̴�.
    
*/
select deptno from emp where ename='SCOTT';
select dname from dept where deptno=20;
--->
select dname from dept where deptno=(select deptno from emp where ename='SCOTT');

/*
    ���� �� ��������
    - �ϳ��� �ظ� �˻��Ͽ� �� ����� ���������� ����
*/
select deptno from emp where ename='JONES';
select dname from dept where deptno=(select deptno from emp where ename='JONES');

select ename, deptno from emp where deptno=(select deptno from emp where ename='SMITH');

select round(avg(sal)) from emp;
select ename, sal from emp where sal > (select round(avg(sal)) from emp);



/*
    ���� �� ��������
    - ������������ ��ȯ�Ǵ� ����� �ϳ� �̻��� �� ����ϴ� ��������
    - ���� �� ���������� �ݵ�� ���� �� �����ڿ� �Բ� ���
    
    ���� �� ������
    
    IN          : ���� ������ �� ������ ���� ������ �˻� ����� �ϳ��� ��ġ�ϸ� ��
    ANY, SOME   : ���� ������ �� ������ ���� ������ �˻� ����� �ϳ��̻��� ��ġ�ϸ� ��
    ALL         : ���� ������ �� ������ ���� ������ �˻� ����� ��� ���� ��ġ�ϸ� ��
    EXIST       : ���� ������ �� ������ ���� ������ �˻� ��� �߿��� �����ϴ� ���� �ϳ��� �����ϸ� ��
*/

-- in ������ : ����� 2�� �̻� �������� �������� ���������� ����Ұ�� ���� �� �����ڿ� �Բ� ����ؾ���
select distinct deptno from emp where sal>=3000;
select ename, sal, deptno from emp where deptno in (select distinct deptno from emp where sal>=3000);

select ename, hiredate from emp where deptno in (select deptno from emp where ename='BLAKE');


-- ALL ������
select max(sal) from emp where deptno=30;
select ename, sal from emp where sal > all (select max(sal) from emp where deptno=30);


-- ANY ������ : ���� ������ �� ������ ���� ������ �˻� ����� �ϳ��̻��� ��ġ�ϸ� ��
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
�ڷ���
char
- �������� ���� ������

varchar
- �������� ���� ������


number
-�ִ� 40�ڸ������� ���� ����
-��ȣ�� �ڸ� ��������.

number(p)
-p �ڸ������� �� �ִ� ��ġ�� �ִ� 38�ڸ�����

number(p,s)]
-p�� ��ü �ڸ���, s�� �Ҽ��� ���� �ڸ���

date
-��¥ ���� ����

rowid
- ���̺� �� ���� ���� �ּҸ� ������ ����

BLOB
- ��뷮 ���̳ʸ� �����͸� ����, �ִ� 4GB����

CLOB
- ��뷮 �ؽ�Ʈ ������ ����, �ִ� 4GB����

BFILE
- ��뷮 ���̳ʸ� �����͸� �������·� ����, �ִ� 4GB

TIMESTAMP
- DATE ���� Ȯ��� ����, �鸸���� ���� ������ ǥ������.

INTERVAL YEAR TO MONTH
- ��� ���� �̿��Ͽ� �Ⱓ�� ����

INTERVAL DAY TO SECOND
- ��, ��, �ʸ� �̿��Ͽ� �Ⱓ�� ����

*/

/*
    ���̺��� �÷����� �ο��ϱ� ���� ��Ģ
    1. �ݵ�� ���ڷ� ����
    2. ���̴� 1 ~ 30�� ����
    3. A ~ Z������ ��ҹ���, 0 ~ 9������ ����, Ư����ȣ��(_, $, #)�� ����
    4. ����Ŭ���� ���Ǵ� ���� �ٸ� ��ü��� �ߺ� �Ұ�
    5. ���� ��� ����.
*/
select * from tab;

create TABLE EMP01 (
empno number(4),
ename varchar2(20),
sal number(7, 2)
);

select * from emp01;
desc emp01;--���� Ȯ��

create table emp02 as select * from emp; --�������� �̿��� ���̺� ���� ����
desc emp02;
select * from emp02;

create table emp03 as select * from emp where 1=0; --������ �����Ͽ� ���̺� ����
select * from emp03;


/*
���̺��� ���� ����
alter table : ���̺��� �÷��� �߰�, ����, �÷��� �ڷ����̳� ���̸� ������ �� ���

add column      : ���ο� �÷� �߰�
modify column   : ���� �÷� ����
drop column     : ���� �÷� ����
*/
select * from emp01;
alter table emp01 add(job varchar2(9)); --�÷� �߰�

/*
modify(�÷���, �ڷ���(ũ��))
    1. �ش� �÷��� �ڷᰡ ���� ���
        - �÷��� ������ Ÿ���� ����
        - �÷��� ũ�� ���� ����
    2. �ش� �÷��� �ڷᰡ �ִ� ���
        - �÷��� ������ Ÿ�� ���� �Ұ�
        - �÷��� ũ�⸦ Ű�� ���� ������ ���� ���� ����
*/
alter table emp01 modify(job varchar2(30));
desc emp01;

--drop(�÷���)
alter table emp01 drop(job);

--���̺� ����
drop table emp01;
drop table emp02;
drop table emp03;
select * from tab;

--������ ����
desc recyclebin;
select * from recyclebin;

purge recyclebin; --������ ����

--�����뿡 ���� �ʰ� �ٷ� ����

create table emp012 as select * from emp where 1=0;
drop table emp012 purge;

select * from tab;
ROLLBACK;

--rename : ���̺� ���� ������ - rename 1 to 2
create table emp01 as select * from emp;

select * from emp01;

rename emp01 to emp02;

drop table emp02 purge;

/*
    truncate
    - ���̺��� ��� ���� ������
    ���� : truncate table ���̺��
    
    1. truncate �ϸ� ��� ���� ������ + ����Ǵ� ����������� ������ (�ѹ� �Ұ�)
    2. DDL(���������Ǿ��)�� ������ ����̹Ƿ� �ѹ� �����Ͱ� �������� �ʴ´�.
        delete ������� �������� �ѹ����� ���������� �� �ȵ�
    3. ���� �ε����� ���� �����ȴ�.
    4. �ܷ�Ű�� �������� ���̺��� ����� �Ұ����ϴ�.
    5. ���� ó���ϴµ� ����ġ ���� ������ �߻��� ���� �ִ�.
*/
select * from emp01;
truncate table emp01;
