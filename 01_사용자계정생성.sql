--������
--MEMBER TABLE ���� (ID, PWD, NICK 3�� Į��)
CREATE TABLE MEMBER(
    ID VARCHAR2(100)    --IDĮ�� ����. Ÿ���� �������ڿ�, �ִ� 100����Ʈ
    ,PWD VARCHAR2(100)  --PWDĮ�� ����. Ÿ���� �������ڿ�, �ִ� 100����Ʈ
    ,NICK VARCHAR2(100) --NICKĮ�� ����. Ÿ���� �������ڿ�, �ִ� 100����Ʈ
    );
--������ ����(CREATE )
INSERT INTO MEMBER(ID,PWD,NICK) VALUES('USER01','1111','NICK01');
INSERT INTO MEMBER(ID,PWD,NICK) VALUES('USER02','2222','NICK02');
INSERT INTO MEMBER(ID,PWD,NICK) VALUES('USER03','3333','NICK03');

--������ �б� (READ)
SELECT *FROM MEMBER;

--������ ����(UPDATE)
UPDATE MEMBER SET PWD = '7777'; --MEMBER���̺��� ��� ȸ�� ����� 7777�� �ٲ�

--������ ����(DELETE)
DELETE MEMBER;--���Ӥ��͸� ����, ���̺��� ��������

--���̺� ����
DROP TABLE MEMBER;--X���̺� ��ü�� ������.�����͵� ���� ������


----------------------

--���̺� ����
CREATE TABLE HELLO(
    ID VARCHAR2(100)
    , PWD VARCHAR2(100)
);
--������ �ֱ�
INSERT INTO HELLO(ID,PWD)
VALUES('USER01','1234');

--������ ��ȸ
SELECT ID, PWD  FROM HELLO;
SELECT ID       FROM HELLO;
SELECT PWD      FROM HELLO;
SELECT *        FROM HELLO;

--������ ����
UPDATE HELLO SET PWD ='9999' WHERE ID = 'USER01';

--������ ����
DELETE HELLO WHERE ID = 'USER01';

--���̺� ����
DROP TABLE HELLO;