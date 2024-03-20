/*
    <GROUP BY>
        �׷� ������ ������ �� �ִ� ����
        ���� ���� ������ �ϳ��� �׷����� ��� ó���� �������� ����Ѵ�.
*/

--��ü �޿� ���� ��ȸ
SELECT SUM(SALARY)
FROM EMPLOYEE;
--�� �μ��� �޿� ���� ��ȸ
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
;
--��ü ��� �� ��ȸ
SELECT COUNT(*)"��ü ��� �� "
FROM EMPLOYEE
;
--�μ��� ��� �� 
SELECT COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
;

--�� �μ��� ���ʽ��� �޴� �����
SELECT  DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
;
--�� ���޺� �޿� ��� ��ȸ
SELECT JOB_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY JOB_CODE
;
--�μ��� ��� ��, ���ʽ��� �޴� ��� ��, �޿��� ��, ��� �޿�, �ְ� �޿�, ���� �޿� ��ȸ
/*SELECT  DEPT_CODE
        ,COUNT(SALARY)"�μ��� ��� �� "
        , COUNT(BONUS)"���ʽ��� �޴� ��� ��"
        ,SUM(SALARY)"�޿��� ��"
        ,FLOOR(AVG(SALARY))"��� �޿�"
        ,MAX(SALARY)"�ְ� �޿�"
        ,MIN(SALARY)"���� �޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE
;*/
SELECT DEPT_CODE AS "�μ� �ڵ�",
       COUNT(*) AS "�����",
       COUNT(BONUS) AS "���ʽ��� �޴� �����",
       TO_CHAR(SUM(SALARY), '99,999,999') AS "�޿��� ��",
       TO_CHAR(FLOOR(AVG(NVL(SALARY, 0))), '99,999,999') AS "��� �޿�",
       TO_CHAR(MAX(SALARY), '99,999,999') AS "�ְ� �޿�",
       TO_CHAR(MIN(SALARY), '99,999,999') AS "���� �޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE DESC NULLS LAST
;

--���� �� ��� �� ��ȸ 
SELECT SUBSTR(EMP_NO,8,1) AS "���� �ڵ�"
    ,COUNT (*) AS "��� ��"
    FROM EMPLOYEE
    GROUP BY SUBSTR(EMP_NO,8,1)
    ORDER BY "���� �ڵ�"
    ;

/*
    <HAVING>
        �׷쿡 ���� ������ ������ �� ����ϴ� ����(�ַ� �׷� �Լ��� ����� ������ �� ����)
    
    * ���� ����
        5: SELECT      ��ȸ�ϰ��� �ϴ� Į���� AS "��Ī" | ���� | �Լ���
        1: FROM        ��ȸ�ϰ��� �ϴ� ���̺��
        2: WHERE       ���ǽ�
        3: GROUP BY    �׷� ���ؿ� �ش��ϴ� Į���� | ���� | �Լ���
        4: HAVING      �׷쿡 ���� ���ǽ�
        6: ORDER BY    ���� ���ؿ� �ش��ϴ� Į���� | ��Ī | Į�� ����
*/
-- �� �μ��� ��� �޿� ��ȸ
SELECT DEPT_CODE �μ�
,FLOOR(AVG(SALARY))||'��' "��� �޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE
;


--�μ��� ��� �޿��� 300���� �̻��� ��츸 ��ȸ
SELECT DEPT_CODE �μ�
,TO_CHAR(FLOOR(AVG(SALARY)),'99,999,999')||'��' "��� �޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) >= 3000000
;
-- ���޺� �� �޿��� ���� 10000000 �̻��� ���޵鸸 ��ȸ
SELECT JOB_CODE
    FROM EMPLOYEE
    GROUP BY JOB_CODE
    HAVING SUM(SALARY)>10000000
    ;
-- �μ��� ���ʽ��� �޴� ����� ���� �μ��鸸 ��ȸ

SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) != COUNT(*) 
;