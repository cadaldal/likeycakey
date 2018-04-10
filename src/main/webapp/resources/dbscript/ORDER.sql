-- PRODUCT_ORDER TABLE
ALTER TABLE PRODUCT_ORDER
	DROP
		CONSTRAINT FK_MEMBER_TO_PRODUCT_ORDER
		CASCADE;

ALTER TABLE PRODUCT_ORDER
	DROP
		CONSTRAINT FK_PRODUCT_BOARD_TO_PRODUCT_ORDER
		CASCADE;

ALTER TABLE PRODUCT_ORDER
	DROP
		CONSTRAINT FK_STATUS_TO_PRODUCT_ORDER
		CASCADE;

ALTER TABLE PRODUCT_ORDER
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

DROP INDEX PK_PRODUCT_ORDER;

/* 완제품 케이크 주문 */
DROP TABLE PRODUCT_ORDER 
	CASCADE CONSTRAINTS;

/* 완제품 케이크 주문 */
CREATE TABLE PRODUCT_ORDER (
	P_O_NUM NUMBER NOT NULL, /* 주문 번호 */
	P_B_NUM NUMBER NOT NULL, /* 참조 게시글 번호 */
	S_NUM NUMBER NOT NULL, /* 주문 진행상태 */
	M_ID VARCHAR2(50) NOT NULL, /* 주문자 */
	BIZ_DERIVERY NUMBER, /* 배송비 */
	P_O_MEMO VARCHAR2(300), /* 배송 메모 */
	P_O_DATE DATE NOT NULL, /* 주문 일자 */
	P_O_BOOKDATE DATE NOT NULL, /* 예약 날짜 */
	P_O_CNT NUMBER NOT NULL, /* 주문 수량 */
	P_O_PRICE NUMBER NOT NULL, /* 총 상품 가격 */
	P_O_TEXT VARCHAR2(60), /* 문구  */
	P_O_REC_NAME VARCHAR2(50) NOT NULL, /* 받는 사람 이름 */
	P_O_REC_CP VARCHAR2(50) NOT NULL, /* 받는 사람 번호 */
	P_O_REC_POST VARCHAR2(10) NOT NULL, /* 받는 사람 우편번호 */
	P_O_REC_BASIC_ADDR VARCHAR2(1000) NOT NULL, /* 받는 사람 기본주소 */
	P_O_REC_DETAIL_ADDR VARCHAR2(1000) NOT NULL /* 받는 사람 상세주소 */
);

COMMENT ON TABLE PRODUCT_ORDER IS '완제품 케이크 주문';

COMMENT ON COLUMN PRODUCT_ORDER.P_O_NUM IS '주문 번호';

COMMENT ON COLUMN PRODUCT_ORDER.P_B_NUM IS '참조 게시글 번호';

COMMENT ON COLUMN PRODUCT_ORDER.S_NUM IS '주문 진행상태';

COMMENT ON COLUMN PRODUCT_ORDER.M_ID IS '주문자';

COMMENT ON COLUMN PRODUCT_ORDER.BIZ_DERIVERY IS '배송비';

COMMENT ON COLUMN PRODUCT_ORDER.P_O_MEMO IS '배송 메모';

COMMENT ON COLUMN PRODUCT_ORDER.P_O_DATE IS '주문 일자';

COMMENT ON COLUMN PRODUCT_ORDER.P_O_BOOKDATE IS '예약 날짜';

COMMENT ON COLUMN PRODUCT_ORDER.P_O_CNT IS '주문 수량';

COMMENT ON COLUMN PRODUCT_ORDER.P_O_PRICE IS '총 상품 가격';

COMMENT ON COLUMN PRODUCT_ORDER.P_O_TEXT IS '문구 ';

COMMENT ON COLUMN PRODUCT_ORDER.P_O_REC_NAME IS '받는 사람 이름';

COMMENT ON COLUMN PRODUCT_ORDER.P_O_REC_CP IS '받는 사람 번호';

COMMENT ON COLUMN PRODUCT_ORDER.P_O_REC_POST IS '받는 사람 우편번호';

COMMENT ON COLUMN PRODUCT_ORDER.P_O_REC_BASIC_ADDR IS '받는 사람 기본주소';

COMMENT ON COLUMN PRODUCT_ORDER.P_O_REC_DETAIL_ADDR IS '받는 사람 상세주소';

CREATE UNIQUE INDEX PK_PRODUCT_ORDER
	ON PRODUCT_ORDER (
		P_O_NUM ASC
	);

ALTER TABLE PRODUCT_ORDER
	ADD
		CONSTRAINT PK_PRODUCT_ORDER
		PRIMARY KEY (
			P_O_NUM
		);

ALTER TABLE PRODUCT_ORDER
	ADD
		CONSTRAINT FK_MEMBER_TO_PRODUCT_ORDER
		FOREIGN KEY (
			M_ID
		)
		REFERENCES MEMBER (
			M_ID
		);

ALTER TABLE PRODUCT_ORDER
	ADD
		CONSTRAINT FK_PRODUCT_BOARD_TO_PRODUCT_ORDER
		FOREIGN KEY (
			P_B_NUM
		)
		REFERENCES PRODUCT_BOARD (
			P_B_NUM
		);

ALTER TABLE PRODUCT_ORDER
	ADD
		CONSTRAINT FK_STATUS_TO_PRODUCT_ORDER
		FOREIGN KEY (
			S_NUM
		)
		REFERENCES STATUS (
			S_NUM
		);


-- CUSTOM_ORDER TABLE
ALTER TABLE CUSTOM_ORDER
	DROP
		CONSTRAINT FK_MEMBER_TO_CUSTOM_ORDER
		CASCADE;

ALTER TABLE CUSTOM_ORDER
	DROP
		CONSTRAINT FK_CUSTOM_BOARD_TO_CUSTOM_ORDER
		CASCADE;

ALTER TABLE CUSTOM_ORDER
	DROP
		CONSTRAINT FK_STATUS_TO_CUSTOM_ORDER
		CASCADE;

ALTER TABLE CUSTOM_ORDER
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

DROP INDEX PK_CUSTOM_ORDER;

/* 커스텀 케이크 주문 */
DROP TABLE CUSTOM_ORDER 
	CASCADE CONSTRAINTS;

/* 커스텀 케이크 주문 */
CREATE TABLE CUSTOM_ORDER (
	C_O_NUM NUMBER NOT NULL, /* 커스텀 케이크 주문 번호 */
	C_B_NUM NUMBER NOT NULL, /* 커스텀 케이크 페이지 참조 번호 */
	S_NUM NUMBER NOT NULL, /* 주문 진행상태 */
	M_ID VARCHAR2(50) NOT NULL, /* 주문자 */
	BIZ_DELIVERY NUMBER, /* 배송비 */
	C_O_MEMO VARCHAR2(300), /* 배송 메모 */
	C_O_DATE DATE NOT NULL, /* 커스텀 케이크 주문 일자 */
	C_O_BOOKDATE DATE NOT NULL, /* 커스텀 케이크 예약 날짜 */
	C_O_CNT NUMBER NOT NULL, /* 커스텀 케이크 주문수량 */
	C_O_PRICE NUMBER NOT NULL, /* 총 삼품 가격 */
	C_O_TEXT VARCHAR2(60), /* 케이크 문구 */
	C_O_SIZE VARCHAR2(20) NOT NULL, /* 커스텀 케이크 사이즈 */
	C_O_SHEET VARCHAR2(20) NOT NULL, /* 커스텀 케이크 선택 시트 */
	C_O_TOPPING VARCHAR2(20) NOT NULL, /* 커스텀 케이크 선택 토핑 */
	C_O_CREAM VARCHAR2(20) NOT NULL, /* 커스텀 케이크 선택 크림 */
	C_O_REC_NAME VARCHAR2(50) NOT NULL, /* 받는 사람 이름 */
	C_O_REC_CP VARCHAR2(50) NOT NULL, /* 받는 사람 전화번호 */
	C_O_REC_POST VARCHAR2(10) NOT NULL, /* 받는 사람 우편번호 */
	C_O_REC_BASIC_ADDR VARCHAR2(1000) NOT NULL, /* 받는 사람 기본주소 */
	C_O_REC_DETAIL_ADDR VARCHAR2(1000) NOT NULL /* 받는 사람 상세주소 */
);

COMMENT ON TABLE CUSTOM_ORDER IS '커스텀 케이크 주문';

COMMENT ON COLUMN CUSTOM_ORDER.C_O_NUM IS '커스텀 케이크 주문 번호';

COMMENT ON COLUMN CUSTOM_ORDER.C_B_NUM IS '커스텀 케이크 페이지 참조 번호';

COMMENT ON COLUMN CUSTOM_ORDER.S_NUM IS '주문 진행상태';

COMMENT ON COLUMN CUSTOM_ORDER.M_ID IS '주문자';

COMMENT ON COLUMN CUSTOM_ORDER.BIZ_DELIVERY IS '배송비';

COMMENT ON COLUMN CUSTOM_ORDER.C_O_MEMO IS '배송 메모';

COMMENT ON COLUMN CUSTOM_ORDER.C_O_DATE IS '커스텀 케이크 주문 일자';

COMMENT ON COLUMN CUSTOM_ORDER.C_O_BOOKDATE IS '커스텀 케이크 예약 날짜';

COMMENT ON COLUMN CUSTOM_ORDER.C_O_CNT IS '커스텀 케이크 주문수량';

COMMENT ON COLUMN CUSTOM_ORDER.C_O_PRICE IS '총 삼품 가격';

COMMENT ON COLUMN CUSTOM_ORDER.C_O_TEXT IS '케이크 문구';

COMMENT ON COLUMN CUSTOM_ORDER.C_O_SIZE IS '커스텀 케이크 사이즈';

COMMENT ON COLUMN CUSTOM_ORDER.C_O_SHEET IS '커스텀 케이크 선택 시트';

COMMENT ON COLUMN CUSTOM_ORDER.C_O_TOPPING IS '커스텀 케이크 선택 토핑';

COMMENT ON COLUMN CUSTOM_ORDER.C_O_CREAM IS '커스텀 케이크 선택 크림';

COMMENT ON COLUMN CUSTOM_ORDER.C_O_REC_NAME IS '받는 사람 이름';

COMMENT ON COLUMN CUSTOM_ORDER.C_O_REC_CP IS '받는 사람 전화번호';

COMMENT ON COLUMN CUSTOM_ORDER.C_O_REC_POST IS '받는 사람 우편번호';

COMMENT ON COLUMN CUSTOM_ORDER.C_O_REC_BASIC_ADDR IS '받는 사람 기본주소';

COMMENT ON COLUMN CUSTOM_ORDER.C_O_REC_DETAIL_ADDR IS '받는 사람 상세주소';

CREATE UNIQUE INDEX PK_CUSTOM_ORDER
	ON CUSTOM_ORDER (
		C_O_NUM ASC
	);

ALTER TABLE CUSTOM_ORDER
	ADD
		CONSTRAINT PK_CUSTOM_ORDER
		PRIMARY KEY (
			C_O_NUM
		);

ALTER TABLE CUSTOM_ORDER
	ADD
		CONSTRAINT FK_MEMBER_TO_CUSTOM_ORDER
		FOREIGN KEY (
			M_ID
		)
		REFERENCES MEMBER (
			M_ID
		);

ALTER TABLE CUSTOM_ORDER
	ADD
		CONSTRAINT FK_CUSTOM_BOARD_TO_CUSTOM_ORDER
		FOREIGN KEY (
			C_B_NUM
		)
		REFERENCES CUSTOM_BOARD (
			C_B_NUM
		);

ALTER TABLE CUSTOM_ORDER
	ADD
		CONSTRAINT FK_STATUS_TO_CUSTOM_ORDER
		FOREIGN KEY (
			S_NUM
		)
		REFERENCES STATUS (
			S_NUM
		);
		
		
-- CUSTOM_SHEET
		ALTER TABLE CUSTOM_SHEET
	DROP
		CONSTRAINT FK_MEMBER_TO_CUSTOM_SHEET
		CASCADE;

ALTER TABLE CUSTOM_SHEET
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

DROP INDEX PK_CUSTOM_SHEET;

/* 커스텀 시트 */
DROP TABLE CUSTOM_SHEET 
	CASCADE CONSTRAINTS;

/* 커스텀 시트 */
CREATE TABLE CUSTOM_SHEET (
	SH_NUM VARCHAR2(20) NOT NULL, /* 시트 번호 */
	M_ID VARCHAR2(50) NOT NULL, /* 사업자 회원 아이디 */
	SH_NAME VARCHAR2(50) NOT NULL, /* 시트 종류 */
	SH_PRICE NUMBER NOT NULL /* 시트 추가 가격 */
);

COMMENT ON TABLE CUSTOM_SHEET IS '커스텀 시트';

COMMENT ON COLUMN CUSTOM_SHEET.SH_NUM IS '시트 번호';

COMMENT ON COLUMN CUSTOM_SHEET.M_ID IS '사업자 회원 아이디';

COMMENT ON COLUMN CUSTOM_SHEET.SH_NAME IS '시트 종류';

COMMENT ON COLUMN CUSTOM_SHEET.SH_PRICE IS '시트 추가 가격';

CREATE UNIQUE INDEX PK_CUSTOM_SHEET
	ON CUSTOM_SHEET (
		SH_NUM ASC
	);

ALTER TABLE CUSTOM_SHEET
	ADD
		CONSTRAINT PK_CUSTOM_SHEET
		PRIMARY KEY (
			SH_NUM
		);

ALTER TABLE CUSTOM_SHEET
	ADD
		CONSTRAINT FK_MEMBER_TO_CUSTOM_SHEET
		FOREIGN KEY (
			M_ID
		)
		REFERENCES MEMBER (
			M_ID
		);
		
		
-- CUSTOM_CREAM
ALTER TABLE COUSTOM_CREAM
	DROP
		CONSTRAINT FK_MEMBER_TO_COUSTOM_CREAM
		CASCADE;

ALTER TABLE COUSTOM_CREAM
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

DROP INDEX PK_COUSTOM_CREAM;

/* 커스텀 크림 */
DROP TABLE COUSTOM_CREAM 
	CASCADE CONSTRAINTS;

/* 커스텀 크림 */
CREATE TABLE COUSTOM_CREAM (
	CR_NUM VARCHAR2(20) NOT NULL, /* 크림 번호 */
	M_ID VARCHAR2(50) NOT NULL, /* 사업자 회원 아이디 */
	CR_NAME VARCHAR2(50) NOT NULL, /* 크림 종류 */
	CR_PRICE NUMBER NOT NULL /* 크림 추가 가격 */
);

COMMENT ON TABLE COUSTOM_CREAM IS '커스텀 크림';

COMMENT ON COLUMN COUSTOM_CREAM.CR_NUM IS '크림 번호';

COMMENT ON COLUMN COUSTOM_CREAM.M_ID IS '사업자 회원 아이디';

COMMENT ON COLUMN COUSTOM_CREAM.CR_NAME IS '크림 종류';

COMMENT ON COLUMN COUSTOM_CREAM.CR_PRICE IS '크림 추가 가격';

CREATE UNIQUE INDEX PK_COUSTOM_CREAM
	ON COUSTOM_CREAM (
		CR_NUM ASC
	);

ALTER TABLE COUSTOM_CREAM
	ADD
		CONSTRAINT PK_COUSTOM_CREAM
		PRIMARY KEY (
			CR_NUM
		);

ALTER TABLE COUSTOM_CREAM
	ADD
		CONSTRAINT FK_MEMBER_TO_COUSTOM_CREAM
		FOREIGN KEY (
			M_ID
		)
		REFERENCES MEMBER (
			M_ID
		);
		
		
-- CUSTOM_TOPPING
ALTER TABLE CUSTOM_TOPPING
	DROP
		CONSTRAINT FK_MEMBER_TO_CUSTOM_TOPPING
		CASCADE;

ALTER TABLE CUSTOM_TOPPING
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

DROP INDEX PK_CUSTOM_TOPPING;

/* 커스텀 토핑 */
DROP TABLE CUSTOM_TOPPING 
	CASCADE CONSTRAINTS;

/* 커스텀 토핑 */
CREATE TABLE CUSTOM_TOPPING (
	TP_NUM VARCHAR2(20) NOT NULL, /* 토핑 번호 */
	M_ID VARCHAR2(50) NOT NULL, /* 사업자 회원 아이디 */
	TP_NAME VARCHAR2(50) NOT NULL, /* 토핑 종류 */
	TP_PRICE NUMBER NOT NULL /* 토핑 추가 가격 */
);

COMMENT ON TABLE CUSTOM_TOPPING IS '커스텀 토핑';

COMMENT ON COLUMN CUSTOM_TOPPING.TP_NUM IS '토핑 번호';

COMMENT ON COLUMN CUSTOM_TOPPING.M_ID IS '사업자 회원 아이디';

COMMENT ON COLUMN CUSTOM_TOPPING.TP_NAME IS '토핑 종류';

COMMENT ON COLUMN CUSTOM_TOPPING.TP_PRICE IS '토핑 추가 가격';

CREATE UNIQUE INDEX PK_CUSTOM_TOPPING
	ON CUSTOM_TOPPING (
		TP_NUM ASC
	);

ALTER TABLE CUSTOM_TOPPING
	ADD
		CONSTRAINT PK_CUSTOM_TOPPING
		PRIMARY KEY (
			TP_NUM
		);

ALTER TABLE CUSTOM_TOPPING
	ADD
		CONSTRAINT FK_MEMBER_TO_CUSTOM_TOPPING
		FOREIGN KEY (
			M_ID
		)
		REFERENCES MEMBER (
			M_ID
		);
		
		
-- CUSTOM_SIZE
ALTER TABLE CUSTOM_SIZE
	DROP
		CONSTRAINT FK_MEMBER_TO_CUSTOM_SIZE
		CASCADE;

ALTER TABLE CUSTOM_SIZE
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

DROP INDEX PK_CUSTOM_SIZE;

/* 커스텀 사이즈 */
DROP TABLE CUSTOM_SIZE 
	CASCADE CONSTRAINTS;

/* 커스텀 사이즈 */
CREATE TABLE CUSTOM_SIZE (
	SIZE_NUM VARCHAR2(20) NOT NULL, /* 사이즈 번호 */
	M_ID VARCHAR2(50) NOT NULL, /* 사업자 회원 아이디 */
	SIZE_NAME VARCHAR2(50) NOT NULL, /* 사이즈 종류 */
	SIZE_PRICE NUMBER NOT NULL /* 사이즈 추가 가격 */
);

COMMENT ON TABLE CUSTOM_SIZE IS '커스텀 사이즈';

COMMENT ON COLUMN CUSTOM_SIZE.SIZE_NUM IS '사이즈 번호';

COMMENT ON COLUMN CUSTOM_SIZE.M_ID IS '사업자 회원 아이디';

COMMENT ON COLUMN CUSTOM_SIZE.SIZE_NAME IS '사이즈 종류';

COMMENT ON COLUMN CUSTOM_SIZE.SIZE_PRICE IS '사이즈 추가 가격';

CREATE UNIQUE INDEX PK_CUSTOM_SIZE
	ON CUSTOM_SIZE (
		SIZE_NUM ASC
	);

ALTER TABLE CUSTOM_SIZE
	ADD
		CONSTRAINT PK_CUSTOM_SIZE
		PRIMARY KEY (
			SIZE_NUM
		);

ALTER TABLE CUSTOM_SIZE
	ADD
		CONSTRAINT FK_MEMBER_TO_CUSTOM_SIZE
		FOREIGN KEY (
			M_ID
		)
		REFERENCES MEMBER (
			M_ID
		);