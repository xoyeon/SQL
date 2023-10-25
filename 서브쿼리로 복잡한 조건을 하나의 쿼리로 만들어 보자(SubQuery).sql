# 포켓몬 데이터 입력 쿼리
DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
number INT,
name VARCHAR(20)
);
INSERT INTO mypokemon (number, name)
VALUES (10, 'caterpie'),
(25, 'pikachu'),
(26, 'raichu'),
(133, 'eevee'),
(152, 'chikoirita');
CREATE TABLE ability (
number INT,
type VARCHAR(10),
height FLOAT,
weight FLOAT,
attack INT,
defense INT,
speed int
);
INSERT INTO ability (number, type, height, weight, attack, defense, speed)
VALUES (10, 'bug', 0.3, 2.9, 30, 35, 45),
(25, 'electric', 0.4, 6, 55, 40, 90),
(26, 'electric', 0.8, 30, 90, 55, 110),
(133, 'normal', 0.3, 6.5, 55, 50, 55),
(152, 'grass', 0.9, 6.4, 49, 65, 45);

# MISSION (1) 내 포켓몬 중에 몸무게가 가장 많이 나가는 포켓몬의 번호를 가져와 주세요.
select number
from ability
where weight = (select max(weight) from ability);

# MISSION (2) 속도가 모든 전기 포켓몬의 공격력보다 하나라도 작은 포켓몬의 번호를 가져와 주세요.
select number
from ability
where speed < any(select attack from ability where type = 'electric');

# MISSION (3) 공격력이 방어력보다 큰 포켓몬이 있다면 모든 포켓몬의 이름을 가져와 주세요.
select name
from mypokemon
where exists (select * from ability where attack > defense);

-- 추가실습
# MISSION (1) 이브이의 번호 133을 활용해서, 이브이의 영문 이름, 키, 몸무게를 가져와 주세요. 이 때, 키는 height, 몸무게는 weight이라는 별명으로 가져와 주세요.
select name, (select height from ability where number = 133) as height, (select weight from ability where number = 133) as weight
from mypokemon
where number = 133;

select (select name from mypokemon where number = 133) as name, height, weight
from ability
where number = 133;

# MISSION (2) 속도가 2번째로 빠른 포켓몬의 번호와 속도를 가져와 주세요.
select number, speed
from (select number, speed, rank() over(order by speed desc) as speed_rank from ability) as A
where speed_rank = 2;

# MISSION (3) 방어력이 모든 전기 포켓몬의 방어력보다 큰 포켓몬의 이름을 가져와 주세요.
-- JOIN 대신 서브쿼리를 활용해 가져와 주세요.
select name
from mypokemon
where number in (select number from ability where defense > all(select defense from ability where type = 'electric')); -- 방어력이 모든 전기 포켓몬의 방어력보다 큰 포켓몬 리스트