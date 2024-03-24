--�� ���б� ��ũ�� ����
--SQL03_SELECT(Option)

-- 1��
-- �л��̸��� �ּ����� ǥ���Ͻÿ�. ��, ��� ����� "�л� �̸�", "�ּ���"�� �ϰ�, ������ �̸����� �������� ǥ���ϵ��� �Ѵ�.
SELECT STUDENT_NAME "�л��̸�", STUDENT_ADDRESS �ּ���
FROM TB_STUDENT
ORDER BY 1 ASC
;

-- 2��
-- �������� �л����� �̸��� �ֹι�ȣ�� ���̰� ���� ������ ȭ�鿡 ����Ͻÿ�
SELECT STUDENT_NAME �̸� , STUDENT_SSN �ֹι�ȣ
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY 2 DESC
;

-- 3��
-- �ּ����� �������� ��⵵�� �л��� �� 1900��� �й��� ���� �л����� �̸��� �й�, �ּҸ� �̸��� ������������ ȭ�鿡 ����Ͻÿ�.
-- ��, ���������� "�л��̸�", "�й�", "������ �ּ�"�� ��µǵ��� �Ѵ�.
SELECT STUDENT_NAME AS "�л��̸�", STUDENT_NO AS "�й�", STUDENT_ADDRESS AS "������ �ּ�"
FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '%��⵵%' OR STUDENT_ADDRESS LIKE '����%')
    AND STUDENT_NO LIKE '9%'
ORDER BY STUDENT_NAME ASC;


-- 4��
-- ���� ���а� ���� �� ���� ���̰� ���� ������� �̸��� Ȯ���� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
-- (���а��� '�а� �ڵ�'�� �а� ���̺��� ��ȸ�ؼ� ã�� ������ ����)
SELECT PROFESSOR_NAME 
FROM TB_PROFESSOR P
JOIN TB_DEPARTMENT D ON (P.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '���а�'
ORDER BY PROFESSOR_SSN
;



-- 5��
-- 2004�� 2�б⿡ 'C3118100' ������ ������ �л����� ������ ��ȸ�Ϸ��� �Ѵ�. 
-- ������ ���� �л����� ǥ���ϰ�,
-- ������ ������ �й��� ���� �л����� ǥ���ϴ� ������ �ۼ��� ���ÿ�.
-- ��ũ�� ����� �����ϰ� �Ҽ��� �Ʒ� 2�ڸ����� 0���� ǥ���ϱ� ���ؼ� TO_CHAR(NUMBER, 'FM9.00') ���� ���
SELECT S.STUDENT_NO , TO_CHAR(POINT,'9.00')
FROM TB_STUDENT S
JOIN TB_GRADE G ON S.STUDENT_NO = G.STUDENT_NO
WHERE TERM_NO = '200402' AND CLASS_NO = 'C3118100'
ORDER BY POINT DESC, STUDENT_NO
;

-- 6��
-- �л� ��ȣ, �л� �̸�, �а� �̸��� �л� �̸����� �������� �����Ͽ� ����ϴ� SQL���� �ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME ,DEPARTMENT_NAME
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D ON S.DEPARTMENT_NO = D.DEPARTMENT_NO
ORDER BY 2 ASC
;


-- 7��
-- �� ������б��� ���� �̸��� ������ �а� �̸��� ����ϴ� SQL������ �ۼ��Ͻÿ�.
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C
JOIN TB_DEPARTMENT D ON C.DEPARTMENT_NO = D.DEPARTMENT_NO
;


-- 8��
-- ���� ���� �̸��� ã������ �Ѵ�. ���� �̸��� ���� �̸��� ����ϴ� SQL���� �ۼ��Ͻÿ�.
SELECT CLASS_NAME ,PROFESSOR_NAME
FROM TB_CLASS C
JOIN TB_CLASS_PROFESSOR CP ON C.CLASS_NO = CP.CLASS_NO
JOIN TB_PROFESSOR P ON CP.PROFESSOR_NO = P.PROFESSOR_NO

;

-- 9��
-- 8���� ��� �� '�ι� ��ȸ' �迭�� ���� ������ ���� �̸��� ã������ �Ѵ�.
-- �̿� �ش��ϴ� ���� �̸��� ���� �̸��� ����ϴ� SQL���� �ۼ��Ͻÿ�.
SELECT CLASS_NAME ,PROFESSOR_NAME
FROM TB_CLASS C
JOIN TB_CLASS_PROFESSOR CP ON C.CLASS_NO = CP.CLASS_NO
JOIN TB_PROFESSOR P ON CP.PROFESSOR_NO = P.PROFESSOR_NO
JOIN TB_DEPARTMENT D ON C.DEPARTMENT_NO = D.DEPARTMENT_NO
WHERE CATEGORY = '�ι���ȸ'
;

                        
-- 10��
-- '�����а�' �л����� ������ ���Ϸ��� �Ѵ�. 
-- �����а� �л����� "�й�", "�л� �̸�", "��ü ����"�� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
-- (��, ������ �Ҽ��� 1�ڸ������� �ݿø��Ͽ� ǥ���Ѵ�.)
SELECT S.STUDENT_NO �й�, STUDENT_NAME �л��̸�,  ROUND(AVG(POINT),1) ��ü����
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D ON S.DEPARTMENT_NO = D.DEPARTMENT_NO
JOIN TB_GRADE G ON S.STUDENT_NO = G.STUDENT_NO
WHERE DEPARTMENT_NAME = '�����а�'
GROUP BY S.STUDENT_NO, STUDENT_NAME
;

-- 11��
-- �й��� A313047�� �л��� �б��� ������ ���� �ʴ�. ���� �������� ������ �����ϱ� ���� 
-- �а� �̸�, �л� �̸��� ���� ���� �̸��� �ʿ��ϴ�.
-- �̶� ����� SQL���� �ۼ��Ͻÿ�.
SELECT DEPARTMENT_NAME, STUDENT_NAME, PROFESSOR_NAME
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D ON S.DEPARTMENT_NO = D.DEPARTMENT_NO
JOIN TB_PROFESSOR P ON S.COACH_PROFESSOR_NO = P.PROFESSOR_NO
WHERE STUDENT_NO = 'A313047'
;


-- 12��
-- 2007�⵵�� '�ΰ������' ������ ������ �л��� ã�� 
-- �л��̸��� �����б⸦ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NAME "�л� �̸�", TERM_NO "���� �б�"
FROM TB_STUDENT S
JOIN TB_GRADE G ON S.STUDENT_NO = G.STUDENT_NO
JOIN TB_CLASS C ON G.CLASS_NO = C.CLASS_NO
WHERE SUBSTR(TERM_NO,1,4) = '2007' AND CLASS_NAME ='�ΰ������'
;



-- 13��
-- ��ü�� �迭 ���� �� ���� ��米���� �� �� �������� ���� ������ ã�� 
-- �� ���� �̸��� �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
-- ��� ���� ���� �����ϳ� ���� ������ ���� �ٸ� ������ ����
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C
JOIN TB_DEPARTMENT D ON C.DEPARTMENT_NO = D.DEPARTMENT_NO
LEFT JOIN TB_CLASS_PROFESSOR CP ON C.CLASS_NO = CP.CLASS_NO
WHERE CATEGORY = '��ü��' AND PROFESSOR_NO IS NULL
;


-- 14��
-- �� ������б� ���ݾƾ��а� �л����� ���������� �Խ��ϰ��� �Ѵ�. 
-- �л��̸��� �������� �̸��� ã�� ���� ���� ������ ���� �л��� ���
-- "�������� ������"���� ǥ���ϵ��� �ϴ� SQL ���� �ۼ��Ͻÿ�. 
-- �� �������� "�л��̸�", "��������"�� ǥ���ϸ� ���й� �л��� ���� ǥ�õǵ��� �Ѵ�.
SELECT STUDENT_NAME �л��̸� , NVL(COACH_PROFESSOR_NO,'�������� ������') ��������
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D ON S.DEPARTMENT_NO = D.DEPARTMENT_NO
LEFT JOIN TB_PROFESSOR P ON S.COACH_PROFESSOR_NO = P.PROFESSOR_NO
WHERE DEPARTMENT_NAME = '���ݾƾ��а�'
;


-- 15��
-- ���л��� �ƴ� �л� �� ������ 4.0 �̻��� �л��� ã�� 
-- �� �л��� �й�, �̸�, �а�, �̸�, ������ ����ϴ� SQL���� �ۼ��Ͻÿ�.
SELECT S.STUDENT_NO �й� ,DEPARTMENT_NAME �а�, STUDENT_NAME �̸�, ROUND(AVG(POINT),1) ����
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D ON S.DEPARTMENT_NO = D.DEPARTMENT_NO
JOIN TB_GRADE G ON S.STUDENT_NO = G.STUDENT_NO
WHERE ABSENCE_YN = 'N'
GROUP BY S.STUDENT_NO, DEPARTMENT_NAME, STUDENT_NAME
HAVING ROUND(AVG(POINT),1) >= 4.0
ORDER BY STUDENT_NAME
;
-- 16��
-- ȯ�������а� ����������� ���� �� ������ �ľ��� �� �ִ� SQL ���� �ۼ��Ͻÿ�.
SELECT C.CLASS_NO, CLASS_NAME , ROUND(AVG(POINT),1) ����
FROM TB_CLASS C
JOIN TB_DEPARTMENT D ON C.DEPARTMENT_NO =D.DEPARTMENT_NO
JOIN TB_GRADE G ON C.CLASS_NO = G.CLASS_NO
WHERE DEPARTMENT_NAME = 'ȯ�������а�' AND CLASS_TYPE LIKE '����%' 
GROUP BY C.CLASS_NO ,CLASS_NAME 
;


-- 17��
-- �� ������б��� �ٴϰ� �ִ� �ְ��� �л��� ���� �� �л����� �̸��� �ּҸ� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
--��������?

/*SELECT DEPARTMENT_NO
FROM TB_STUDENT
WHERE STUDENT_NAME ='�ְ���'
;
*/
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
FROM TB_STUDENT
WHERE STUDENT_NAME ='�ְ���')
;

                       
-- 18��
-- ������а����� �������� ���� ���� �л��� �̸��� �й��� ǥ���ϴ� SQL���� �ۼ��Ͻÿ�


 SELECT STUDENT_NO, STUDENT_NAME 
 FROM(
 SELECT S.STUDENT_NO, S.STUDENT_NAME 
 FROM TB_STUDENT S
    JOIN TB_DEPARTMENT D ON S.DEPARTMENT_NO = D.DEPARTMENT_NO
    JOIN TB_GRADE G ON S.STUDENT_NO = G.STUDENT_NO
    WHERE D.DEPARTMENT_NAME = '������а�' 
    GROUP BY S.STUDENT_NO, S.STUDENT_NAME 
    ORDER BY AVG(G.POINT)DESC)
 WHERE ROWNUM = 1
 ;



-- 19��
-- �� ������б��� "ȯ�������а�"�� ���� ���� �迭 �а����� 
-- �а� �� �������� ������ �ľ��ϱ� ���� ������ SQL���� ã�Ƴ��ÿ�.
-- ��, �������� "�迭 �а���", "��������"���� ǥ�õǵ��� �ϰ�, 
-- ������ �Ҽ��� ���ڸ������� �ݿø��Ͽ� ǥ�õǵ��� �Ѵ�.
/*
SELECT CATEGORY
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME = 'ȯ�������а�'
;
*/
SELECT DEPARTMENT_NAME "�迭�а���" , ROUND(AVG(POINT),1) "��������"
FROM TB_DEPARTMENT D
JOIN TB_CLASS C ON D.DEPARTMENT_NO = C.DEPARTMENT_NO
JOIN TB_GRADE G ON C.CLASS_NO = G.CLASS_NO
WHERE CATEGORY =(
SELECT CATEGORY
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME = 'ȯ�������а�'
) AND CLASS_TYPE LIKE '����%'
GROUP BY DEPARTMENT_NAME
;

