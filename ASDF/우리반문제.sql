-- 보너스를 받지 않는 사원들을 대상으로
-- 부서별 평균 급여를 조회
-- (평귭급여가 300만원 이상인 부서는 제외)
-- (평균급여가 높은 순서대로 정렬)
SELECT DEPT_CODE , FLOOR(AVG(SALARY))평균급여
FROM EMPLOYEE
WHERE BONUS IS NULL
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) < 3000000
ORDER BY 평균급여 DESC
;

-- 연봉이 3000만원 이하인 직원의 사번,이름,연봉 조회
SELECT EMP_ID, EMP_NAME, SALARY*12 연봉
FROM EMPLOYEE
WHERE SALARY*12 < 30000000
;

--D5부서의 사원 이름, 직급, 월급 출력
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
;
--사원들중 월급이 가장 많은 사람과 가장 적은 사람의 연봉 차이
SELECT MAX(SALARY*12)-MIN(SALARY*12) AS 연봉차이
FROM EMPLOYEE
;

-- EMPLOYEE 테이블에서 
-- 가장 나이가 많은 직원의 
-- 이름, 현재나이, 주민번호, 입사날짜('년도-월-일 요일'로 출력)를 구하시오
-- 이 때 사원들은 모두 1900년대 생 입니다.
-- 나이는 소숫점을 잘라내고 출력합니다.
-- 나이가 제일 많은 직원이 여러 명이라면
-- 이름 내림차순 정렬

-- 보너스를 받는 사원을 대상으로 
-- 직급별 평균 급여 조회 
-- 평균급여가 높은 순서대로 정렬
-- (단, 퇴직하지 않은 사원들 대상 조회)
SELECT JOB_CODE,FLOOR(AVG(SALARY))평균급여
FROM EMPLOYEE
WHERE BONUS IS NOT NULL AND ENT_YN = 'N'
GROUP BY JOB_CODE
ORDER BY 평균급여 DESC;

-- 남자 직원들의 이름과 나이를 나이가 많은 순으로 조회
-- 이름은 성을 제외, 나이는 만으로 계산
-- EX 이름 나이
--    동운 61세
--    길동 54세 


-- 부서중에 급여 합계가 제일 적은 부서는?
-- (단, EMPLOYEE 계정에서 풀어야한다.)
SELECT DEPT_CODE, SUM(SALARY) AS 급여합계
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 급여합계
;

--보너스를 받는 사원들의 모든 코드를 조회
--대신 급여가 3000000원 이상인 사람들만
SELECT *
FROM EMPLOYEE
WHERE SALARY>3000000 AND BONUS IS NOT NULL
;

--부서별 직급이 높고 연봉이 많은순으로 이름, 사번, 연봉, 조회 

SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
;
-- 각 부서별로 직급이 가장 높은 사람의 전화번호
SELECT DEPT_CODE ,PHONE
FROM EMPLOYEE

GROUP BY DEPT_CODE
;

--부서 평균 급여가 400만원 이상인 부서만 조회(소수점 나올시 소수점 이하는 버리기)

SELECT DEPT_CODE , FLOOR(AVG(SALARY)) 평균급여
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY))>4000000
;

-- 보너스를 받는 사원들을 대상으로
-- 부서별 평균 보너스 조회
SELECT DEPT_CODE , AVG(BONUS)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY DEPT_CODE
;



--여자 사원을 대상으로
--직급별 전체 급여를 조회 (별칭 : 급여총액)
--직급코드 J4 제외
--급여합이 낮은 순서대로 정렬

SELECT JOB_CODE, SUM(SALARY) 급여총액
FROM EMPLOYEE
WHERE JOB_CODE != 'J4' AND SUBSTR(EMP_NO,8,1) = 2
GROUP BY JOB_CODE
ORDER BY 2;

SELECT 
    JOB_CODE
    ,SUM(SALARY) 급여총액
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2
GROUP BY JOB_CODE
HAVING JOB_CODE != 'J4'
ORDER BY "급여총액" ASC;

-- 부서코드별 사원아이디 번호가 가장 빠른사람의 부서코드와 사원아이디 조회
--(보너스가 있는 사람은 제외)


SELECT DEPT_CODE, MIN(EMP_ID)
FROM EMPLOYEE
WHERE BONUS IS NULL 
GROUP BY DEPT_CODE;

-- 관리자 사번이 있는 사원들 대상으로
-- 부서별 총 급여를 조회
-- (급여 높은 순서대로 정렬)
SELECT DEPT_CODE, SUM(SALARY)총급여
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY 2 DESC
;


--1. 사원번호 200번인 직원의 이름과, 직급코드 출력
SELECT 
    EMP_NAME
    ,JOB_CODE
FROM EMPLOYEE
WHERE EMP_ID = 200
;
--2. 회사의 사장인 선동일은 성이 '이'씨인 사원의 모든 성을 자신과 동일한 '선'씨로 개명시키려고 한다. 선동일에게 잘 보이기 위해 개명을 시켜보자
SELECT REPLACE(EMP_NAME, '이' ,'선')
FROM EMPLOYEE
WHERE EMP_NAME LIKE '이%'
;
--3. 기뻐한 선동일은 이름을 개명한 직원들의 직급을 하나씩 높이려고 한다.
SELECT REPLACE(EMP_NAME, '이', '선') , 'J' || (SUBSTR(JOB_CODE,2 ,1)-1), JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '이%'
;

 --입사년도가 같은 사람들의 평균급여를 보고 250만원보다 적은 사람들에게 교육을 시키려 한다
 --이사람들의 입사년도와 급여를 조회하라
SELECT EXTRACT(YEAR FROM HIRE_DATE),AVG(SALARY)
FROM EMPLOYEE
GROUP BY EXTRACT(YEAR FROM HIRE_DATE)
HAVING AVG(SALARY)<2500000
ORDER BY 1
;


--사원이름과 현재 나이 출력
SELECT EMP_NAME,(100-SUBSTR(EMP_NO,0,2))+TO_CHAR(SYSDATE,'YY') || '세' AS 나이
FROM EMPLOYEE
ORDER BY 나이;

--부서별 최고급여 조회
SELECT DEPT_CODE,MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1
;

--1.  기준년도는 2017년도이다 연차가 5년 미만이고 직급이 대리인 직원의 사번, 이름, 연차, 직급 조회
SELECT
    EMP_NAME
    ,EMP_ID
    ,JOB_CODE
    ,FLOOR(MONTHS_BETWEEN(
    TO_DATE('2017-01-01'
    ,'YYYY-MM-DD')
    ,HIRE_DATE)/12) 연차
FROM EMPLOYEE
WHERE JOB_CODE = 'J6' 
    AND MONTHS_BETWEEN
    (TO_DATE('2017-01-01'
    , 'YYYY-MM-DD')
    ,HIRE_DATE) <60
;

SELECT EMP_ID, EMP_NAME,  2017 -TO_CHAR(HIRE_DATE, 'RRRR') 연차, JOB_CODE
FROM EMPLOYEE
WHERE TO_CHAR(HIRE_DATE, 'RRRR') > 2012 AND JOB_CODE ='J6';




-- 직급별 평균 급여가 200만원 이상인 부서에서 전화번호 4번째 자리가 3인 사람만 조회
-- 추가설명 : (010-X123-4567) 여기서 X가 3인 사람

SELECT JOB_CODE
FROM EMPLOYEE
WHERE SUBSTR(PHONE, 5, 1) = '3'
GROUP BY JOB_CODE
HAVING AVG(SALARY) >= 2000000
;


-- 남성사원, 여성사원 사원 수 구하기
SELECT SUBSTR(EMP_NO,8,1),COUNT(*)  
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1);

-- 회사 채용 관련한 시스템을 개편하려고 한다.
-- 그렇기 위해서는 우선, 입사나이댓를 내부적으로 파악해야한다.
-- 직원들 각각의 입사나이를 적은 순서대로 보여라. (2023년도까지의 한국나이로 계산)
SELECT
    EMP_NAME 사원명
    , TO_NUMBER(TO_CHAR(HIRE_DATE, 'RRRR')) - TO_NUMBER('19' || SUBSTR(EMP_NO, 1, 2)) 입사나이
    , TO_NUMBER(TO_CHAR(SYSDATE, 'RRRR')) - TO_NUMBER('19' || SUBSTR(EMP_NO, 1, 2)) 현재나이
    , '19' || SUBSTR(EMP_NO, 1, 2) 생년
    , TO_CHAR(HIRE_DATE, 'RRRR') 입사년도
FROM EMPLOYEE
ORDER BY 입사나이 ASC
;

--퇴직자가 있는 부서코드 , 그 사람 이름 과 연봉을 구하시오
--보너스를 받는 부서코드, 평균 급여를  조회하시오(평균급여가 높은 순서대로)


SELECT DEPT_CODE, EMP_NAME , SALARY * 12 연봉
FROM EMPLOYEE
WHERE ENT_YN  = 'Y';

SELECT EMP_ID ,AVG(SALARY)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY EMP_ID
ORDER BY AVG(SALARY) DESC;

--각 직급별로 평균 연봉(소수점없이 반올림)과 보너스를 받는 인원수 조회

SELECT 
    JOB_CODE
    , ROUND(AVG(SALARY))
    , COUNT(BONUS)
FROM EMPLOYEE
GROUP BY JOB_CODE
;
