SELECT * FROM tab;
drop table board;

create table board (
seq number(5) primary key,
title VARCHAR2(200),
writer VARCHAR2(20),
content VARCHAR2(2000),
regdate DATE DEFAULT sysdate,
cnt NUMBER(5) DEFAULT 0
);
INSERT into BOARD VALUES(1, '가입인사', '관리자', '적당한 내용의 반복이 적힌 내용', default, default);
SELECT * FROM BOARD;

CREATE TABLE users(
    id VARCHAR2(8) primary KEY,
    password VARCHAR2(8),
    name VARCHAR2(20),
    role VARCHAR2(5)
);
INSERT into USERS VALUES('test', '1234', '관리자', 'admin');
INSERT into USERS VALUES('user1', '1234', '홍길동', 'user');
SELECT * FROM USERS;


COMMIT;