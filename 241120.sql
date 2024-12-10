/*
    ��¥ �Լ�
*/

select sysdate-1 as ����, sysdate+1 as ���� from dual;
select sysdate, hiredate, months_between(sysdate, hiredate), round(months_between(sysdate, hiredate)), trunc(months_between(sysdate, hiredate)) from emp;
select sysdate, hiredate, months_between(sysdate, hiredate), round(months_between(sysdate, hiredate)) from emp;

select ename, hiredate from emp where deptno=10;
select ename, hiredate, add_months(hiredate, 3) from emp where deptno=10;

/*
    next_day
    �ش� ���Ͽ� ���� ����� ��¥�� ���ϴ� �Լ�
    
    �Ͽ��Ϻ��� 1, ������ 2 ...
*/
select sysdate, next_day(sysdate, 3) from dual;
select sysdate, next_day(sysdate, 'ȭ') from dual;
select sysdate, next_day(sysdate, 'ȭ����') from dual;

alter session set NLS_LANGUAGE=AMERICAN;
alter session set NLS_LANGUAGE=KOREAN;
select sysdate, next_day(sysdate, 'Tuesday') from dual;

select sysdate, last_day(sysdate) from dual; --�ش� ���� ������ ��¥
select sysdate, round(sysdate) from dual;
select sysdate, round(sysdate, 'day') from dual;
select sysdate, round(sysdate, 'month') from dual;
select sysdate, round(sysdate, 'year') from dual;

select ename, hiredate, round(hiredate, 'month') from emp;
/*
    ��ȯ�Լ� : �ڷ����� ��ȯ��
    
    TO_CHAR : ��¥��, ��������
    TO_DATE : 
    TO_NUMBER : 
*/

/*
to_char(������, 'ǥ�� ����')

    YYYY    : �⵵ 4�ڸ�
    YY      : �⵵ 2�ڸ�
    MM      : ���� ���ڷ�
    MON     : ���� ���ĺ�����
    DD      : ��
    DAY     : ����
    DY      : ������ ����
*/
select sysdate, to_char(sysdate, 'yyyy-dd-mm') from dual;
select ename, hiredate, to_char(hiredate, 'yyyy dd-mm/day') from emp;

select 0.0045 * 60 * 15 as "15��" from dual;

/*
�ð� ��� ����
AM, PM
A.M, P.M

HH or HH12 : 12��
HH24 : 24��
MI : ��
SS : ��
*/
select to_char(sysdate, 'yyyy/mm/dd, hh24:mi,ss') from dual; --Ư�����ڸ� �߰��� �� �־ �Ǵµ�


/*
to_date
*/
select sysdate, trunc(sysdate-to_date('2024/01/01', 'yyyy/mm/dd')) from dual;
select ename, hiredate from emp where hiredate=to_date('1981/02/20');
select ename, hiredate from emp where hiredate=to_date('1981-02.20'); --���и� �Ǹ� ���� ��

/*
to_number
*/
select '10,000' + '20,000' from dual; --�ȵ�
select to_number('10,000', '999,999') + to_number('20,000', '999,999') from dual;

/*
�Ϲ��Լ�

NVL     : ù��° ���ڷ� ���� NULL�� ������ �ι��� ���ڷ� ����
DECODE  : ù��° ���ڷ� ���� ���� ���ǿ� ���� ������(if���� ����)
CASE    : ���ǿ� �´� ������ ������(switch�� ����)
*/

--nvl
select nvl(comm, -1) from emp;
select ename, sal, nvl(comm, -1), job from emp order by job;
select ename, sal, comm, sal*12+nvl(comm, 0), job from emp order by sal desc;

select * from emp;

select empno, ename, job, mgr, to_char(mgr, '9999'), nvl(to_char(mgr, '9999'), 'ceo') from emp where mgr is null;


/*
decode(ǥ����, ����1, ���1,
                ����2, ���2,
                ����3, ���3)
*/
select deptno,
    decode(deptno, 
    10, 'accounting',
    20, 'research',
    30, 'sales',
    40, 'operations') 
    as dname
from emp;

--���޿� ���� ���ʽ� ������ decode�� ǥ��
select * from emp;
select ename, job, sal, decode(job, 'MANAGER', sal*1.15, 'CLERK', sal*1.05, sal) as new_sal from emp;

/*
case
    ���ǿ� ���� ���� �ٸ� ó���� ������
    
    case ǥ���� when ���ǽ�1 then ���1
                 when ���ǽ�2 then ���2
                 when ���ǽ�3 then ���3
                 else ��� n
    end
*/
select ename, deptno,
    case when deptno=10 then 'accounting'
        when deptno=20 then 'reserch'
        when deptno=30 then 'sales'
        end dname from emp;

select * from emp;

select ename, job, sal,
    case when job='ANALYST' then sal*1.05
        when job='SALESMAN' then sal*1.1
        when job='MANAGER' then sal*1.15
        when job='CLERK' then sal*1.2
        when job='PRESIDENT' then sal
        end as bonus from emp;

------------------------------------�׷� �Լ�------------------------------------        
--�հ�
select sum(sal) from emp;
select to_char(sum(sal), '$99,000') from emp;

--min, max
select min(sal), max(sal) from emp;

--count
select count(*), COUNT(comm) from emp;
select count(distinct job) from emp; --�ߺ����� 

select hiredate from emp;
select distinct trunc(hiredate, 'year') from emp;
select count(trunc(hiredate, 'year')) from emp;

select to_char(trunc(hiredate, 'year'), 'yy') as ���� from emp;

select count(*) "total", sum(decode(to_char(hiredate, 'yyyy'), 1980, 1, 0)) "1980"
from emp;

--group by : Ư�� �÷� ���� �������� ���̺��� �׷캰�� ����
select deptno, sum(sal), round(avg(sal)) from emp group by deptno;

select deptno, count(ename), count(comm) from emp group by deptno;

--having : �׷��� ����� ������ ��
select deptno, avg(sal) from emp group by deptno having avg(sal) >= 2000;

select deptno, max(sal), min(sal) from emp group by deptno;
select deptno, max(sal), min(sal) from emp group by deptno having max(sal) >= 3000;


/*
join
 - �� �� �̻��� ���̺��� ���ϴ� ����� ����� �� �� ����Ѵ�.
 
 1. Equi Join    : ���� �÷��� �������� �����Ѵ�.
 2. NonEqui Join : ���� �÷� ���� �ٸ� ������ ����Ͽ� ������.
 3. Outer Join   : ���� ���ǿ� �������� �ʴ� �൵ �����.
 4. Self Join    : �� ���̺� ������ ������.

�⺻���� ��Ģ
 1. Primary Key(�⺻Ű)�� Foreign Key(�ܷ�Ű)�� ���� �ٸ� ���̺� ��� ������
 2. ���� Key ������� ���̺�� ���̺��� ������.
 3. where ������ ���� ������ �����
 4. ��Ȯ���� ���� �÷� �̸� �տ� ���̺��, �Ǵ� ���̺� ��Ī�� ����
*/

/*
--equi join
    - ���� ����� �Ǵ� �� ���̺��� 
    ���������� �����ϴ� �÷��� ���� ��ġ�Ǵ� ���� �����Ͽ�
    ����� ������ ����
*/
select deptno from emp;
select deptno from dept;
select * from dept;


select * from emp, dept where emp.deptno=dept.deptno;
select e.empno, e.ename, e.deptno, d.deptno from emp e, dept d where e.deptno=d.deptno;
select e.empno, e.ename, d,dname, e.dpetno, ;

/*
--non equi join
    - ���� ����� �Ǵ� �� ���̺��� �÷��� ���� ������ �����Ͽ� ����� ����
*/
select * from salgrade;
select e.ename, e.sal, s.grade from emp e, salgrade s where e.sal between s.losal and s.hisal;
select e.ename, e.sal, s.grade from emp e, salgrade s where e.sal >= s.losal and e.sal<=s.hisal;

/*
outer join
    -���� ���� ������ �������� ���� ��� �� ���� ����� ��Ÿ���� �ʰ� �Ǵµ�
    ���� ���ǿ� �������� �ʾƵ� ����ϴ� ����
*/
select deptno from dept;
select distinct(deptno) from emp;

select e.ename, d.deptno, d.dname from emp e, dept d where e.deptno(+) = d.deptno order by deptno; --oracle�� ����
select e.ename, d.deptno, d.dname from emp e right outer join dept d on e.deptno = d.deptno; -- ���� ����
select e.ename, e.deptno as Eno, d.deptno as Dno, d.dname from emp e, dept d; --�ϴ� ī��Ƽ�þ� ���� �� �� ���̺��� ��ġ��, �� ���̺��� �÷��� �̾Ƴ�.

/*
self join
    -�ڱ� �ڽŰ� ����
    from �� ������ ������ ���̺���� 2�� ����ϰ� where ���� ���� ������ �ɾ��־�� ��
    �̴� ���� �ٸ� ���̺��� ��ó�� �ν� �ǵ��� �ٸ� ��Ī�� �����.
*/
select work.ename, mana.mgr from emp work, emp mana;
select work.ename, manager.ename from emp work, emp manager where work.mgr = manager.empno;
select work.ename || '�� �Ŵ����� ', manager.ename || '�̴�.' from emp work, emp manager where work.mgr = manager.empno;
select * from emp;



/*
ANSI join
    ��� �����ͺ��̽��� ǥ�� ���
    �ٸ� DBMS���� ȣȯ���� ���ؼ��� ANSI join�� ����ϴ� ���� ����.

1. Cross join(ī��Ƽ�þ� ��)
    �������� ��ǥ(,)�� ���̺��� �����Ͽ����� �� ��� cross join���� �����ϸ� �ȴ�.
*/
select * from emp e cross join dept d; --on �� ��

/*
2. Inner Join
    ���� �÷��� '=' �� �����ڸ� ���ؼ� ���� ���� ������ ���� �����ϴ� ���
*/
select * from emp e inner join dept d on e.deptno=d.deptno; --on�� �÷����� �޶� ��.
select * from emp e inner join dept d using(deptno); --using�� �÷����� ���ƾ� ��.

/*
3. Natural Join
    ���� ���� �����ϰ� natural join�� ����ϸ� �ڵ������� ��� �÷��� �������
    �����÷��� �����Ͽ� ���������� ���ι��� �����Ѵ�.
*/
select * from emp e natural join dept d;

/*
4. Outer Join
    left(right) outer join : ����(�Ǵ� ������)�� ���̺��� ���� �������� �ʵ��� ��.
*/
select e.ename, d.deptno, d.dname from emp e right outer join dept d on d.deptno=e.deptno;

-------------------------------------------------------------------------------------------

select trunc(hiredate, 'year'), count(trunc(hiredate, 'year')) from emp group by trunc(hiredate, 'year');
with hire_year as (
    select trunc(hiredate, 'year') as hire_year from emp
)
select hire_year, count(hire_year) from hire_year group by hire_year;