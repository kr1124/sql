select * from tab;

/*
    �����ͺ��̽� �����ڰ� ������ �ý��� ����
    
    CREATE USER      : ���Ӱ� ����ڸ� �����ϴ� ����
    DROP USER        : ����ڸ� �����ϴ� ����
    DROP ANY TABLE   : ������ ���̺��� �����ϴ� ����
    QUERY REWRITE    : �������� ���ۼ��� �� �ִ� ����
    BACKUP ANY TABLE : ������ ���̺��� ����� �� �ִ� ����
    
    �Ϲ� ������� �����ͺ��̽��� �����ϴ� ����
    
    CREATE SESSEION : �����ͺ��̽��� ������ �� �ִ� ����
    CREATE TABLE    : ����ڰ� ��Ű������ ���̺��� ������ �� �ִ� ����
    CREATE VIEW     : ����ڰ� ��Ű������ �並 ������ �� �ִ� ����
    CREATE SEQUENCE : ����ڰ� ��Ű������ �������� ������ �� �ִ� ����
*/
show user;

--create user ����ڰ��� identified by ��й�ȣ
--����ڰ����� ��ҹ��� ���� ����, ��й�ȣ�� ������.
create user BACKUPUSER identified by BACKUP1234;

--���� �ο�
grant connect, resource to backupuser;
grant create view to backupuser;
/*

*/
/*

*/
/*

*/