/*
    <SUBQUERY>
        �ϳ��� SQL �� �ȿ� ���Ե� �� �ٸ� SQL ���� ���Ѵ�. 
        ���� ����(���� ����)�� �����ϴ� ������ �ϴ� �������̴�.
        ��ȣ ���� ���������� ���� �������� ���� ����. �鿩���°��� ����
*/
--���ö ����� ���� �μ��� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö'
;

SELECT*
FROM EMPLOYEE
WHERE DEPT_CODE =
(
    SELECT DEPT_CODE
    FROM EMPLOYEE
    WHERE EMP_NAME = '���ö'
)
;

/*
    <���� ���� ����>
        ���� ������ ���� ������ ������ ������� ��� ���� ������ ���� �з��� �� �ִ�.
        
        1) ������ ���Ͽ� ���� ����  : ���� ������ ��ȸ ��� ���� ��� ���� ������ 1�� �� ��
        2) ������ ���� ����        : ���� ������ ��ȸ ��� ���� ���� ������ ���� �� �� ��
        3) ���߿� ���� ����        : ���� ������ ��ȸ ��� ���� �� �������� Į���� ������ �϶�
        4) ������, ���߿� ���� ���� : ���� ������ ��ȸ ��� ���� ������, ������ �� ��
        
        * ���� ������ ������ ���� ���� ���� �տ� �ٴ� �����ڰ� �޶�����.
        
    <������ ���� ����>
        ���� ������ ��ȸ ��� ���� ��� ���� ������ 1�� �� �� (������, ���Ͽ�)
        �� ������(������ ������) ��� ���� (=, !=, <>, ^=, >, <, >=, <=, ...)
*/
-- 1) �� ������ ��� �޿����� �޿��� ���� �޴� �������� �̸�, ���� �ڵ�, �޿� ��ȸ
SELECT AVG(SALARY)
FROM EMPLOYEE
;


SELECT 
    EMP_NAME    AS �̸�
    ,JOB_CODE   AS "���� �ڵ�"
    ,SALARY     AS �޿�
FROM EMPLOYEE
WHERE SALARY<
            (   SELECT AVG(SALARY)
                FROM EMPLOYEE
            )
;
-- 2) ���� �޿��� �޴� ������ ���, �̸�, ���� �ڵ�, �޿�, �Ի��� ��ȸ
SELECT MIN(SALARY)
FROM EMPLOYEE;

SELECT 
    EMP_ID
    ,EMP_NAME
    ,JOB_CODE
    ,SALARY
    ,HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (
                SELECT MIN(SALARY)
                FROM EMPLOYEE
                )
;

-- 3) ���ö ����� �޿����� �� ���� �޿��޴� ������� ���, �����, �μ���, ���� �ڵ�, �޿� ��ȸ
SELECT SALARY
FROM EMPLOYEE
WHERE EMP_NAME ='���ö'
;

SELECT 
        EMP_ID
        ,EMP_NAME
        ,DEPT_TITLE
        ,JOB_CODE
        ,SALARY
        
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE SALARY>(
                SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME ='���ö'
                )
;
-- 4) �μ��� �޿��� ���� ���� ū �μ��� �μ� �ڵ�, �޿��� �� ��ȸ
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
;

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) =(
                    SELECT MAX(SUM(SALARY))
                    FROM EMPLOYEE
                    GROUP BY DEPT_CODE
)
;

-- 5) ������ ����� �����ִ� �μ����� ��ȸ (��, ������ ����� ����)
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '������'
;

SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE =( 
    SELECT DEPT_CODE
    FROM EMPLOYEE
    WHERE EMP_NAME = '������'
    ) AND EMP_NAME != '������'
;


/*
    <������ ���� ����>
        ���� ������ ��ȸ ��� ���� ���� ������ ���� �� �� ��
        
        IN / NOT IN (���� ����) : ���� ���� ����� �߿��� �� ���� ��ġ�ϴ� ���� �ִٸ� Ȥ�� ���ٸ� TRUE�� �����Ѵ�.
        ANY : ���� ���� ���� �߿��� �� ���� �����ϸ� TRUE, IN�� �ٸ� ���� �� �����ڸ� �Բ� ����Ѵٴ� ���̴�. 
            ANY(100, 200, 300)
            SALARY = ANY(...)  : IN�� ���� ���
            SALARY != ANY(...) : NOT IN�� ���� ���
            SALARY > ANY(...)  : �ּҰ� ���� ũ�� TRUE
            SALARY < ANY(...)  : �ִ밪 ���� ������ TRUE
        ALL : ���� ���� ���� ��ο� ���Ͽ� �����ؾ� TRUE, IN�� �ٸ� ���� �� �����ڸ� �Բ� ����Ѵٴ� ���̴�.
            ALL(100, 200, 300)
            SALARY > ALL(...)  : �ִ밪 ���� ũ�� TRUE
            SALARY < ALL(...)  : �ּҰ� ���� ������ TRUE
*/

-- 1) �� �μ��� �ְ� �޿��� �޴� ������ �̸�, ���� �ڵ�, �μ� �ڵ�, �޿� ��ȸ
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
;
SELECT EMP_NAME, JOB_CODE,DEPT_CODE,SALARY 
FROM EMPLOYEE
WHERE SALARY IN(SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE)
;

-- 2) �� �����鿡 ���� ���, �̸�, �μ� �ڵ�, ����(���/���) --SELECT�� �ȿ� ��������
SELECT 
    EMP_ID AS ���
    ,EMP_NAME AS �̸�
    ,DEPT_CODE AS �μ��ڵ�
    ,CASE 
        WHEN EMP_ID IN (
                        SELECT DISTINCT(MANAGER_ID)
                        FROM EMPLOYEE
                        WHERE MANAGER_ID IS NOT NULL
                        )THEN '���'  
        ELSE '���'
        END
    AS ����
FROM EMPLOYEE
;
----------
SELECT DISTINCT(MANAGER_ID)
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL
;
-----------
-- 3) �븮 �����ӿ��� ���� ���޵��� �ּ� �޿����� ���� �޴� ������ ���, �̸�, ���޸�, �޿� ��ȸ
SELECT
    EMP_ID
    ,EMP_NAME
    ,JOB_NAME
    ,SALARY
FROM EMPLOYEE E
JOIN JOB J
ON E.JOB_CODE = J.JOB_CODE
WHERE JOB_NAME = '�븮'
AND SALARY >ANY(
                SELECT SALARY
                FROM EMPLOYEE E
                JOIN JOB J
                ON E.JOB_CODE = J.JOB_CODE
                WHERE JOB_NAME = '����'
                )
;
/*
SELECT SALARY
FROM EMPLOYEE E
JOIN JOB J
ON E.JOB_CODE = J.JOB_CODE
WHERE JOB_NAME = '����'
;
*/

-- 4) ���� �����ӿ��� ���� ������ �ִ� �޿����� �� ���� �޴� �������� ���, �̸�, ���޸�, �޿� ��ȸ 
SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME, E.SALARY
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE J.JOB_NAME = '����'
  AND SALARY > ALL(
    SELECT E.SALARY
    FROM EMPLOYEE E
    JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
    WHERE J.JOB_NAME = '����'
  ); 
  
/*
    <���߿� ���� ����>
        ��ȸ ��� ���� �� �������� ������ Į�� ���� ���� ���� ��
*/
--1) ������ ����� ���� �μ� �ڵ�, ���� ���� �ڵ忡 �ش��ϴ� ����� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (
                                    SELECT DEPT_CODE, JOB_CODE
                                    FROM EMPLOYEE
                                    WHERE EMP_NAME ='������'
                                )
;

-- 2) �ڳ��� ����� ���� �ڵ尡 ��ġ�ϸ鼭 ���� ����� ������ �ִ� ����� ���, �̸�, ���� �ڵ�, ��� ���, ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) IN (
    SELECT JOB_CODE, MANAGER_ID
    FROM EMPLOYEE
    WHERE EMP_NAME = '�ڳ���'
);
/*
    <������ ���߿� ���� ����>
        ���� ������ ��ȸ ������� ���� ��, ���� ���� ���
*/

-- 1. �� ���޺��� �ּ� �޿��� �޴� ������� ���, �̸�, ���� �ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (
    SELECT JOB_CODE, MIN(SALARY)
    FROM EMPLOYEE
    GROUP BY JOB_CODE
);
---
 SELECT JOB_CODE, MIN(SALARY)
    FROM EMPLOYEE
    GROUP BY JOB_CODE;

/*
    <�ζ��� ��>
        FROM ���� ���� ������ �����ϰ�, ���� ������ ������ ����� ���̺� ��� ����Ѵ�.
        ==���̺��� ��ó�� FROM�� �������� �޾Ƶ� ��
*/
SELECT NICKNAME, CONTACT
FROM 
(  
        SELECT
            EMP_NAME  AS NICKNAME
            ,PHONE AS CONTACT
        FROM EMPLOYEE
)
;

--ROWNUM �����ű��  E.G.�Խñ� ���ΰ�ħ -�� �� ����10 �� ������
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;


SELECT EMP_NAME, SALARY,ROWNUM
FROM
(
        SELECT EMP_NAME, SALARY
        FROM EMPLOYEE
        ORDER BY SALARY DESC
)
WHERE ROWNUM<=5
;

SELECT EMP_NAME, SALARY, ROWNUM
FROM 
(
    SELECT EMP_NAME, SALARY
    FROM EMPLOYEE
    ORDER BY SALARY DESC
)
WHERE ROWNUM BETWEEN 1 AND 10
;
