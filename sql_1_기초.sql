/*
    sys - ����Ŭ ���� ����ڸ�, �����ͺ��̽����� ��� ���� �� �� ����
    
    system - ���� ������ ��������, �����ͺ��̽��� ����, ������ �� �ִ� ������ ����.
*/

show user;

select * from tab;
desc dept;
select * from dept;
/*
    number(3)
    number(precision, scale)
        - precision : �Ҽ����� ������ ��ü �ڸ���
        - scale : �Ҽ��� ���� �ڸ���
        
    date - yy/mm/dd
    varchar2
        - ���� ���� ���ڿ� ������
*/

select * from emp;

select ename, sal, comm, sal +comm, sal - 100, sal * 12, sal/2 from emp;
-- null�� ����, �Ҵ�, �� �ȵǴ� �ƹ�ư �����ϴ� �� �� ���� ���̴�.

--��Ī, Ư�����ڳ� ��ҹ��ڸ� �����ϰ� �ʹٸ� ""�� �����
select ename, sal * 12 + comm as Annsal, sal as "Sa-la*ry" from emp;

select ename || ' is a ' || job from emp;
select ename || ' is a ' from emp;

--�ߺ� ����
select distinct deptno from emp;

/*  
    ���� �ο� : where
    = ����.
    <> ���� �ʴ�.
*/
select * from emp;
select empno, ename, sal from emp where sal>=2000;

/*
    ���ڿ� �����ʹ� �̱����ͷ� ���
*/
select empno, ename from emp where ename='FORD';
select empno, ename from emp where ename>'FORD';

/*
    ��¥ ������ ��ȸ
*/
select ename, hiredate from emp;
select ename, hiredate from emp where hiredate >= '1982/01/01';
select ename, hiredate from emp where hiredate <= '1985/01/01';

/*
    �� ������
*/
select * from emp;
select ename, deptno, job from emp where deptno=10 and job='MANAGER';
select * from emp where deptno=10 or job='MANAGER';
select * from emp where not deptno=10;

select * from emp where sal>=1000 and sal<=3000;
--between
select empno as "�����ȣ", ename as "����̸�", sal as "�޿�" , comm as "Ŀ�̼�" from emp where sal between 1000 and 3000;

--in : Ư�� �ʵ尡 �������� ���߿� �ϳ��� ��츦 �˻��ϰ��� �Ҷ� ���
select ename, sal from emp where empno in(7844, 7654, 7521);

select ename, sal, comm from emp where comm in(300, 500, 1400);

--null�� ���� ������ - is null, is not null
select ename, sal, comm from emp where comm=null; --�Ϲ� �񱳿����� ������ �ȵ�
select ename, sal, comm from emp where comm is null; 
select ename, sal, comm from emp where comm is not null;



/*
    order by : ����
    ������ �� �ڿ� ���.
    ������ ������ �Ǵ� �÷� �̸� �Ǵ� select ������ ��õ� ��Ī�� ����ؾ���
    
*/
select * from emp;
select * from emp order by sal;
select * from emp order by hiredate desc;


/*
    like ������
    - �˻��ϰ��� �ϴ� ���� ��Ȯ�� �� ��� ���ϵ� ī��� ���� ����Ͽ�
    ���ϴ� ������ �˻�
    
    ���ϵ� ī�� : 
        % : ���ڰ� ���ų�, �ϳ� �̻��� ���ڰ� � ���� ���� �������.
        _ : �ϳ��� ���ڰ� � ���� ���� ��� ����.    
*/
select * from emp;
select empno, ename from emp where ename like 'A%';
select empno, ename from emp where ename like '%K%'; --K�� ���Ե�
select empno, ename from emp where ename like '_LA__';
select empno, ename from emp where ename like '_A%'; --�ι�°�� A

select empno, ename from emp where not ename like '%A%';

