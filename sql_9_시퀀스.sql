/*
    ������
    
    ����Ŭ���� ����.(MySQL���� Auto increment)
  
    -�������� ������ ���� ������ �ִ� ����Ŭ�� ��ü  
    �������� �����ϸ� �⺻Ű�� ���� ���������� �����ϴ� �÷��� �ڵ������� ������ �� ����
    
    
    ������ ���� ����
    
    create sequence ��������
    start with n
    increment by n
    maxvalue n | no maxvalue
    minvalue n | no minvalue
    cycle | no cycle
    cache | no cache
    
    1. start with n
        �������� ���۰��� ������
        n�� 1�� �����ϸ� 1���� ���������� ��ȣ�� ������
        
    2. increment by n
        �������� ������
        n�� 2�� 2�� ������ (1, 3, 5 ....)
    
    3. maxvalue n | no maxvalue
        �������� ������ �� �ִ� �ִ밪
        no maxvalue�� ���� ����
        
    4. minvalue n | no minvalue
        ������ �ּҰ� / no�ϸ� ���� ����
        
    5. cycle | no cycle
        ������ ���������� �ִ�ġ�� �����ϸ� �ٽ� �ּҰ����� ���ư����� ����
        no�� �ִ밪�� �Ѿ�� ���� �߻� - �⺻��
        
    6. cache | no cache
        �޸𸮻��� ������ ���� �����ϵ��� ��
        �⺻���� 20
        no cache�� ��Ģ������ �޸𸮻󿡼� �������� �������� ����
    
*/
desc user_sequences;

-- ������ ����
create sequence emp_seq
start with 1 
increment by 1 
maxvalue 1000000;

-- �������� ����ϱ� ���� emp ���̺��� �Ϻ� �÷��� ������ ������ ���̺� ����
create table emp01 
as 
select empno, ename, hiredate from emp where 1=0; --������ ��

-- �������� ���� �����ȣ �ڵ� �Ҵ�
insert into emp01 values(emp_seq.nextval, 'JULIA', SYSDATE);
select * from emp01;

-- emp_seq�� ���簪�� �˰���� �� : CURRVAL
select emp_seq.currval from dual;

/*
    currval - ���� ������ ��
    nextval - ���� ������ ���� ���� ��
    
    currval, nextval�� ����� �� �ִ� ���
        1. ���������� �ƴ� select ��
        2. insert���� select ��
        2. insert���� values ��
        4. update���� set ��
        
    currval, nextval�� ����� �� ���� ���
        1. view�� select ��
        2. distinct Ű���尡 �ִ� select ��
        3. group by, having, order by ���� �ִ� select ��
        4. select, delete, update�� ��������
        5. create table, alter table ���
*/


/*
    ������ ���� �� ����
*/
create table dept01 as select * from dept where 1=0; --������ ��

create sequence dept_seq 
start with 10 
increment by 10 
maxvalue 30;

insert into dept01 values(dept_seq.nextval, 'ACCOUNTING', 'NEW YORK');
insert into dept01 values(dept_seq.nextval, 'RESEARCH', 'DALLAS');
insert into dept01 values(dept_seq.nextval, 'SALES', 'CHICAGO'); --�ִ밪 �ʰ� ����

/*
    nextval�� �ش� �������� �������� �ڵ����� �Ҵ��ϸ鼭 ��ȿ���� �˻���. currval++
    currval�� ���� ���� ��ȯ�ϰ� �� ���� �����Ѵ�.
    
    �������� ���� ������ ��ųʸ�(����) user_sequences
    - ������ �������� ������ Ȯ���ϱ� ���� ������ ����
*/
--������ �������� ������ ���� Ȯ��
select sequence_name, min_value, max_value, increment_by, cycle_flag from user_sequences;
select * from user_sequences;

/*
    ������ ���� �����Ϸ��� ALTER SEQUENCE ���� ����ؾ��Ѵ�.
    
    alter sequence ��������
    increment by n
    maxvalue n | no maxvalue
    minvalue n | no minvalue
    cycle | no cycle
    cache | no cache
*/
--dept_seq�� �ִ밪 ����
alter sequence dept_seq
maxvalue 100000;

insert into dept01 values(dept_seq.nextval, 'SALES', 'CHICAGO'); 
insert into dept01 values(dept_seq.nextval, 'OPERATIONS', 'BOSTON'); 
insert into dept01 values(dept_seq.currval, 'a', 'a');
insert into dept01 values(dept_seq.currval, 'b', 'b'); 
insert into dept01 values(dept_seq.currval, 'c', 'c'); 

select * from dept01;



/*
    ������ ������ drop
*/
drop sequence dept_seq;
drop table dept01;
