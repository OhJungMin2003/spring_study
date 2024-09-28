DROP TABLE USERS CASCADE CONSTRAINTS;
DROP TABLE MEMBER CASCADE CONSTRAINTS;
DROP TABLE NOTICE CASCADE CONSTRAINTS;
DROP TABLE BOARD CASCADE CONSTRAINTS;

-- 소셜로그인시 회원가입을 이용할 경우의 회원 테이블
CREATE TABLE MEMBER(
  USERID VARCHAR2(50) CONSTRAINT PK_MEMBER_UID PRIMARY KEY,
  USERPWD VARCHAR2(100),
  USERNAME VARCHAR2(20) NOT NULL,
  GENDER CHAR(1)  NOT NULL,
  AGE NUMBER(3)   NOT NULL,
  PHONE VARCHAR2(13),
  EMAIL VARCHAR2(30) not null,  
  ENROLL_DATE DATE DEFAULT SYSDATE,
  LASTMODIFIED DATE DEFAULT SYSDATE,
  signtype VARCHAR2(10) default 'direct' not null,
  -- 가입방식 : 직접 가입('direct'), 소셜로그인('kakao', 'naver', 'google') 
  ADMIN_YN CHAR(1) DEFAULT 'N' not null,
  login_ok CHAR(1) DEFAULT 'Y' not null,
  photo_filename  varchar2(100)
  );

comment on column member.userid is '회원아이디';
comment on column member.userpwd is '회원패스워드';
comment on column member.username is '회원이름';
comment on column member.gender is '회원성별';
comment on column member.age is '회원나이';
comment on column member.email is '회원이메일';
comment on column member.phone is '회원전화번호';
comment on column member.enroll_date is '회원가입날짜';
comment on column member.userid is '회원아이디';
comment on column member.lastmodified is '마지막수정날짜';
comment on column member.signtype is '가입방식';
comment on column member.login_ok is '로그인가능여부';
comment on column member.admin_yn is '관리자여부';
comment on column member.photo_filename is '회원사진파일명';

CREATE TABLE USERS (
  USERID VARCHAR2(15) PRIMARY KEY,
  USERPWD VARCHAR2(100) NOT NULL,
  USERNAME VARCHAR2(20) NOT NULL
);

ALTER TABLE USERS
DROP PRIMARY KEY;

-- 삭제룰을 추가한 새 제약조건 추가함
ALTER TABLE USERS
ADD CONSTRAINT FK_MEMBER_UID 
FOREIGN KEY(USERID) REFERENCES MEMBER ON DELETE CASCADE;

-- TRIGGER 작성 : 이름 - TRI_INSERT_USERS
-- MEMBER 테이블에 새 회원정보가 기록되면, 자동으로 USERS 테이블에 아이디, 암호, 이름이
-- INSERT 되게 함
CREATE OR REPLACE TRIGGER TRI_INSERT_USERS
AFTER INSERT ON MEMBER
FOR EACH ROW
BEGIN
  INSERT INTO USERS
  VALUES (:NEW.USERID, :NEW.USERPWD, :NEW.USERNAME);
END;
/

CREATE OR REPLACE TRIGGER TRI_UPDATE_USERS
AFTER UPDATE ON MEMBER
FOR EACH ROW
BEGIN
  UPDATE USERS 
  SET USERPWD = :NEW.USERPWD
  WHERE USERID = :OLD.USERID;
END;
/

INSERT INTO MEMBER VALUES ('admin', 'admin', '관리자', 'M', 35, '010-1111-9999', 
'admin@ncs.kr', to_date('2016-06-25', 'RRRR-MM-DD'), sysdate, default, 'Y', default, null);

INSERT INTO MEMBER
VALUES ('user01', 'pass01', '홍길동', 'M', 25, '010-1234-5678', 'hong1234@ncs.kr', 
        default, default, default, default, default, null);
        
INSERT INTO MEMBER
VALUES ('user02', 'pass02', '신사임당', 'F', 45, '010-4545-9999', 'dano99@ncs.kr', 
        default, default, 'direct', default, default, null);
        

COMMIT;

-- notice 테이블
DROP TABLE NOTICE;

CREATE TABLE NOTICE(
  NOTICENO NUMBER CONSTRAINT PK_NOTICENO PRIMARY KEY,
  NOTICETITLE VARCHAR2(50) NOT NULL,
  NOTICEDATE DATE DEFAULT SYSDATE,
  NOTICEWRITER VARCHAR2(50),
  NOTICECONTENT VARCHAR2(2000),
  ORIGINAL_FILEPATH VARCHAR2(100),
  RENAME_FILEPATH VARCHAR2(100),
  IMPORTANCE CHAR(1) DEFAULT 'N' NOT NULL,  
  IMP_END_DATE DATE DEFAULT SYSDATE NOT NULL,
  READCOUNT NUMBER DEFAULT 1 NOT NULL,
  CONSTRAINT FK_NOTICEWRITER FOREIGN KEY (NOTICEWRITER) 
      REFERENCES MEMBER ON DELETE SET NULL
);

COMMENT ON COLUMN notice.NOTICENO IS '공지글번호';
COMMENT ON COLUMN notice.NOTICETITLE IS '공지글제목';
COMMENT ON COLUMN notice.NOTICEDATE IS '공지등록날짜';
COMMENT ON COLUMN notice.NOTICEWRITER IS '공지작성자';
COMMENT ON COLUMN notice.NOTICECONTENT IS '공지내용';
COMMENT ON COLUMN notice.ORIGINAL_FILEPATH IS '원본첨부파일명';
COMMENT ON COLUMN notice.RENAME_FILEPATH IS '바뀐첨부파일명';
COMMENT ON COLUMN notice.IMPORTANCE IS '중요도';
COMMENT ON COLUMN notice.IMP_END_DATE IS '중요도게시종료날짜';
COMMENT ON COLUMN notice.READCOUNT IS '공지조회수';

COMMIT;

INSERT INTO NOTICE VALUES (1, '공지 서비스 오픈', SYSDATE, 'admin', 
'공지 서비스가 오픈되었습니다. 많이 이용해 주세요.', null, null, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO NOTICE VALUES ((select max(noticeno) + 1 from notice), 
'공지 서비스 오픈2', SYSDATE, 'admin', 
'공지 서비스가 오픈되었습니다. 많이 이용해 주세요.', null, null, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO NOTICE VALUES ((select max(noticeno) + 1 from notice), '공지 서비스 오픈3', SYSDATE, 'admin', 
'공지 서비스가 오픈되었습니다. 많이 이용해 주세요.', null, null, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO NOTICE VALUES ((select max(noticeno) + 1 from notice), '공지 서비스 오픈4', SYSDATE, 'admin', 
'공지 서비스가 오픈되었습니다. 많이 이용해 주세요.', null, null, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO NOTICE VALUES ((select max(noticeno) + 1 from notice), '공지 서비스 오픈5', SYSDATE, 'admin', 
'공지 서비스가 오픈되었습니다. 많이 이용해 주세요.', null, null, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO NOTICE VALUES ((select max(noticeno) + 1 from notice), '공지 서비스 오픈6', SYSDATE, 'admin', 
'공지 서비스가 오픈되었습니다. 많이 이용해 주세요.', null, null, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO NOTICE VALUES ((select max(noticeno) + 1 from notice), '공지 서비스 오픈7', SYSDATE, 'admin', 
'공지 서비스가 오픈되었습니다. 많이 이용해 주세요.', null, null, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO NOTICE VALUES ((select max(noticeno) + 1 from notice), '공지 서비스 오픈8', SYSDATE, 'admin', 
'공지 서비스가 오픈되었습니다. 많이 이용해 주세요.', null, null, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO NOTICE VALUES ((select max(noticeno) + 1 from notice), '공지 서비스 오픈9', SYSDATE, 'admin', 
'공지 서비스가 오픈되었습니다. 많이 이용해 주세요.', null, null, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO NOTICE VALUES ((select max(noticeno) + 1 from notice), '공지 서비스 오픈10', SYSDATE, 'admin', 
'공지 서비스가 오픈되었습니다. 많이 이용해 주세요.', null, null, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO NOTICE VALUES ((select max(noticeno) + 1 from notice), '신입사원 모집공고', 
TO_DATE('2016-07-15', 'RRRR-MM-DD'), 'admin', 
'공지 서비스가 오픈되었습니다. 많이 이용해 주세요.', null, null, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO NOTICE VALUES ((select max(noticeno) + 1 from notice), '신입사원 모집공고 마감', 
TO_DATE('2016-07-20', 'RRRR-MM-DD'), 'admin', 
'2016년 7월 20일 18시에 신입사원 모집을 마감합니다.', null, null, DEFAULT, DEFAULT, DEFAULT);

SELECT * FROM NOTICE;
 
commit;



-- BOARD TABLE SCRIPT FILE
DROP TABLE BOARD;

CREATE TABLE BOARD(
	BOARD_NUM	NUMBER,	
	BOARD_WRITER	 VARCHAR2(50) NOT NULL,
	BOARD_TITLE	VARCHAR2(50) NOT NULL,
	BOARD_CONTENT	VARCHAR2(2000) NOT NULL,
	BOARD_ORIGINAL_FILENAME	VARCHAR2(100),
    BOARD_RENAME_FILENAME VARCHAR2(100),
    BOARD_REF NUMBER,
	BOARD_REPLY_REF	NUMBER,
	BOARD_LEV	NUMBER DEFAULT 1,
	BOARD_REPLY_SEQ NUMBER DEFAULT 1,
	BOARD_READCOUNT	NUMBER DEFAULT 0,
	BOARD_DATE	DATE DEFAULT SYSDATE,
  CONSTRAINT PK_BOARD PRIMARY KEY (BOARD_NUM),
  CONSTRAINT FK_BOARD_WRITER FOREIGN KEY (BOARD_WRITER) REFERENCES MEMBER (USERID) ON DELETE CASCADE
);

COMMENT ON COLUMN BOARD.BOARD_NUM IS '게시글번호';
COMMENT ON COLUMN BOARD.BOARD_WRITER IS '작성자아이디';
COMMENT ON COLUMN BOARD.BOARD_TITLE IS '게시글제목';
COMMENT ON COLUMN BOARD.BOARD_CONTENT IS '게시글내용';
COMMENT ON COLUMN BOARD.BOARD_DATE IS '작성날짜';
COMMENT ON COLUMN BOARD.BOARD_ORIGINAL_FILENAME IS '원본첨부파일명';
COMMENT ON COLUMN BOARD.BOARD_RENAME_FILENAME IS '바뀐첨부파일명';
COMMENT ON COLUMN BOARD.BOARD_REF IS '원글번호';  -- 원글번호 : 원글 - 자기번호, 댓글/대댓글 : 원글번호
COMMENT ON COLUMN BOARD.BOARD_REPLY_REF IS '참조답글번호';  -- 원글 : null, 원글의 답/댓글 : 자기번호, 답글의 답글 : 참조답글번호
COMMENT ON COLUMN BOARD.BOARD_LEV IS '답글단계'; -- 원글 : 1, 원글의 답글 : 2, 답글의 답글 : 3
COMMENT ON COLUMN BOARD.BOARD_REPLY_SEQ IS '답글순번'; -- 원글 : 0, 같은 원글의 답글일 때 : 1 ....... 순차처리

INSERT INTO BOARD 
VALUES (1, 'admin', '관리자 게시글', '저희 사이트를 이용해 주셔서 감사합니다.', 
NULL, NULL, 1, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD 
VALUES (2, 'user01', 'MVC Model2', '웹 어플리케이션 설계 방식 중 MVC 디자인 패턴 모델2 방식의 한 유형입니다.', 
NULL, NULL, 2, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD 
VALUES (3, 'user02', '설계방식2', '설계방식 2번째로는 First Controller 를 사용하는 방식이 있습니다.', 
NULL, NULL, 3, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD 
VALUES (4, 'user01', '설계방식3', '3번째 방식은 액션을 이용하는 방식입니다.', 
NULL, NULL, 4, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD 
VALUES (5, 'user01', 'MVC Model2', '웹 어플리케이션 설계 방식 중 MVC 디자인 패턴 모델2 방식의 한 유형입니다.', 
NULL, NULL, 5, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD 
VALUES (6, 'user02', '설계방식2', '설계방식 2번째로는 First Controller 를 사용하는 방식이 있습니다.', 
NULL, NULL, 6, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD 
VALUES (7, 'user01', '설계방식3', '3번째 방식은 액션을 이용하는 방식입니다.', 
NULL, NULL, 7, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD 
VALUES (8, 'user01', 'MVC Model2', '웹 어플리케이션 설계 방식 중 MVC 디자인 패턴 모델2 방식의 한 유형입니다.', 
NULL, NULL, 8, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD 
VALUES (9, 'user02', '설계방식2', '설계방식 2번째로는 First Controller 를 사용하는 방식이 있습니다.', 
NULL, NULL, 9, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD 
VALUES (10, 'user01', '설계방식3', '3번째 방식은 액션을 이용하는 방식입니다.', 
NULL, NULL, 10, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD 
VALUES (11, 'user01', 'MVC Model2', '웹 어플리케이션 설계 방식 중 MVC 디자인 패턴 모델2 방식의 한 유형입니다.', 
NULL, NULL, 11, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD 
VALUES (12, 'user02', '설계방식2', '설계방식 2번째로는 First Controller 를 사용하는 방식이 있습니다.', 
NULL, NULL, 12, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD 
VALUES (13, 'user01', '설계방식3', '3번째 방식은 액션을 이용하는 방식입니다.', 
NULL, NULL, 13, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

SELECT * FROM BOARD;

COMMIT;

-- board 테이블 조회수 수정 처리
update board
set board_readcount = 123
where board_num = 7;

update board
set board_readcount = 77
where board_num = 3;

update board
set board_readcount = 12
where board_num = 10;

commit;

-- ajax 테스트용 test 테이블 만들기
drop table test cascade constraints;

create table test (
    name  varchar2(30) unique not null,
    age   number not null
);

insert into test values ('홍길동', 30);
insert into test values ('장희빈', 25);
insert into test values ('이순신', 42);

commit;

select * from test;












