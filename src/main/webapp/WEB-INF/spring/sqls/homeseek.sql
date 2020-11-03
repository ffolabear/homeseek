-- 회원 테이블
DROP TABLE MEMBER;

CREATE TABLE MEMBER(
	MEMBER_ID VARCHAR2(50),
	MEMBER_PW VARCHAR2(100) NOT NULL,
	MEMBER_NAME VARCHAR2(20) NOT NULL,
	MEMBER_PHONE VARCHAR2(50) NOT NULL,
	-- N : 일반회원 / D : 탈퇴회원 / B : 차단회원 / R : 신고받은회원
	MEMBER_ENABLED CHAR(1) DEFAULT 'N' NOT NULL,
	-- A : 관리자 / N : 일반회원
	MEMBER_ROLE CHAR(1) DEFAULT 'N' NOT NULL,
	
	CONSTRAINT MEMBER_ID_PK PRIMARY KEY(MEMBER_ID),
	CONSTRAINT MEMBER_ENABLED_CHK CHECK(MEMBER_ENABLED IN('N','D','B','R')),
	CONSTRAINT MEMBER_ROLE_CHK CHECK(MEMBER_ROLE IN('A','N'))
);

-- 컬럼 삭제
ALTER TABLE MEMBER DROP COLUMN MEMBER_EMAIL;
ALTER TABLE MEMBER DROP COLUMN MEMBER_GOOGLEID;
ALTER TABLE MEMBER DROP COLUMN MEMBER_NAVERID;

SELECT * FROM MEMBER;
SELECT * FROM MEMBER WHERE MEMBER_ENABLED = 'R';
DELETE FROM MEMBER WHERE MEMBER_ID = 'admin@';

UPDATE MEMBER SET MEMBER_ROLE = 'A' WHERE MEMBER_ID = 'admin@homeseek.com';

-- member, admin 만들어주기
INSERT INTO MEMBER VALUES('member', 'member1234', '회원', 'homeseek@co.kr', '010-0000-0000', 'N', 'N');
INSERT INTO MEMBER VALUES('admin', 'admin1234', '관리자', 'homeseek@co.kr', '010-1111-1111', 'N', 'A');
INSERT INTO MEMBER VALUES('wlgn@naver.com', 'wlgn', '김지후', '010-1234-5678', 'N', 'N');

-- 공지사항 테이블
DROP TABLE NOTICE;
DROP SEQUENCE NOTICE_NO_SEQ;

CREATE SEQUENCE NOTICE_NO_SEQ;
CREATE TABLE NOTICE(
	NOTICE_NO NUMBER,
	NOTICE_TITLE VARCHAR2(2000) NOT NULL,
	NOTICE_CONTENT VARCHAR2(4000) NOT NULL,
	NOTICE_REGDATE DATE NOT NULL,
	NOTICE_HIT NUMBER NOT NULL,
	-- 공지사항 삭제여부 
	-- Y : 삭제O / N : 삭제X
	NOTICE_DELFLAG CHAR(1) DEFAULT 'N' NOT NULL,
	NOTICE_ID VARCHAR2(50) NOT NULL,
	
	CONSTRAINT NOTICE_NO_PK PRIMARY KEY(NOTICE_NO),
	CONSTRAINT NOTICE_DELFLAG_CHK CHECK(NOTICE_DELFLAG IN('Y', 'N')),
	CONSTRAINT NOTICE_ID_FK FOREIGN KEY(NOTICE_ID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE 
);

-- Q&A 테이블
DROP SEQUENCE QNA_NO_SEQ;
DROP TABLE QNA;

CREATE SEQUENCE QNA_NO_SEQ;
CREATE TABLE QNA(
	QNA_NO NUMBER,
	QNA_TITLE VARCHAR2(2000) NOT NULL,
	QNA_CONTENT VARCHAR2(4000) NOT NULL,
	QNA_REGDATE DATE NOT NULL,
	QNA_HIT NUMBER NOT NULL,
	-- 비밀글 여부
	-- Y : 비밀글 / N : 공개글
	QNA_SECRETFLAG CHAR(1) DEFAULT 'N' NOT NULL,
	QNA_PWD NUMBER,
	-- QNA 삭제여부
	-- Y : 삭제O / N : 삭제X
	QNA_DELFLAG CHAR(1) DEFAULT 'N' NOT NULL,
	QNA_ID VARCHAR2(50) NOT NULL,
	
	CONSTRAINT QNA_NO_PK PRIMARY KEY(QNA_NO),
	CONSTRAINT QNA_SECRETFLAG_CHK CHECK(QNA_SECRETFLAG IN('Y', 'N')),
	CONSTRAINT QNA_DELFLAG_CHK CHECK(QNA_DELFLAG IN('Y', 'N')),
	CONSTRAINT QNA_ID_FK FOREIGN KEY(QNA_ID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE
);

-- 댓글 테이블
DROP SEQUENCE REPLY_NO_SEQ;
DROP TABLE REPLY;

CREATE SEQUENCE REPLY_NO_SEQ;
CREATE TABLE REPLY(
	REPLY_NO NUMBER,
	REPLY_CONTENT VARCHAR2(4000) NOT NULL,
	REPLY_REGDATE DATE NOT NULL,
	-- 댓글 삭제여부
	-- Y : 삭제O / N : 삭제X
	REPLY_DELFLAG CHAR(1) DEFAULT 'N' NOT NULL,
	QNA_NO NUMBER NOT NULL,
	REPLY_ID VARCHAR2(50) NOT NULL,
	
	CONSTRAINT REPLY_NO_PK PRIMARY KEY(REPLY_NO),
	CONSTRAINT REPLY_DELFLAG_CHK CHECK(REPLY_DELFLAG IN('Y', 'N')),
	CONSTRAINT QNA_NO_FK FOREIGN KEY(QNA_NO) REFERENCES QNA(QNA_NO) ON DELETE CASCADE,
	CONSTRAINT REPLY_ID_FK FOREIGN KEY(REPLY_ID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE
);

-- 후원내역 테이블
DROP SEQUENCE DONA_NO_SEQ;
DROP TABLE DONATION;

CREATE SEQUENCE DONA_NO_SEQ;
CREATE TABLE DONATION(
	DONA_NO NUMBER,
	DONA_BILL NUMBER NOT NULL,
	DONA_DATE DATE NOT NULL,
	DONA_ID VARCHAR2(50) NOT NULL,
	
	CONSTRAINT DONA_NO_PK PRIMARY KEY(DONA_NO),
	CONSTRAINT DONA_ID_FK FOREIGN KEY(DONA_ID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE
);

-- 매물 테이블
DROP SEQUENCE ROOM_NO_SEQ;
DROP TABLE ROOM;

CREATE SEQUENCE ROOM_NO_SEQ;
CREATE TABLE ROOM(
	ROOM_NO NUMBER,
	ROOM_NAME VARCHAR2(1000) NOT NULL,
	ROOM_PHOTO VARCHAR2(4000) NOT NULL,
	-- 매물 종류
	-- 월세:1 / 전세:2 / 매매:3 / 반전세:4 / 단기임대:5
	ROOM_TYPE CHAR(1) NOT NULL,
	ROOM_DEPOSIT NUMBER,
	ROOM_PRICE NUMBER NOT NULL,
	ROOM_EXTENT NUMBER NOT NULL,
	ROOM_ADDR VARCHAR2(2000) NOT NULL,
	-- 건물 종류
	-- 아파트:1 / 빌라:2 / 주택:3 / 오피스텔:4 / 상가사무실:5
	ROOM_KIND CHAR(1) NOT NULL,
	-- 방 구조
	-- 방1개 :1 / 방2개: 2 / 방 3개이상:3
	ROOM_STRUCTURE CHAR(1) NOT NULL,
	ROOM_FLOOR VARCHAR2(50) NOT NULL,
	ROOM_REGDATE DATE NOT NULL,
	ROOM_CPDATE DATE NOT NULL,
	ROOM_AVDATE DATE NOT NULL,
	ROOM_DETAIL VARCHAR2(4000) NOT NULL,
	ROOM_ID VARCHAR2(50) NOT NULL,
	
	CONSTRAINT ROOM_NO_PK PRIMARY KEY(ROOM_NO),
	CONSTRAINT ROOM_TYPE_CHK CHECK(ROOM_TYPE IN('1','2','3','4','5')),
	CONSTRAINT ROOM_KIND_CHK CHECK(ROOM_KIND IN('1','2','3','4','5')),
	CONSTRAINT ROOM_STRUCTURE_CHK CHECK(ROOM_STRUCTURE IN('1','2','3')),
	CONSTRAINT ROOM_ID_FK FOREIGN KEY(ROOM_ID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE
);

-- 위도 경도 컬럼 삭제
ALTER TABLE ROOM DROP COLUMN ROOM_LATI;
ALTER TABLE ROOM DROP COLUMN ROOM_LONGI;

-- Room 테이블에 더미데이터 넣어주기
INSERT INTO ROOM VALUES(ROOM_NO_SEQ.NEXTVAL, 'homeseek 사무소', '사진', '1', '100', '1000', '900', '서울특별시 강남구',
'5', '3', '10층', SYSDATE, SYSDATE, SYSDATE, '127.032888','37.499172', 'homeseek korea', 'admin');
INSERT INTO ROOM VALUES(ROOM_NO_SEQ.NEXTVAL, 'homeseek 사무소', '사진', '2', '100', '1000', '900', '서울특별시 강남구',
'4', '2', '10층', SYSDATE, SYSDATE, SYSDATE, '127.032888','37.499172', 'homeseek korea', 'admin');
INSERT INTO ROOM VALUES(ROOM_NO_SEQ.NEXTVAL, 'homeseek 사무소', '사진', '3', '100', '1000', '900', '서울특별시 강남구',
'3', '1', '10층', SYSDATE, SYSDATE, SYSDATE, '127.032888','37.499172', 'homeseek korea', 'admin');
INSERT INTO ROOM VALUES(ROOM_NO_SEQ.NEXTVAL, 'homeseek 사무소', '사진', '4', '100', '1000', '900', '서울특별시 강남구',
'2', '2', '10층', SYSDATE, SYSDATE, SYSDATE, '127.032888','37.499172', 'homeseek korea', 'admin');
INSERT INTO ROOM VALUES(ROOM_NO_SEQ.NEXTVAL, 'homeseek 사무소', '사진', '5', '100', '1000', '900', '서울특별시 강남구',
'1', '3', '10층', SYSDATE, SYSDATE, SYSDATE, '127.032888','37.499172', 'homeseek korea', 'admin');
INSERT INTO ROOM VALUES(ROOM_NO_SEQ.NEXTVAL, '우리집', '사진', '2', '10000', '1000', '230', '서울특별시 강남구',
'1', '3', '99', SYSDATE, SYSDATE, SYSDATE, 'homeseek korea<br/>dddddddddddddddddddd<br/>ddddddddddddddddd<br/>dddddd<br/>dddd<br/>dddddddd<br/>dddddddddd<br/>dddddddddd<br/>ddddddddddddd<br/>ddddddddddddd<br/>dddddddddddddddd<br/>ddddddd<br/>dddddddd', 'rgusqls@naver.com');

UPDATE ROOM SET ROOM_REGDATE = TO_DATE('20200101','yyyy/MM/dd') WHERE ROOM_NO = 24;

SELECT * FROM ROOM;

DELETE FROM ROOM WHERE ROOM_NO = 93;

--쪽지
DROP SEQUENCE MESSAGE_NO_SEQ;
DROP TABLE MESSAGE;

CREATE SEQUENCE MESSAGE_NO_SEQ; 
CREATE TABLE MESSAGE(
   MESSAGE_NO NUMBER NOT NULL,
   MESSAGE_SENID VARCHAR2(50) NOT NULL,
   MESSAGE_REID VARCHAR2(50) NOT NULL,
   MESSAGE_TITLE VARCHAR2(1000) NOT NULL,
   MESSAGE_CONTENT VARCHAR2(4000) NOT NULL,
   MESSAGE_DATE DATE NOT NULL,
   -- 보낸 메세지 삭제여부
   -- D : 삭제 / R : 보관
   MESSAGE_SENDEL CHAR(1) DEFAULT 'R' NOT NULL,
   -- 받은 메세지 삭제여부
   -- D : 삭제 / R : 보관
   MESSAGE_REDEL CHAR(1) DEFAULT 'R' NOT NULL,
   
   CONSTRAINT MESSAGE_NO_PK PRIMARY KEY(MESSAGE_NO),
   CONSTRAINT MESSAGE_SENID_FK FOREIGN KEY(MESSAGE_SENID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE,
   CONSTRAINT MESSAGE_REID_FK FOREIGN KEY(MESSAGE_REID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE,
   CONSTRAINT MESSAGE_SENDEL_CHK CHECK(MESSAGE_SENDEL IN('D','R')),
   CONSTRAINT MESSAGE_REDEL_CHK CHECK(MESSAGE_REDEL IN('D','R'))
   
);

SELECT * FROM MESSAGE;

--신고
DROP SEQUENCE REPORT_NO_SEQ;
DROP TABLE REPORT;

CREATE SEQUENCE REPORT_NO_SEQ;
CREATE TABLE REPORT(
   REPORT_NO NUMBER NOT NULL,
   REPORT_SENID VARCHAR2(50) NOT NULL,
   REPORT_REID VARCHAR2(50) NOT NULL,
   REPORT_TITLE VARCHAR2(100) NOT NULL, -- <- 추가 된 애임
   REPORT_CONTENT VARCHAR2(4000) NOT NULL,
   REPORT_DATE DATE NOT NULL,
   
   CONSTRAINT REPORT_NO_PK PRIMARY KEY(REPORT_NO),
   CONSTRAINT REPORT_SENID_FK FOREIGN KEY(REPORT_SENID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE,
   CONSTRAINT REPORT_REID_FK FOREIGN KEY(REPORT_REID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE
);

ALTER TABLE REPORT ADD(REPORT_TITLE VARCHAR2(100) NOT NULL);

SELECT * FROM REPORT;

-- 찜목록 테이블

DROP SEQUENCE WISH_NO_SEQ;
DROP TABLE WISH;

CREATE SEQUENCE WISH_NO_SEQ;
CREATE TABLE WISH(
	-- 찜목록 번호
	WISH_NO NUMBER,
	-- 내 아이디
	WISH_ID VARCHAR2(50) NOT NULL,
	-- 파는사람 아이디
	WISH_SELL_ID VARCHAR2(50) NOT NULL,
	-- 찜한 글의 번호
	ROOM_NO NUMBER NOT NULL,
	
	CONSTRAINT WISH_NO_PK PRIMARY KEY(WISH_NO),
	CONSTRAINT WISH_ID_FK FOREIGN KEY(WISH_ID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE, -- MEMBER테이블에 MEMBER_ID를 참조
	CONSTRAINT WISH_SELL_ID_FK FOREIGN KEY(WISH_SELL_ID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE, -- MEMBER테이블에 MEMBER_ID 참조
	CONSTRAINT ROOM_NO_FK FOREIGN KEY(ROOM_NO) REFERENCES ROOM(ROOM_NO) ON DELETE CASCADE -- ROOM테이블에 ROOM_NO를 참조
);

SELECT * FROM WISH ORDER BY WISH_NO ASC;
DELETE FROM WISH;


SELECT COUNT(ROOM_NO)
FROM WISH
WHERE WISH_ID = 'wlgn@naver.com'
AND WISH_SELL_ID = 'admin'
AND ROOM_NO = 38;


