--JOIN �� ���̸� ����/��� ���� ����
/*
    <JOIN>
        �� ���� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ����ϴ� �����̴�.
        
        1. � ����(EQUAL JOIN) / ���� ����(INNER JOIN)
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
JOIN LOCATION L 
ON(D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N
ON(L.NATIONAL_CODE= N.NATIONAL_CODE)
;



