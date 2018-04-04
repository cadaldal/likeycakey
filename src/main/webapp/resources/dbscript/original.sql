--create user likeycakey identified by likeycakey;
--grant resource, connect to likeycakey;

-- 회원 코드 설정 (M_NUM : PK)
DROP TABLE MEMBER_CODE CASCADE
CREATE TABLE MEMBER_CODE
(
	M_NUM NUMBER,
	M_TYPE VARCHAR2(12) NOT NULL,
	CONSTRAINT MCODE_PK_MNUM PRIMARY KEY (M_NUM)
);

INSERT INTO MEMBER_CODE
VALUES(1, 'ADMIN');

INSERT INTO MEMBER_CODE
VALUES(2, 'NORMAL');

INSERT INTO MEMBER_CODE
VALUES(3, 'BIZ');

-- 일반회원 및 관리자 정보 (M_ID : PK)
DROP TABLE MEMBER;
CREATE TABLE MEMBER
(
	M_ID VARCHAR2(50),
	M_PW VARCHAR2(50) NOT NULL,
	M_NAME VARCHAR2(50) NOT NULL,
	M_EMAIL VARCHAR2(100),
	M_POST VARCHAR2(10),
	M_BASIC_ADDR VARCHAR2(1000),
	M_DETAIL_ADDR VARCHAR2(1000),
	M_PHOTO VARCHAR2(2000),
	M_CP VARCHAR2(50),
	M_NUM NUMBER,
	CONSTRAINT MEM_PK_MID PRIMARY KEY (M_ID),
	CONSTRAINT MEM_FK_MNUM FOREIGN KEY (M_NUM) REFERENCES MEMBER_CODE (M_NUM)
);


INSERT INTO MEMBER VALUES("dodo123", "dodo123", "도도", "dodo123@naver.com", 
"13402", "경기도 성남시 분당구 판교로 50번길", "판교휴먼시아 1단지 101동 1103호", "img", "010-1234-5678", 2);


CREATE TABLE TEST 
(
	M_DETAIL VARCHAR2(1000)
)
DROP TABLE TEST
INSERT INTO TEST VALUES("판교휴먼시아 1단지 101동 1103호")
SELECT LENGTH (M_DETAIL_ADDR) FROM MEMBER


-- 기업회원 정보
DROP TABLE MEMBER_BIZ;
CREATE TABLE MEMBER_BIZ
(
	M_ID VARCHAR2(50),
	BIZ_NAME VARCHAR2(50) NOT NULL,
	BIZ_PN VARCHAR2(20) NOT NULL,
	BIZ_NUM VARCHAR2(50) NOT NULL,
	BIZ_EMAIL VARCHAR2(50) NOT NULL,
	BIZ_DELIVERY NUMBER,
	MASTER_NAME VARCHAR2(50) NOT NULL,
	CONSTRAINT MEMBIZ_FK_MID FOREIGN KEY (M_ID) REFERENCES MEMBER (M_ID)
);



DROP TABLE DELIVERY_STATUS
CREATE TABLE DELIVERY_STATUS
(
	D_STATUS_NUM NUMBER,
	D_STATUS VARCHAR2(20) NOT NULL,
	CONSTRAINT DELSTAT_PK_DSN PRIMARY KEY (D_STATUS_NUM)
)

CREATE TABLE DELIVERY
(
	P_O_NUM VARCHAR2(50),
	D_DATE DATE,
	D_LOCATION VARCHAR2(100),
	DV_STATUS VARCHAR2(50),
	DM_NAME VARCHAR2(20),
	DM_CP VARCHAR2(20)
)



--ORDER
DROP TABLE PRODUCT_ORDER;
CREATE TABLE PRODUCT_ORDER
(
   P_O_NUM NUMBER(10),
   P_O_DATE DATE DEFAULT SYSDATE,
   P_O_BOOKDATE DATE DEFAULT SYSDATE,
   P_O_CNT NUMBER NOT NULL,
   P_O_PRICE NUMBER(10) NOT NULL,
   P_O_TEXT VARCHAR2(60),
   P_O_REC_NAME VARCHAR2(50) NOT NULL,
   P_O_REC_CP VARCHAR2(50) NOT NULL,
   P_O_REC_POST VARCHAR2(10) NOT NULL,
   P_O_REC_BASIC_ADDR VARCHAR2(150) NOT NULL,
   P_O_REC_DETAIL_ADDR VARCHAR2(100) NOT NULL,
   P_O_MEMO VARCHAR2(300),

   M_ID VARCHAR2(50),
   P_B_NUM NUMBER(10),
   BIZ_DELIVERY NUMBER(10),
   D_STATUS_NUM NUMBER,
    
    CONSTRAINT ORDER_PK_NUM PRIMARY KEY (P_O_NUM),
    CONSTRAINT ORDER_FK_ID FOREIGN KEY (M_ID) REFERENCES MEMBER (M_ID),
    CONSTRAINT ORDER_FK_P_B_NUM FOREIGN KEY (P_B_NUM) REFERENCES PRODUCT_BOARD (P_B_NUM),
    CONSTRAINT ORDER_FK_BIZ_DELIVERY FOREIGN KEY (BIZ_DELIVERY) REFERENCES MEMBER_BIZ (BIZ_DELIVERY),
    CONSTRAINT ORDER_D_STATUS_NUM FOREIGN KEY (D_STATUS_NUM) REFERENCES DELIVERY_STATUS (D_STATUS_NUM)
);

DROP TABLE CUSTOM_ORDER;
CREATE TABLE CUSTOM_ORDER
(
   C_O_NUM NUMBER,
   C_O_DATE DATE DEFAULT SYSDATE,
   C_O_BOOKDATE DATE DEFAULT SYSDATE,
   C_O_CNT NUMBER NOT NULL,
   C_O_PRICE NUMBER(10) NOT NULL,
   C_O_TEXT VARCHAR2(60),
   C_O_SHEET VARCHAR2(20) NOT NULL,
   C_O_TOPPING VARCHAR2(20) NOT NULL,
   C_O_CREAM VARCHAR2(20) NOT NULL,
   C_O_REC_NAME VARCHAR2(50) NOT NULL,
   C_O_REC_CP VARCHAR2(50) NOT NULL,
   C_O_REC_POST VARCHAR2(10) NOT NULL,
   C_O_REC_BASIC_ADDR VARCHAR2(150) NOT NULL,
   C_O_REC_DETAIL_ADDR VARCHAR2(100) NOT NULL,
   C_O_MEMO VARCHAR2(300),
   
   M_ID VARCHAR2(50),
   C_B_NUM VARCHAR2(10),
   BIZ_DELIVERY NUMBER(10),
   D_STATUS_NUM NUMBER
    
    CONSTRAINT CUSTOM_PK_NUM PRIMARY KEY (C_O_NUM),
    CONSTRAINT CUSTOM_FK_ID FOREIGN KEY (M_ID) REFERENCES MEMBER (M_ID),
    CONSTRAINT CUSTOM_FK_P_B_NUM FOREIGN KEY (C_B_NUM) REFERENCES COSTOM_BOARD (C_B_NUM),
    CONSTRAINT CUSTOM_FK_BIZ_DELIVERY FOREIGN KEY (BIZ_DELIVERY) REFERENCES MEMBER_BIZ (BIZ_DELIVERY),
    CONSTRAINT CUSTOM_D_STATUS_NUM FOREIGN KEY (D_STATUS_NUM) REFERENCES DELIVERY_STATUS (D_STATUS_NUM)
);

DROP TABLE CUSTOM_SHEET;
CREATE TABLE CUSTOM_SHEET
(
   M_ID VARCHAR2(50),
   SH_NUM VARCHAR2(20) NOT NULL,
   SH_NAME VARCHAR2(50) NOT NULL,
   SH_PRICE NUMBER  NOT NULL
    
     CONSTRAINT CUSTOM_SHEET_FK_ID FOREIGN KEY (M_ID) REFERENCES MEMBER (M_ID),
);

DROP TABLE CUSTOM_TOPPING;
CREATE TABLE CUSTOM_TOPPING
(
   M_ID VARCHAR2(50),
   TP_NUM VARCHAR2(20) NOT NULL,
   TP_NAME VARCHAR2(50) NOT NULL,
   TP_PRICE NUMBER NOT NULL
     CONSTRAINT CUSTOM_TOPPING_FK_ID FOREIGN KEY (M_ID) REFERENCES MEMBER (M_ID),
);

DROP TABLE CUSTOM_CREAM;
CREATE TABLE CUSTOM_CREAM
(
   M_ID VARCHAR2(50) NOT NULL,
   CR_NUM VARCHAR2(20) NOT NULL,
   CR_NAME VARCHAR2(50) NOT NULL,
   CR_PRICE NUMBER
     CONSTRAINT CUSTOM_CREAM_FK_ID FOREIGN KEY (M_ID) REFERENCES MEMBER (M_ID),
);



DROP TABLE PRODUCT_BOARD CASCADE
CREATE TABLE PRODUCT_BOARD
(
   P_NAME VARCHAR2(100) NOT NULL,
   P_PRICE VARCHAR2(100) NOT NULL,
   P_IMG VARCHAR2(100) NOT NULL,
   P_COUNT NUMBER(10) NOT NULL,
   P_B_NUM NUMBER(10), 
   P_SIZE NUMBER NOT NULL,
   P_CM VARCHAR2(20) NOT NULL,
   P_B_MINI_TITLE VARCHAR2(100) NOT NULL,
   P_B_MINI_CONTENT VARCHAR2(2000) NOT NULL,
   P_B_CONTENT VARCHAR2(4000) NOT NULL,
   P_B_LIKE NUMBER(10)  DEFAULT 0 NOT NULL ,
   P_B_READCNT NUMBER(10)  DEFAULT 0      NOT NULL,
   P_B_YN VARCHAR2(2) NOT NULL,
   P_B_WARN VARCHAR2(4000) NOT NULL,
   P_B_TAG VARCHAR2(2000)  NOT NULL,
   M_ID VARCHAR2(50)  NOT NULL,
   P_COUNT_LIMIT NUMBER(3) DEFAULT 0 NOT NULL,
   CONSTRAINT P_BOARD_PK_NUM PRIMARY KEY (P_B_NUM),
   CONSTRAINT P_BOARD_FK_ID FOREIGN KEY (M_ID) REFERENCES MEMBER(M_ID),
   CONSTRAINT P_BOARD_YN_CK CHECK(P_B_YN IN('Y','N')) 
)

CREATE SEQUENCE SEQ_P_B_NUM 
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
NOCACHE
;


CREATE TABLE CUSTOM_BOARD
(
   C_B_NUM NUMBER(10),
   C_B_MINI_TITLE VARCHAR2(100) NOT NULL, 
   C_B_CONTENT VARCHAR2(4000) NOT NULL,
   C_B_LIKE NUMBER(10)  DEFAULT 0  NOT NULL,
   C_B_READCNT NUMBER(10) DEFAULT 0   NOT NULL,
   C_B_TAG VARCHAR2(2000),
   C_B_WARN VARCHAR2(100),
   C_B_NAME VARCHAR2(100) NOT NULL,
   C_B_PRICE NUMBER(10) NOT NULL,
   M_ID VARCHAR2(50) NOT NULL,
   CONSTRAINT C_BOARD_PK_NUM PRIMARY KEY (C_B_NUM),
   CONSTRAINT C_BOARD_FK_ID FOREIGN KEY (M_ID) REFERENCES MEMBER(M_ID)    
)

CREATE SEQUENCE SEQ_C_B_NUM
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
NOCACHE
;

CREATE TABLE HOME_QNA
(
   H_Q_NUM NUMBER(10),
   H_Q_CONTENT VARCHAR2(4000) NOT NULL,
   H_Q_TITLE VARCHAR2(500) NOT NULL,
   H_Q_DATE DATE DEFAULT SYSDATE NOT NULL,
   M_ID VARCHAR2(50) NOT NULL,
   H_Q_RE_REF NUMBER(10) NOT NULL,
   H_Q_RE_LEV NUMBER DEFAULT 0     NOT NULL ,
   H_Q_RE_SEQ NUMBER DEFAULT 0     NOT NULL,
   CONSTRAINT H_Q_PK_NUM PRIMARY KEY(H_Q_NUM),
   CONSTRAINT H_Q_FK_ID FOREIGN KEY(M_ID) REFERENCES MEMBER(M_ID),
   CONSTRAINT H_Q_FK_RE_REF FOREIGN KEY(H_Q_RE_REF) REFERENCES HOME_QNA(H_Q_NUM)
)

CREATE SEQUENCE SEQ_H_Q_NUM 
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
NOCACHE
;

CREATE TABLE H_QNA_COM
(
   H_Q_C_NUM NUMBER(10),
   H_Q_NUM NUMBER(10) NOT NULL,
   H_Q_C_CONTENT VARCHAR2(4000) NOT NULL,
   H_Q_C_DATE DATE DEFAULT SYSDATE NOT NULL,
   H_Q_C_RE_REF NUMBER(10) NOT NULL,
   H_Q_C_RE_LEV NUMBER DEFAULT 0 NOT NULL,     
   H_Q_C_RE_SEQ NUMBER DEFAULT 0 NOT NULL ,
   M_ID VARCHAR2(50) NOT NULL,
    
   CONSTRAINT H_Q_C_PK_NUM PRIMARY KEY(H_Q_C_NUM),
   CONSTRAINT H_Q_C_FK_NUM FOREIGN KEY(H_Q_NUM) REFERENCES HOME_QNA(H_Q_NUM),
   CONSTRAINT H_Q_C_FK_RE_REF FOREIGN KEY(H_Q_C_RE_REF) REFERENCES H_QNA_COM(H_Q_C_NUM),
   CONSTRAINT H_Q_C_FK_ID FOREIGN KEY(M_ID) REFERENCES MEMBER(M_ID) 
);

CREATE SEQUENCE SEQ_H_Q_C_NUM
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
NOCACHE



CREATE TABLE PRODUCT_QNA
(
   P_Q_NUM NUMBER(10),
   P_Q_CONTENT VARCHAR2(4000)                  NOT NULL,
   P_B_NUM NUMBER(10)                         ,
   P_Q_DATE DATE               DEFAULT SYSDATE NOT NULL,
   M_ID VARCHAR2(100),
    
   CONSTRAINT PRODUCT_QNA_PK_NUM PRIMARY KEY (P_Q_NUM),
    CONSTRAINT PRODUCT_QNA_FK_M_ID FOREIGN KEY (M_ID) REFERENCES MEMBER (M_ID),
    CONSTRAINT PRODUCT_QNA_FK_P_B_NUM FOREIGN KEY (P_B_NUM) REFERENCES PRODUCT_BOARD (P_B_NUM)

)

CREATE SEQUENCE SEQ_P_Q_NUM
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE


CREATE TABLE P_QNA_COM
(
   P_Q_C_NUM NUMBER(10),
   P_Q_NUM NUMBER(10),
   P_Q_C_CONTENT VARCHAR2(4000)    NOT NULL,
   P_Q_C_DATE DATE                 DEFAULT SYSDATE NOT NULL,
    
    CONSTRAINT P_QNA_COM_PK_NUM PRIMARY KEY (P_Q_C_NUM),
    CONSTRAINT P_QNA_COM_FK_NUM FOREIGN KEY (P_Q_NUM) REFERENCES PRODUCT_QNA (P_Q_NUM)
)

CREATE SEQUENCE SEQ_P_Q_C_NUM
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE


CREATE TABLE PRODUCT_REVIEW
(
   P_R_NUM NUMBER(10),
   P_B_NUM NUMBER(10),
   P_R_CONTENT VARCHAR2(4000)                  NOT NULL,
   P_R_DATE DATE               DEFAULT SYSDATE NOT NULL,
   M_ID VARCHAR2(50),
   P_R_LIKE NUMBER(5)          DEFAULT 0       NOT NULL,
   P_R_BLACK NUMBER(1)         DEFAULT 0       NOT NULL,
   P_R_FILE VARCHAR2(1000)                         NULL,
    
    CONSTRAINT P_REVIEW_PK_NUM PRIMARY KEY (P_R_NUM),
    CONSTRAINT P_REVIEW_FK_NUM FOREIGN KEY (P_B_NUM) REFERENCES PRODUCT_BOARD (P_B_NUM),
    CONSTRAINT P_REVIEW_FK_M_ID FOREIGN KEY (M_ID) REFERENCES MEMBER (M_ID)
)

CREATE SEQUENCE SEQ_P_R_NUM
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE


CREATE TABLE P_REVIEW_COM
(
   P_R_C_NUM NUMBER(10),
   P_R_NUM NUMBER(10),
   P_R_C_CONTENT VARCHAR2(4000)                NOT NULL,
   P_R_C_DATE DATE                 DEFAULT SYSDATE NOT NULL,
    CONSTRAINT P_REVIEW_COM_PK_NUM PRIMARY KEY (P_R_C_NUM),
    CONSTRAINT P_REVIEW_FK_NUM FOREIGN KEY (P_R_NUM) REFERENCES PRODUCT_REVIEW (P_R_NUM)
)

CREATE SEQUENCE SEQ_P_R_C_NUM
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE
