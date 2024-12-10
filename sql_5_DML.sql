-------------------------------DML(������ ���۾�)-------------------------------
/*
    insert, update, delete, select
    
    insert : �� �߰�
    update : ���� ����
    delete : �� ����
    select : ��ȸ
*/
/*
    INSERT
    
    1. Ư���� �÷����� �����͸� �Է��ϴ� ���
        ���� : insert into ���̺��(�÷���1, �÷���2, �÷���3....) values(�÷���1, �÷���2, �÷���3....);
        
    2. ��� �÷��� �����͸� �Է��ϴ� ���
        ���� : insert into ���̺�� values(�÷���1, �÷���2, �÷���3....);
        
    - ���ڿ� ��¥ ���� �ݵ�� �̱�����('') ���
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

insert into dept01 select * from SCOTT.dept;z --�ٸ� ���̺� ������ ���� �߰�
--�÷��� �÷����� ������ �� ������ ���� �߻�

/*
     null ���� ����
     - ������ �Է� ������ �ش� �÷����� �𸣰ų� Ȯ������ �ʾ��� �� ���
     - �Ͻ��� ���, ����� ���
*/
desc dept01;
desc dept;

select * from dept01;

insert into dept01(deptno, dname) values('30', 'SALES'); --�Ͻ��� ����
insert into dept01 values('40', 'OPERATIONS', null); --�����
insert into dept01 values('40', '', null); --null ��� �̱����͵� ����

/*
    update - ���̺��� ������ �����ϱ� ����
    ���� : update ���̺�� set �÷���1=��1, �÷���2=��2, �÷���3=��3... where ����
    where ������ ������� ���� ���� ��� �����Ͱ� ������
    �����͸� ��� �������� ���� ���� where ���� ����Ͽ� �����ϰ����ϴ� �����͸� �����Ѵ�.
*/
select * from emp01;

insert into emp01 select * from SCOTT.emp;

update emp01 set deptno=30; -- ��� ���� �� ����
update emp01 set sal=sal * 1.1;

--update�� where�� �߰��ϸ� ������ �������ϴ� ���̺��� Ư�� �ุ ������ �� �ִ�.

update emp01 set hiredate=sysdate where substr(hiredate, 1, 2)='87';

/*
    ���̺��� 2�� �̻��� �÷��� ����
        �������� �÷����� �����Ϸ��� ���� set���� �ĸ��� �߰��ϰ� �÷���=�� �߰� 
*/
update emp01 set job='MANAGER', deptno=30 where dname='SCOTT';
update emp01 set hiredate=sysdate, sal=50, comm=4000 where dname='SCOTT';

/*
    ���̺� ���ʿ��� ���� �����ϱ� ���� delete
    - ���̺� Ư�� ���� �����͸� ������
    ����
        delete from ���̺��
        where ���ǽ�;
        
    -��� ������ ���� -> delete ���̺��
*/

drop table dept01;
create table dept01 as select * from dept;

select * from dept01;

--������ ��ü ����
delete from dept01;
delete dept01;
rollback;

--�Ϻ� ����
delete from dept01 where deptno=30;

purge recyclebin;
