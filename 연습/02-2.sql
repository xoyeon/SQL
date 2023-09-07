# SELECT 열_이름 FROM 테이블_이름 [WHERE 조건]
# Ctrl + Shift + Enter를 눌러 SQL 실행 가능

# *를 사용하여 member의 모든 열 출력
select * from member; # 세미콜론(;) 필수!

# 여러 개의 열 이름을 콤마(,)로 분리하여 필요한 열만 추출
select member_name, member_addr from member;

# WHERE를 사용하여 특정 행만 추출
select * from member where member_name = '아이유';

## 쿼리 창에 있는 모든 SQL을 수행하면 결과가 세개
## 하나만 실행하기 위해서는 블록으로 지정한 뒤 실행