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

select * FROM emp;

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

/*
    sql�� �Լ�    
*/
--select * from dual;
select 24*60*60 from dual;
desc dual;

select deptno, sum(sal) from emp group by deptno HAVING detpno=30;


/*
    ������ �Լ�
*/
--�����Լ�
select * from emp;
select 'DataBase', upper('DataBase') from dual;
select ename, lower(ename) from emp where deptno = 10;
select empno, initcap(ename) from emp where deptno=10;

select length('Welcome to Globalin') from dual;

select empno, lower(ename) from emp where length(ename)=4;
select empno, ename, sal from emp where length(ename)>=6;

select instr('DataBase', 'a') from dual;
select instr('DataBase', 'a', 3, 1) from dual; --'DataBase'���� 'a'�� ã�µ� 3��°���� �����ؼ� 1��° a�� ã��

select substr('DataBase', 3) from dual;
select substr('DataBase', 2, 3) from dual;

select lpad('DataBase', 20 ) from dual;
select rpad('DataBase', 20, '$') from dual;

select trim(' 'from' database Programming') from dual;

select ename, trim('S' from ename), trim('H' from ename) from emp where ename='SMITH';

--�����Լ�
/*
    round : �ݿø�
    trunc : ����
    mod : ������
*/
select round(45.294339402, 1) FROM dual;
select round(45.294339402, 0) FROM dual;

select trunc(45.6543, 2) from dual;

select mod(100, 13) from dual;

select * from emp where mod(empno, 2)=1;
select * from emp;