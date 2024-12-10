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