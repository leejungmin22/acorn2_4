CREATE TABLE exhibition_users
   (id VARCHAR2(30) PRIMARY KEY, --아이디
   name VARCHAR2(30) NOT NULL, --이름
   pwd VARCHAR2(30) NOT NULL, --비밀번호
   email VARCHAR2(30), --이메일
   birth DATE, --생년월일
   gender char(1), --성별 'f' ,'m' 으로 관리
   profile VARCHAR2(50), --프로필
   regdate DATE); --가입날짜