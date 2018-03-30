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