# MISSION 1
USE POKEMON;
SELECT * FROM mypokemon;

-- mypokemon 테이블의 이름을 myoldpokemon으로 변경
ALTER TABLE mypokemon
RENAME myoldpokemon;

SELECT * FROM myoldpokemon;

-- myoldpokemon 테이블의 name 컬럼을 eng_nm으로 변경
ALTER TABLE myoldpokemon
change column name eng_nm varchar(20);

-- mynewpokemon 테이블의 name 컬럼을 kor_nm으로 변경
alter table mynewpokemon
change column name kor_nm varchar(20);

SELECT * FROM mynewpokemon;

# MISSION 2
-- pokemon DB의 myoldpokemon 테이블 값만 지우기
USE pokemon;
truncate table myoldpokemon;
SELECT * FROM myoldpokemon;

-- mynewpokemon 테이블은 전부 지우기
SELECT * FROM mynewpokemon;
drop table mynewpokemon;

-- pokemon 데이터 베이스 지우기
DROP database pokemon;