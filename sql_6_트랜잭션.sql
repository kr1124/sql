-------------------------------Transaction (Ʈ�����)-------------------------------
/*
    commit 
        - ��� �۾����� ���������� ó���ϰڴٰ� Ȯ���ϴ� ��ɾ��
          Ʈ������� ó�������� �����ͺ��̽��� ��� �ݿ��ϱ� ���ؼ� ����� ������ ���� ������
          
    rollback
        - �۾��� ������ �߻��Ǿ Ʈ������� ó�� �������� �߻��� ���� ������ ����ϴ� ���
          ������ ���·� �ǵ���

    savepoint
        - ������ Ʈ������� �۰� �����Ͽ� ó����
          ����� savepoint�� rollback to savepoint ���� ����Ͽ� ǥ���� ������ rollback ����
*/

delete from dept01;

select * from tab;
select * from dept01;

rollback;

commit; -- �۾� Ȯ��. rollback���� �ǵ��� �� ����.

savepoint cori;
--���� ���� ����, ���⿡�� ������ ������ ���� savepoint�� ���Ե�
--���� ���� �����߾��� savepoint�� ���� ���ư�

delete from dept01 where deptno = 30;
savepoint c1;
delete from dept01 where deptno = 20;
savepoint c2;
delete from dept01 where deptno = 10;
savepoint c3;

select * from dept01;

rollback to c1;
rollback to c2;
/*

*/