

--------------------------------
---------- ������ ����-----------
--------------------------------
DROP SEQUENCE SEQ_FOOD_NO;
DROP SEQUENCE SEQ_F_CATEGORY_NO;
--------------------------------
---------- ������ ���� ----------
CREATE SEQUENCE  SEQ_FOOD_NO NOCACHE NOCYCLE;
CREATE SEQUENCE SEQ_F_CATEGORY_NO NOCACHE NOCYCLE;


--------------------------------
---------- ���̺� ���� -----------
--------------------------------
DROP TABLE FOOD CASCADE CONSTRAINTS;
DROP TABLE F_CATEGORY CASCADE CONSTRAINTS;

----------------------------------------
---------------CREATE����----------------
----------------------------------------
CREATE TABLE FOOD (
	NO      	NUMBER		    CONSTRAINT PK_FOOD_NO PRIMARY KEY
    ,NAME    	VARCHAR2(100)	CONSTRAINT NN_FOOD_NAME NOT NULL
    ,PRICE	    NUMBER		    CONSTRAINT NN_FOOD_PRICE NOT NULL
    ,HEAT_YN	CHAR(1)		    DEFAULT 'N' CONSTRAINT CK_FOOD_HEAT CHECK(HEAT_YN IN('Y','N'))
    ,DELETE_YN	CHAR(1)		    DEFAULT 'N' CONSTRAINT CK_FOOD_DELETE CHECK(DELETE_YN IN('Y','N'))
    ,EXPOSE_YN	CHAR(1)		    DEFAULT 'N' CONSTRAINT CK_FOOD_EXPOSE CHECK(EXPOSE_YN IN('Y','N'))
    ,FOOD_CODE	NUMBER		    NOT NULL
);
CREATE TABLE F_CATEGORY (
	NUM	        NUMBER		    PRIMARY KEY,
	CATEGORY	VARCHAR(255)	NOT NULL
);

--------------------------------
---------- �ܷ�Ű �߰� -----------
--------------------------------
ALTER TABLE F_CATEGORY
ADD CONSTRAINT FK_Ǫ�����̺����������̸���������
FOREIGN KEY (NUM) REFERENCES FOOD(NO);