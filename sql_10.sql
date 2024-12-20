select * from tab;

/*
    데이터베이스 관리자가 가지는 시스템 권한
    
    CREATE USER      : 새롭게 사용자를 생성하는 권한
    DROP USER        : 사용자를 삭제하는 권한
    DROP ANY TABLE   : 임의의 테이블을 삭제하는 권한
    QUERY REWRITE    : 쿼리문을 재작성할 수 있는 권한
    BACKUP ANY TABLE : 임의의 테이블을 백업할 수 있는 권한
    
    일반 사용자의 데이터베이스를 관리하는 권한
    
    CREATE SESSEION : 데이터베이스에 접속할 수 있는 권한
    CREATE TABLE    : 사용자가 스키마에서 테이블을 생성할 수 있는 권한
    CREATE VIEW     : 사용자가 스키마에서 뷰를 생성할 수 있는 권한
    CREATE SEQUENCE : 사용자가 스키마에서 시퀀스를 생성할 수 있는 권한
*/
show user;

--create user 사용자계정 identified by 비밀번호
--사용자계정은 대소문자 구분 없음, 비밀번호는 구분함.
create user BACKUPUSER identified by BACKUP1234;

--권한 부여
grant connect, resource to backupuser;
grant create view to backupuser;