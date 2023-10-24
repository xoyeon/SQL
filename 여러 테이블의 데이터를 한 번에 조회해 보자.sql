# 포켓몬 데이터 입력 쿼리
DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
number int,
name varchar(20),
type varchar(10),
attack int,
defense int
);
CREATE TABLE friendpokemon (
number int,
name varchar(20),
type varchar(10),
attack int,
defense int
);
INSERT INTO mypokemon (number, name, type, attack, defense)
VALUES (10, 'caterpie', 'bug', 30, 35),
(25, 'pikachu', 'electric', 55, 40),
(26, 'raichu', 'electric', 90, 55),
(133, 'eevee', 'normal', 55, 50),
(152, 'chikoirita', 'grass', 49, 65);
INSERT INTO friendpokemon (number, name, type, attack, defense)
VALUES (26, 'raichu', 'electric', 80, 60),
(125, 'electabuzz', 'electric', 83, 57),
(137, 'porygon', 'normal', 60, 70),
(153, 'bayleef', 'grass', 62, 80),
(172, 'pichu', 'electric', 40, 15),
(470, 'leafeon', 'grass', 110, 130);

# MISSION (1) 내 포켓몬과 친구의 포켓몬에 어떤 타입들이 있는지 중복 제외하고 같은 타입은 한 번 씩만 가져와 주세요.
select type
from mypokemon
union
select type
from friendpokemon;

select type
from mypokemon
union
select distinct type
from friendpokemon;

# MISSION (2) 내 포켓몬과 친구의 포켓몬 중에 풀(grass) 타입 포켓몬들의 포켓몬 번호와 이름을 중복 포함하여 전부 다 가져와 주세요.
select number, name, 'mine' as whose
from mypokemon
where type = 'grass'
union all
select number, name, "friend's" as whose
from friendpokemon
where type = 'grass';

# MISSION (1) 나도 가지고 있고, 친구도 가지고 있는 포켓몬의 이름을 가져와 주세요. -- 교집합 개념 사용
select mypokemon.name
from mypokemon inner join friendpokemon
on mypokemon.number = friendpokemon.number;

# MISSION (2) 나만 가지고 있고, 친구는 안 가지고 있는 포켓몬의 이름을 가져와 주세요. -- 차집합 개념 사용(내 포켓몬 - 친구 포켓몬)
select mypokemon.name
from mypokemon left join friendpokemon
on mypokemon.number = friendpokemon.number and mypokemon.number = friendpokemon.number
where friendpokemon.number is null;