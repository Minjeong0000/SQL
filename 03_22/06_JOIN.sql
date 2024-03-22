--JOIN �� ���̸� ����/��� ���� ����
/*
    <JOIN>
        �� ���� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ����ϴ� �����̴�.
        
**�߿�** 1. � ����(EQUAL JOIN) / ���� ����(INNER JOIN)
            �����Ű�� Į���� ���� ��ġ�ϴ� ��鸸 ���εǼ� ��ȸ�Ѵ�.(��ġ�ϴ� ���� ���� ���� ��ȸ X)
            
            1) ����Ŭ ���� ����
                [����]
                    SELECT Į��, Į��, ...
                    FROM ���̺�1, ���̺�2
                    WHERE ���̺�1.Į���� = ���̺�2.Į����;
                
                - FROM ���� ��ȸ�ϰ��� �ϴ� ���̺���� �޸�(,)�� �����Ͽ� �����Ѵ�.
                - WHERE ���� ��Ī ��ų Į���� ���� ������ �����Ѵ�.
            
            2) ANSI ǥ�� ����
                [����]
                    SELECT Į��, Į��, ...
                    FROM ���̺�1
                    [INNER] JOIN ���̺�2 ON (���̺�1.Į���� = ���̺�2.Į����);
                
                - FROM ���� ������ �Ǵ� ���̺��� ����Ѵ�.
                - JOIN ���� ���� ��ȸ�ϰ��� �ϴ� ���̺��� ��� �� ��Ī ��ų Į���� ���� ������ ����Ѵ�.
                - ���ῡ ����Ϸ��� Į������ ���� ��� ON ���� ��ſ� USING(Į����) ������ ����Ѵ�.
*/

--�����, �����ڵ�, ���޸� ��ȸ
SELECT EMP_NAME, ABC.JOB_CODE, JOB_NAME
FROM EMPLOYEE ABC JOIN JOB X ON(ABC.JOB_CODE = X.JOB_CODE) 
;

--�μ��� �޿� �հ� ��ȸ
-- �μ���, �޿��հ� ���
SELECT 
    D.DEPT_TITLE
    ,SUM(E.SALARY)
FROM EMPLOYEE E 
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE E.DEPT_CODE <> 'D5'
GROUP BY D.DEPT_TITLE
;



-- EMPLOYEE ���̺� , JOB ���̺��� �̿��Ͽ�
-- �����, �����ڵ�, ���޸� ��ȸ
SELECT EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E  
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
;

--USING ����ؼ�
SELECT EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE E  
JOIN JOB J USING( JOB_CODE)
;

-- EMPLOYEE ���̺� , DEPARTMENT ���̺��� �̿��Ͽ�
-- �����, �μ��ڵ�, �μ��� ��ȸ
SELECT EMP_NAME, E.DEPT_CODE, DEPT_TITLE 
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON (E.DEPT_CODE = D.DEPT_ID)
;

-- DEPARTMENT ���̺� , LOCATION ���̺��� �̿��Ͽ�
-- �μ��ڵ�, �μ���, �����ڵ�, ������, �����ڵ� ��ȸ
SELECT 
    DEPT_ID
    ,DEPT_TITLE
    ,LOCAL_CODE
    ,LOCAL_NAME
    ,NATIONAL_CODE
FROM DEPARTMENT D
JOIN LOCATION L
ON (D.LOCATION_ID= L.LOCAL_CODE )
;


-- LOCATION ���̺� , NATIONAL ���̺��� �̿��Ͽ�
-- �����ڵ�, ������, �����ڵ�, ������ ��ȸ
SELECT 
    LOCAL_CODE
    ,LOCAL_NAME
    ,L.NATIONAL_CODE
    ,NATIONAL_NAME
FROM LOCATION L
JOIN NATIONAL N
ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
;


-- DEPARTMENT ���̺� , LOCATION ���̺� , NATIONAL ���̺��� �̿��Ͽ�
-- �μ��ڵ�, �μ���, ������, ������ ��ȸ
SELECT
    DEPT_ID
    ,DEPT_TITLE
    ,LOCAL_NAME 
    ,NATIONAL_NAME
FROM DEPARTMENT D
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON(L.NATIONAL_CODE= N.NATIONAL_CODE)
;
--DEPARTMENT ���̺�, EMPLOYEE ���̺��� �̿��Ͽ�
--�����, �μ��� ��ȸ
SELECT 
    E.EMP_NAME
    ,D.DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(D.DEPT_ID = E.DEPT_CODE)
;--������: DEPT_CODE�� NULL�� ����� ��ȸ�� �ȵ�

/*
    3. �ܺ� ���� (OUTTER JOIN)
        ���̺� ���� JOIN �� ��ġ���� �ʴ� �൵ ���Խ��Ѽ� ��ȸ�� �����ϴ�.
        ��, �ݵ�� �����̵Ǵ� ���̺�(�÷�)�� �����ؾ� �Ѵ�. (LEFT/RIGHT/(+))
        
        --�������� (INNER)JOIN ~~~ON~~~
--LEFT/RIGHT/FULL (OUTER) JOIN~~ON~~
*/
SELECT 
    E.EMP_NAME
    ,D.DEPT_ID
    ,D.DEPT_TITLE
FROM EMPLOYEE E 
RIGHT OUTER JOIN DEPARTMENT D ON E.DEPT_CODE =D.DEPT_ID 
;--������ ��Ʈ����Ʈ�� �츲

SELECT 
    E.EMP_NAME
    ,D.DEPT_ID
    ,D.DEPT_TITLE
FROM EMPLOYEE E 
LEFT OUTER JOIN DEPARTMENT D ON E.DEPT_CODE =D.DEPT_ID
;

SELECT 
    E.EMP_NAME
    ,D.DEPT_ID
    ,D.DEPT_TITLE
FROM EMPLOYEE E 
FULL OUTER JOIN DEPARTMENT D ON E.DEPT_CODE =D.DEPT_ID 
;

/*
    4. ī�׽þȰ�(CARTESIAN PRODUCT) / ���� ����(CROSS JOIN) --�� ���� ���� ���ٰ� �Ѵ�...
        ���εǴ� ��� ���̺��� �� ����� ���μ��� ��� ���ε� �����Ͱ� �˻��ȴ�.
        ���̺��� ����� ��� ������ ����� ������ ��� -> ����ȭ�� ����
*/
SELECT 
    E.EMP_NAME
    ,D.DEPT_ID
    ,D.DEPT_TITLE
FROM EMPLOYEE E 
CROSS JOIN DEPARTMENT D
;--ON E.DEPT_CODE =D.DEPT_ID //CROSS JOIN�� ON ����(?)�� ���� �ȵ�
--�����23*(�μ��� ��)9 = 207

SELECT*
FROM LOCATION
CROSS JOIN NATIONAL
;
/*
    5. �� ����(NON EQUAL JOIN)
        ���� ���ǿ� ��ȣ(=)�� ������� �ʴ� ���ι��� �� �����̶�� �Ѵ�.
        ������ Į�� ���� ��ġ�ϴ� ��찡 �ƴ�, ���� ������ ���ԵǴ� ����� �����ϴ� ����̴�.
        ( = �̿ܿ� �� ������ >, <, >=, <=, BETWEEN AND, IN, NOT IN ���� ����Ѵ�.)
        ANSI �������δ� JOIN ON �������θ� ����� �����ϴ�. (USING ��� �Ұ�)
*/
SELECT EMP_NAME, SALARY, S.*
FROM EMPLOYEE E
JOIN SAL_GRADE S ON E.SALARY >= S.MIN_SAL AND E.SALARY < S.MAX_SAL
;
/*
    6. ��ü ����(SELF JOIN)
        ���� ���̺��� �ٽ� �ѹ� �����ϴ� ��쿡 ����Ѵ�.
*/--���1�� ��� ==���2

--������ȣ,�����̸�,�����ȣ
SELECT 
    A.EMP_ID 
    ,A.EMP_NAME
    ,A.MANAGER_ID
    ,B.EMP_NAME
FROM EMPLOYEE A JOIN EMPLOYEE B ON( A.MANAGER_ID = B.EMP_ID)
;

---------------- �ǽ� ���� ----------------

-- 1. DEPARTMENT ���̺�� LOCATION ���̺��� �����Ͽ� �μ� �ڵ�, �μ���, ���� �ڵ�, �������� ��ȸ
SELECT D.DEPT_ID,D.DEPT_TITLE, L.LOCAL_CODE,L.LOCAL_NAME
FROM DEPARTMENT D
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
;
-- 2. EMPLOYEE ���̺�� DEPARTMENT ���̺��� �����ؼ� ���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ����� ��ȸ
SELECT EMP_ID,EMP_NAME,BONUS,DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE =D.DEPT_ID)
WHERE BONUS IS NOT NULL
;
-- 3. EMPLOYEE ���̺�� DEPARTMENT ���̺��� �����ؼ� �λ�����ΰ� �ƴ� ������� �����, �μ���, �޿��� ��ȸ
SELECT EMP_NAME,DEPT_TITLE,SALARY
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
WHERE D.DEPT_TITLE != '�λ������'
;
-- 4. EMPLOYEE ���̺�, DEPARTMENT ���̺�, LOCATION ���̺��� �����ؼ� ���, �����, �μ���, ������ ��ȸ
SELECT EMP_ID,EMP_NAME,DEPT_TITLE,LOCAL_NAME
FROM EMPLOYEE E 
JOIN DEPARTMENT D ON(E.DEPT_CODE =D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID=L.LOCAL_CODE)
;
-- 5. ���, �����, �μ���, ������, ������ ��ȸ
SELECT EMP_ID, EMP_NAME,DEPT_TITLE,LOCAL_NAME,NATIONAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE =D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID=L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE =N.NATIONAL_CODE)
;
-- 6. ���, �����, �μ���, ������, ������, �޿� ��� ��ȸ 

SELECT
    EMP_ID,
    EMP_NAME,
    DEPT_TITLE,
    LOCAL_NAME,
    NATIONAL_NAME,
    S.SAL_LEVEL
FROM EMPLOYEE E
JOIN SAL_GRADE S ON (E.SALARY >= S.MIN_SAL AND E.SALARY < S.MAX_SAL)
JOIN DEPARTMENT D ON(E.DEPT_CODE =D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID=L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE =N.NATIONAL_CODE)
;
-- 1. ������ �븮�̸鼭 ASIA �������� �ٹ��ϴ� �������� ���, �����, ���޸�, �μ���, �ٹ�����, �޿��� ��ȸ�ϼ���.
SELECT EMP_ID,EMP_NAME,JOB_NAME,DEPT_TITLE,NATIONAL_NAME,SALARY
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE =D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID=L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE =N.NATIONAL_CODE)
WHERE JOB_NAME = '�븮' AND L.LOCAL_NAME LIKE 'ASIA%'
;

-- 2. 70���� �̸鼭 �����̰�, ���� �� ���� �������� �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�ϼ���.
SELECT EMP_NAME,EMP_NO,DEPT_TITLE,JOB_NAME 
FROM EMPLOYEE E 
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE =D.DEPT_ID)
WHERE SUBSTR(EMP_NO,1,2) > '70' AND SUBSTR(EMP_NO,8,1) = 2 AND EMP_NAME LIKE '��%'
;

-- 3. ���ʽ��� �޴� �������� �����, ���ʽ�, ����, �μ���, �ٹ������� ��ȸ�ϼ���.
SELECT EMP_NAME,BONUS,(SALARY+SALARY*BONUS)*12 AS "����",DEPT_TITLE,L.LOCAL_NAME
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE =D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID=L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE =N.NATIONAL_CODE)
WHERE BONUS IS NOT NULL;


-- 4. �ѱ��� �Ϻ����� �ٹ��ϴ� �������� �����, �μ���, �ٹ�����, �ٹ� ������ ��ȸ�ϼ���.
SELECT EMP_NAME,DEPT_TITLE, L.LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE =D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID=L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE =N.NATIONAL_CODE)
WHERE NATIONAL_NAME ='�ѱ�' OR NATIONAL_NAME = '�Ϻ�'
;

-- 5. �� �μ��� ��� �޿��� ��ȸ�Ͽ� �μ���, ��� �޿�(���� ó��)�� ��ȸ�ϼ���.
SELECT
    DEPT_TITLE
    ,FLOOR(AVG(SALARY))
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE=D.DEPT_ID)
GROUP BY DEPT_TITLE
;

-- 6. �� �μ��� �� �޿��� ���� 1000���� �̻��� �μ���, �޿��� ���� ��ȸ�Ͻÿ�.
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE E 
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY)>10000000
ORDER BY D.DEPT_TITLE;


-- 7. ���, �����, ���޸�, �޿� ���, ������ ��ȸ
--    �̶� ���п� �ش��ϴ� ���� �Ʒ��� ���� ��ȸ �ǵ��� �Ͻÿ�.
--    �޿� ����� S1, S2�� ��� '���'
--    �޿� ����� S3, S4�� ��� '�߱�'
--    �޿� ����� S5, S6�� ��� '�ʱ�'

SELECT 
    EMP_ID,
    JOB_NAME,
    SAL_LEVEL,
    CASE
        WHEN SAL_LEVEL ='S1' OR SAL_LEVEL = 'S2' THEN '���'
        WHEN SAL_LEVEL ='S3' OR SAL_LEVEL = 'S4' THEN '�߱�'
        WHEN SAL_LEVEL ='S5' OR SAL_LEVEL = 'S6' THEN '�ʱ�'
        ELSE '�ش���׾���'
    END AS ����
FROM EMPLOYEE E 
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
JOIN SAL_GRADE S ON E.SALARY >= S.MIN_SAL AND E.SALARY < S.MAX_SAL
;

-- 8. ���ʽ��� ���� �ʴ� ������ �� ���� �ڵ尡 J4 �Ǵ� J7�� �������� �����, ���޸�, �޿��� ��ȸ�Ͻÿ�.

SELECT EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE= J.JOB_CODE)
WHERE BONUS IS NULL AND (J.JOB_CODE ='J4' OR J.JOB_CODE = 'J7')
;



-- 9. �μ��� �ִ� �������� �����, ���޸�, �μ���, �ٹ� ������ ��ȸ�Ͻÿ�.
SELECT EMP_NAME,JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE =D.DEPT_ID)--DEPT��Ī�Ҷ� NULL�� ���� �����.WHERE �� �ʿ� X
JOIN LOCATION L ON (D.LOCATION_ID=L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE =N.NATIONAL_CODE)
WHERE DEPT_CODE IS NOT NULL
;

-- 10. �ؿܿ������� �ٹ��ϴ� �������� �����, ���޸�, �μ� �ڵ�, �μ����� ��ȸ�Ͻÿ�
SELECT EMP_NAME, JOB_NAME, DEPT_CODE,DEPT_TITLE
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE =D.DEPT_ID)
WHERE DEPT_TITLE LIKE '�ؿܿ���%'
;
-- 11. �̸��� '��'�ڰ� ����ִ� �������� ���, �����, ���޸��� ��ȸ�Ͻÿ�.

SELECT EMP_ID,EMP_NAME,J.JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE EMP_NAME LIKE '%��%'
;
/*
SELECT EMP_NAME
FROM EMPLOYEE
;*/
