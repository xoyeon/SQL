# 포켓몬 데이터 입력 쿼리
DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
number int,
name varchar(20),
type varchar(20),
height float,
weight float,
attack float,
defense float,
speed float
);
INSERT INTO mypokemon (number, name, type, height, weight, attack, defense, speed)
VALUES (10, 'caterpie', 'bug', 0.3, 2.9, 30, 35, 45),
(25, 'pikachu', 'electric', 0.4, 6, 55, 40, 90),
(26, 'raichu', 'electric', 0.8, 30, 90, 55, 110),
(133, 'eevee', 'normal', 0.3, 6.5, 55, 50, 55),
(152, 'chikoirita', 'grass', 0.9, 6.4, 49, 65, 45);

# MISSION 1 -- 123 곱하기 456을 가져와 주세요.
select 123*456;

# MISSION 2 -- 2310 나누기 30을 가져와 주세요.
select 2310/30;

# MISSION 3 -- ‘피카츄’라는 문자열을 ‘포켓몬’이라는 이름의 컬럼 별명으로 가져와 주세요.
select '피카츄' as '포켓몬';

# MISSION 4 -- 포켓몬 테이블에서 모든 포켓몬들의 컬럼과 값 전체를 가져와 주세요.
use pokemon;
select *
from mypokemon;

# MISSION 5 -- 포켓몬 테이블에서 모든 포켓몬들의 이름을 가져와 주세요.
select name
from mypokemon;

# MISSION 6 -- 포켓몬 테이블에서 모든 포켓몬들의 이름과 키, 몸무게를 가져와 주세요.
select name, height, weight
from mypokemon;

# MISSION 7 -- 포켓몬 테이블에서 포켓몬들의 키를 중복 제거하고 가져와 주세요.
select distinct height
from mypokemon;

# MISSION 8 -- 포켓몬 테이블에서 모든 포켓몬들의 공격력을 2배 해 ‘attack2’라는 별명으로 이름과 함께 가져와 주세요.
select name, attack*2 as attack2
from mypokemon;

# MISSION 9 -- 포켓몬 테이블에서 모든 포켓몬들의 이름을 ‘이름’이라는 한글 별명으로 가져와 주세요.
select name as 이름
from mypokemon;

# MISSION 10 -- 포켓몬 테이블에서 모든 포켓몬들의 공격력은 ‘공격력’이라는 한글 별명으로, 방어력은 ‘방어력’이라는 한글 별명으로 가져와 주세요.
select attack as 공격력, defense as 방어력
from mypokemon;

# MISSION 11 -- 현재 포켓몬 테이블의 키 컬럼은 m단위입니다. (1m = 100cm) 포켓몬 테이블에서 모든 포켓몬들의 키를 cm단위로 환산하여 ‘height(cm)’라는 별명으로 가져와 주세요.
select height*100 as 'height(cm)'
from mypokemon;

# MISSION 12 -- 포켓몬 테이블에서 첫번째 로우에 위치한 포켓몬 데이터만 컬럼 값 전체를 가져와 주세요.
select *
from mypokemon
limit 1;

# MISSION 13 -- 포켓몬 테이블에서 2개의 포켓몬 데이터만 이름은 ‘영문명’이라는 별명으로,  키는 ‘키(m)’라는 별명으로, 몸무게는 ‘몸무게(kg)’이라는 별명으로 가져와 주세요.
select name as 영문명, height as '키(m)', weight as '몸무게(kg)'
from mypokemon
limit 2;

# MISSION 14 -- 포켓몬 테이블에서 모든 포켓몬들의 이름과 능력치의 합을 가져오고, 이 때 능력치의 합은 ‘total’이라는 별명으로 가져와 주세요.
-- 조건1. 능력치의 합은 공격력, 방어력, 속도의 합을 의미합니다.
select name, attack+defense+speed as total
from mypokemon;

# MISSION 15 -- 포켓몬 테이블에서 모든 포켓몬들의 BMI 지수를 구해서 ‘BMI’라는 별명으로 가져와 주세요. 이 때, 포켓몬을 구분하기 위해 이름도 함께 가져와 주세요.
-- 조건1. BMI 지수 = 몸무게(kg) ÷ (키(m))²
-- 조건2. 포켓몬 테이블 데이터의 체중은 kg 단위, 키는 m 단위입니다.
select name, weight / height^2 as BMI
from mypokemon;