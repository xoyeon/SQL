# select : 구축이 완료된 테이블에서 데이터를 추출하는 기능
# select (열 이름) from (테이블 이름) where (조건식)

drop database if exists market_db; -- market_db를 삭제
create database market_db; -- market_db 데이터베이스를 새로 만듬

/* # 회원 테이블(member) 만들기
use market_db; -- use는 market_db 데이터베이스를 선택하는 문장
create table member -- 회원 테이블(member)
(
mem_id char(8) not null primary key, -- 회원 아이디(PK)
mem_name varchar(10) not null, -- 이름 ## varchar는 문자를 입력하는 것
mem_number int not null, -- 인원수
addr char(2) not null, -- 주소(경기, 서울, 경남 식으로 두 글자만 입력)
phone1 char(3), -- 연락처의 국번(02, 031, 055 등)
phone2 char(8), -- 연락처의 나머지 전화번호(하이픈 제외)
height smallint, -- 평균 키
debut_date date -- 데뷔 일자
);

# 구매 테이블(buy) 만들기
create table buy -- 구매 테이블(buy)
(
num int auto_increment not null primary key, -- 순번(PK) ## auto_increment는 자동으로 숫자를 입력하는 것
mem_id char(8) not null, -- 아이디(FK)
prod_name char(6) not null, -- 제품 이름
group_name char(4), -- 분류
price int not null, -- 단가
amount smallint not null, -- 수량
foreign key (mem_id) references member(mem_id)
); */

# insert : 데이터 입력
insert into member values('TWC', '트와이스', 9, '서울', '02', '11111111', 167, '2015.10.19');
insert into buy values(NULL, 'BLK', '지갑', NULL, 30, 2); 

# 데이터 조회하기
select * from member;
select * from buy;

# use : 지금부터 이 db를 사용하겠으니 모든 쿼리는 이 db에서 실행하라
use market_db;
select * from member; # select * from market_db.member;
select mem_name from member;
select addr, debut_date, mem_name from member;
select * from member where mem_name = '블랙핑크';
select * from member where mem_name = 4;

select mem_id, mem_name from member
	where height <= 162;

select mem_name, height, mem_number from member
	where height >= 165 and mem_number > 6;
    
select mem_name, height, mem_number from member
	where height >= 165 or mem_number > 6;
    
select mem_name, height from member
	where height >= 163 and height <= 165;
    
select mem_name, height from member
	where height between 163 and 165;
    
select mem_name, addr from member
	where addr = '경기' or addr = '전남' or addr = '경남';
    
select mem_name, addr from member
	where addr in('경기', '전남', '경남');
    
select * from member
	where mem_name like '우%';
    
select * from member
	where mem_name like '__핑크';



