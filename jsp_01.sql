select * from visit;

create table tempmember (
id varchar2(20) not null, 
passwd varchar2(20),
name varchar2(20),
mem_num1 varchar2(6),
mem_num2 varchar2(7),
e_mail varchar2(30),
phone varchar2(30),
zipcode varchar2(7),
address varchar2(60),
job varchar2(30),
PRIMARY KEY (id)
);

insert into tempmember values('aaaa', '1111', '���浿', '123456', '1234567', 'ga@naver.com', '010-1111-1111', '012-345', '����Ư���� �������� �ߵ� �žȺ��� 4��', '���α׷���');
insert into tempmember values('bbbb', '2222', '���ҵ�', '453243', '0687526', 'qwer@naver.com', '010-2222-3333', '657-765', '����Ư���� �������� �ߵ� �žȺ��� 5��', '���α׷���1');
insert into tempmember values('cccc', '3333', '�ٵ���', '567798', '8479384', 'asdf@naver.com', '010-5655-8876', '257-456', '����Ư���� �������� �ߵ� �žȺ��� 6��', '���α׷���2');

select * from tempmember;

