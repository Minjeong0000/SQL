-- ���ʽ��� ���� �ʴ� ������� �������
-- �μ��� ��� �޿��� ��ȸ
-- (����޿��� 300���� �̻��� �μ��� ����)
-- (��ձ޿��� ���� ������� ����)
SELECT DEPT_CODE , FLOOR(AVG(SALARY))��ձ޿�
FROM EMPLOYEE
WHERE BONUS IS NULL
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) < 3000000
ORDER BY ��ձ޿� DESC
;

-- ������ 3000���� ������ ������ ���,�̸�,���� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY*12 ����
FROM EMPLOYEE
WHERE SALARY*12 < 30000000
;

--D5�μ��� ��� �̸�, ����, ���� ���
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
;
--������� ������ ���� ���� ����� ���� ���� ����� ���� ����
SELECT MAX(SALARY*12)-MIN(SALARY*12) AS ��������
FROM EMPLOYEE
;

-- EMPLOYEE ���̺��� 
-- ���� ���̰� ���� ������ 
-- �̸�, ���糪��, �ֹι�ȣ, �Ի糯¥('�⵵-��-�� ����'�� ���)�� ���Ͻÿ�
-- �� �� ������� ��� 1900��� �� �Դϴ�.
-- ���̴� �Ҽ����� �߶󳻰� ����մϴ�.
-- ���̰� ���� ���� ������ ���� ���̶��
-- �̸� �������� ����

-- ���ʽ��� �޴� ����� ������� 
-- ���޺� ��� �޿� ��ȸ 
-- ��ձ޿��� ���� ������� ����
-- (��, �������� ���� ����� ��� ��ȸ)
SELECT JOB_CODE,FLOOR(AVG(SALARY))��ձ޿�
FROM EMPLOYEE
WHERE BONUS IS NOT NULL AND ENT_YN = 'N'
GROUP BY JOB_CODE
ORDER BY ��ձ޿� DESC;

-- ���� �������� �̸��� ���̸� ���̰� ���� ������ ��ȸ
-- �̸��� ���� ����, ���̴� ������ ���
-- EX �̸� ����
--    ���� 61��
--    �浿 54�� 


-- �μ��߿� �޿� �հ谡 ���� ���� �μ���?
-- (��, EMPLOYEE �������� Ǯ����Ѵ�.)
SELECT DEPT_CODE, SUM(SALARY) AS �޿��հ�
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY �޿��հ�
;

--���ʽ��� �޴� ������� ��� �ڵ带 ��ȸ
--��� �޿��� 3000000�� �̻��� ����鸸
SELECT *
FROM EMPLOYEE
WHERE SALARY>3000000 AND BONUS IS NOT NULL
;

--�μ��� ������ ���� ������ ���������� �̸�, ���, ����, ��ȸ 

SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
;
-- �� �μ����� ������ ���� ���� ����� ��ȭ��ȣ
SELECT DEPT_CODE ,PHONE
FROM EMPLOYEE

GROUP BY DEPT_CODE
;

--�μ� ��� �޿��� 400���� �̻��� �μ��� ��ȸ(�Ҽ��� ���ý� �Ҽ��� ���ϴ� ������)

SELECT DEPT_CODE , FLOOR(AVG(SALARY)) ��ձ޿�
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY))>4000000
;

-- ���ʽ��� �޴� ������� �������
-- �μ��� ��� ���ʽ� ��ȸ
SELECT DEPT_CODE , AVG(BONUS)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY DEPT_CODE
;



--���� ����� �������
--���޺� ��ü �޿��� ��ȸ (��Ī : �޿��Ѿ�)
--�����ڵ� J4 ����
--�޿����� ���� ������� ����

SELECT JOB_CODE, SUM(SALARY) �޿��Ѿ�
FROM EMPLOYEE
WHERE JOB_CODE != 'J4' AND SUBSTR(EMP_NO,8,1) = 2
GROUP BY JOB_CODE
ORDER BY 2;

SELECT 
    JOB_CODE
    ,SUM(SALARY) �޿��Ѿ�
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2
GROUP BY JOB_CODE
HAVING JOB_CODE != 'J4'
ORDER BY "�޿��Ѿ�" ASC;

-- �μ��ڵ庰 ������̵� ��ȣ�� ���� ��������� �μ��ڵ�� ������̵� ��ȸ
--(���ʽ��� �ִ� ����� ����)


SELECT DEPT_CODE, MIN(EMP_ID)
FROM EMPLOYEE
WHERE BONUS IS NULL 
GROUP BY DEPT_CODE;

-- ������ ����� �ִ� ����� �������
-- �μ��� �� �޿��� ��ȸ
-- (�޿� ���� ������� ����)
SELECT DEPT_CODE, SUM(SALARY)�ѱ޿�
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY 2 DESC
;


--1. �����ȣ 200���� ������ �̸���, �����ڵ� ���
SELECT 
    EMP_NAME
    ,JOB_CODE
FROM EMPLOYEE
WHERE EMP_ID = 200
;
--2. ȸ���� ������ �������� ���� '��'���� ����� ��� ���� �ڽŰ� ������ '��'���� �����Ű���� �Ѵ�. �����Ͽ��� �� ���̱� ���� ������ ���Ѻ���
SELECT REPLACE(EMP_NAME, '��' ,'��')
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%'
;
--3. �⻵�� �������� �̸��� ������ �������� ������ �ϳ��� ���̷��� �Ѵ�.
SELECT REPLACE(EMP_NAME, '��', '��') , 'J' || (SUBSTR(JOB_CODE,2 ,1)-1), JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%'
;

 --�Ի�⵵�� ���� ������� ��ձ޿��� ���� 250�������� ���� ����鿡�� ������ ��Ű�� �Ѵ�
 --�̻������ �Ի�⵵�� �޿��� ��ȸ�϶�
SELECT EXTRACT(YEAR FROM HIRE_DATE),AVG(SALARY)
FROM EMPLOYEE
GROUP BY EXTRACT(YEAR FROM HIRE_DATE)
HAVING AVG(SALARY)<2500000
ORDER BY 1
;


--����̸��� ���� ���� ���
SELECT EMP_NAME,(100-SUBSTR(EMP_NO,0,2))+TO_CHAR(SYSDATE,'YY') || '��' AS ����
FROM EMPLOYEE
ORDER BY ����;

--�μ��� �ְ�޿� ��ȸ
SELECT DEPT_CODE,MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1
;

--1.  ���س⵵�� 2017�⵵�̴� ������ 5�� �̸��̰� ������ �븮�� ������ ���, �̸�, ����, ���� ��ȸ
SELECT
    EMP_NAME
    ,EMP_ID
    ,JOB_CODE
    ,FLOOR(MONTHS_BETWEEN(
    TO_DATE('2017-01-01'
    ,'YYYY-MM-DD')
    ,HIRE_DATE)/12) ����
FROM EMPLOYEE
WHERE JOB_CODE = 'J6' 
    AND MONTHS_BETWEEN
    (TO_DATE('2017-01-01'
    , 'YYYY-MM-DD')
    ,HIRE_DATE) <60
;

SELECT EMP_ID, EMP_NAME,  2017 -TO_CHAR(HIRE_DATE, 'RRRR') ����, JOB_CODE
FROM EMPLOYEE
WHERE TO_CHAR(HIRE_DATE, 'RRRR') > 2012 AND JOB_CODE ='J6';




-- ���޺� ��� �޿��� 200���� �̻��� �μ����� ��ȭ��ȣ 4��° �ڸ��� 3�� ����� ��ȸ
-- �߰����� : (010-X123-4567) ���⼭ X�� 3�� ���

SELECT JOB_CODE
FROM EMPLOYEE
WHERE SUBSTR(PHONE, 5, 1) = '3'
GROUP BY JOB_CODE
HAVING AVG(SALARY) >= 2000000
;


-- �������, ������� ��� �� ���ϱ�
SELECT SUBSTR(EMP_NO,8,1),COUNT(*)  
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1);

-- ȸ�� ä�� ������ �ý����� �����Ϸ��� �Ѵ�.
-- �׷��� ���ؼ��� �켱, �Ի糪�̴� ���������� �ľ��ؾ��Ѵ�.
-- ������ ������ �Ի糪�̸� ���� ������� ������. (2023�⵵������ �ѱ����̷� ���)
SELECT
    EMP_NAME �����
    , TO_NUMBER(TO_CHAR(HIRE_DATE, 'RRRR')) - TO_NUMBER('19' || SUBSTR(EMP_NO, 1, 2)) �Ի糪��
    , TO_NUMBER(TO_CHAR(SYSDATE, 'RRRR')) - TO_NUMBER('19' || SUBSTR(EMP_NO, 1, 2)) ���糪��
    , '19' || SUBSTR(EMP_NO, 1, 2) ����
    , TO_CHAR(HIRE_DATE, 'RRRR') �Ի�⵵
FROM EMPLOYEE
ORDER BY �Ի糪�� ASC
;

--�����ڰ� �ִ� �μ��ڵ� , �� ��� �̸� �� ������ ���Ͻÿ�
--���ʽ��� �޴� �μ��ڵ�, ��� �޿���  ��ȸ�Ͻÿ�(��ձ޿��� ���� �������)


SELECT DEPT_CODE, EMP_NAME , SALARY * 12 ����
FROM EMPLOYEE
WHERE ENT_YN  = 'Y';

SELECT EMP_ID ,AVG(SALARY)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY EMP_ID
ORDER BY AVG(SALARY) DESC;

--�� ���޺��� ��� ����(�Ҽ������� �ݿø�)�� ���ʽ��� �޴� �ο��� ��ȸ

SELECT 
    JOB_CODE
    , ROUND(AVG(SALARY))
    , COUNT(BONUS)
FROM EMPLOYEE
GROUP BY JOB_CODE
;
