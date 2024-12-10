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

insert into tempmember values('aaaa', '1111', '가길동', '123456', '1234567', 'ga@naver.com', '010-1111-1111', '012-345', '서울특별시 영등포구 중동 신안빌딩 4층', '프로그래머');
insert into tempmember values('bbbb', '2222', '나닐동', '453243', '0687526', 'qwer@naver.com', '010-2222-3333', '657-765', '서울특별시 영등포구 중동 신안빌딩 5층', '프로그래머1');
insert into tempmember values('cccc', '3333', '다딜동', '567798', '8479384', 'asdf@naver.com', '010-5655-8876', '257-456', '서울특별시 영등포구 중동 신안빌딩 6층', '프로그래머2');

select * from tempmember;

