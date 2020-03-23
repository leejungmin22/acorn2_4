
CREATE TABLE exhibition_users
   (id VARCHAR2(30) PRIMARY KEY, --아이디
   name VARCHAR2(30) NOT NULL, --이름
   pwd VARCHAR2(30) NOT NULL, --비밀번호
   email VARCHAR2(30), --이메일
   birth DATE, --생년월일
   gender char(1), --성별 'f' ,'m' 으로 관리
   profile VARCHAR2(50), --프로필
   regdate DATE); --가입날짜

   
CREATE TABLE fullcalendar
   (title VARCHAR2(30), --아이디
   startdate VARCHAR2(30), --이름
   enddate VARCHAR2(30), --비밀번호
   url VARCHAR2(30) --이메일
   );

CREATE TABLE tb_api_date(
	seq NUMBER PRIMARY KEY,
	title VARCHAR2(200),
	startdate VARCHAR2(50),
	enddate VARCHAR2(50),
	place VARCHAR(50),
	realmname VARCHAR(20),
	area VARCHAR(20),
	thumbnail VARCHAR(256),
	gpsx VARCHAR(20),
	gpsy VARCHAR(20)
);

INSERT INTO tb_api_date
(seq, title, startdate, enddate, place, realmname, area, thumbnail, gpsx, gpsy)
VALUES(
seq_seq.NEXTVAL, 
'은하계 제국에서 랑데부', 
'20200301', 
'20200303', 
'연우소극장', 
'연극', 
'서울', 
'http://www.culture.go.kr/upload/rdf/19/12/rdf_201912234385511597.png',
'127.001766249',
'37.5869849674'
)

CREATE TABLE exhibition_users
   (id VARCHAR2(30) PRIMARY KEY, --아이디
   name VARCHAR2(30) NOT NULL, --이름
   pwd CLOB NOT NULL, --비밀번호
   email VARCHAR2(100), --이메일
   birth DATE, --생년월일
   gender char(1), --성별 'F' ,'m' 으로 관리
   profile VARCHAR2(100), --프로필
   regdate DATE); --가입날짜

CREATE TABLE exhibition_like(
	seq NUMBER,
	id VARCHAR(100)
)

SELECT exhibition.seq, title, startdate, enddate, place, realmname, thumbnail, gpsx, gpsy, likecount.likecount
FROM tb_api_date exhibition
INNER JOIN exhibition_likecount likecount ON exhibition.seq=likecount.seq
WHERE exhibition.seq=158929

--기간별 조회 테스트
SELECT seq, title, startdate, enddate
FROM (SELECT seq, title, startdate, enddate
		FROM tb_api_date
		WHERE startdate>=to_date(20170401,'yyyymmdd') AND startdate<=to_date(20170531,'yyyymmdd')) result2
WHERE enddate>=to_date(20170401,'yyyymmdd') AND enddate<=to_date(20170531,'yyyymmdd')