# 1. 인덱스
# 전체 테이블에서 찾기
select * from member where member_name = '아이유';

# 인덱스를 활용하여 찾기
Create INDEX idx_member_name ON member(member_name);
/* 에러 발생! Error Code: 1061. Duplicate key name 'idx_member_name'
--> 인덱스 이름을 바꾸면 해결이 된다고 했으나 아래와 같은 에러 발생. 해결 방법 못찾음 ㅠㅠ
0 row(s) affected, 1 warning(s): 1831 Duplicate index 'index_member_name' defined on the table 'shop_db.member'. This is deprecated and will be disallowed in a future release. Records: 0  Duplicates: 0  Warnings: 1
*/

# 2. 뷰(가상의 테이블)
create view member_view
as
	select * from member;
    
# member_view에 접근하기
select * from member_view;

# 3. 스토어드 프로시저
select * from member where member_name = '나훈아';
select * from product where product_name = '삼각김밥';

DELIMITER // # 구분 문자 : 스토어드 프로시저를 묶어줌
CREATE PROCEDURE myProc()
BEGIN
	SELECT * FROM member WHERE member_name = '나훈아';
	SELECT * FROM product WHERE product_name = '삼각김밥';
END //
DELIMITER ;

CALL myProc (); ### 여기도 에러 발생 ! Error Code: 1305. PROCEDURE shop_db.myProc does not exist


