# MISSION 1
-- 포켓몬 데이터베이스 만들기
create database pokemon;

-- 나의 포켓몬 테이블 만들기
## 1) USE 사용
use pokemon;
create table mypokemon (
number int,
name varchar(20),
type varchar(10)
);

## USE 사용X
create table pokemon.mypokemon (
number int,
name varchar(20),
type varchar(10)
);

-- pokemon 테이블 안에 각각의 포켓몬 데이터를 로우로 넣어주기
insert into mypokemon (number, name, type)
values (10, 'caterpie', 'bug'),
(25, 'pikachu', 'electric'),
(133, 'eevee', 'noraml');

select * from mypokemon; -- 데이터 전체를 조회하는 쿼리

# MISSION 2
-- pokemon DB안에 나의 새로운 포켓몬 테이블을 만들기
use pokemon;
create table mynewpokemon(
number int,
name varchar(20),
type varchar(10)
);
insert into mynewpokemon (number, name, type)
values (77, '포티타', '불꽃'),
(132, '메타몽', '노말'),
(151, '뮤', '에스퍼');

select * from mynewpokemon;