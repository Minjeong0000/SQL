/*
    <SUBQUERY>
        하나의 SQL 문 안에 포함된 또 다른 SQL 문을 뜻한다. 
        메인 쿼리(기존 쿼리)를 보조하는 역할을 하는 쿼리문이다.
        괄호 안의 서브쿼리가 메인 쿼리보다 먼저 실행. 들여쓰는것이 관례
*/
--노옹철 사원과 같은 부서원 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철'
;

SELECT*
FROM EMPLOYEE
WHERE DEPT_CODE =
(
    SELECT DEPT_CODE
    FROM EMPLOYEE
    WHERE EMP_NAME = '노옹철'
)
;

/*
    <서브 쿼리 구분>
        서브 쿼리는 서브 쿼리를 수행한 결과값의 행과 열의 개수에 따라서 분류할 수 있다.
        
        1) 단일행 단일열 서브 쿼리  : 서브 쿼리의 조회 결과 값의 행과 열의 개수가 1개 일 때
        2) 다중행 서브 쿼리        : 서브 쿼리의 조회 결과 값의 행의 개수가 여러 행 일 때
        3) 다중열 서브 쿼리        : 서브 쿼리의 조회 결과 값이 한 행이지만 칼럼이 여러개 일때
        4) 다중행, 다중열 서브 쿼리 : 서브 쿼리의 조회 결과 값이 여러행, 여러열 일 때
        
        * 서브 쿼리의 유형에 따라서 서브 쿼리 앞에 붙는 연산자가 달라진다.
        
    <단일행 서브 쿼리>
        서브 쿼리의 조회 결과 값의 행과 열의 개수가 1개 일 때 (단일행, 단일열)
        비교 연산자(단일행 연산자) 사용 가능 (=, !=, <>, ^=, >, <, >=, <=, ...)
*/
-- 1) 전 직원의 평균 급여보다 급여를 적게 받는 직원들의 이름, 직급 코드, 급여 조회
SELECT AVG(SALARY)
FROM EMPLOYEE
;


SELECT 
    EMP_NAME    AS 이름
    ,JOB_CODE   AS "직급 코드"
    ,SALARY     AS 급여
FROM EMPLOYEE
WHERE SALARY<
            (   SELECT AVG(SALARY)
                FROM EMPLOYEE
            )
;
-- 2) 최저 급여를 받는 직원의 사번, 이름, 직급 코드, 급여, 입사일 조회
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

-- 3) 노옹철 사원의 급여보다 더 많은 급여받는 사원들의 사번, 사원명, 부서명, 직급 코드, 급여 조회
SELECT SALARY
FROM EMPLOYEE
WHERE EMP_NAME ='노옹철'
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
                WHERE EMP_NAME ='노옹철'
                )
;
-- 4) 부서별 급여의 합이 가장 큰 부서의 부서 코드, 급여의 합 조회
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

-- 5) 전지연 사원이 속해있는 부서원들 조회 (단, 전지연 사원은 제외)
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '전지연'
;

SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE =( 
    SELECT DEPT_CODE
    FROM EMPLOYEE
    WHERE EMP_NAME = '전지연'
    ) AND EMP_NAME != '전지연'
;


/*
    <다중행 서브 쿼리>
        서브 쿼리의 조회 결과 값의 행의 개수가 여러 행 일 때
        
        IN / NOT IN (서브 쿼리) : 여러 개의 결과값 중에서 한 개라도 일치하는 값이 있다면 혹은 없다면 TRUE를 리턴한다.
        ANY : 여러 개의 값들 중에서 한 개라도 만족하면 TRUE, IN과 다른 점은 비교 연산자를 함께 사용한다는 점이다. 
            ANY(100, 200, 300)
            SALARY = ANY(...)  : IN과 같은 결과
            SALARY != ANY(...) : NOT IN과 같은 결과
            SALARY > ANY(...)  : 최소값 보다 크면 TRUE
            SALARY < ANY(...)  : 최대값 보다 작으면 TRUE
        ALL : 여러 개의 값들 모두와 비교하여 만족해야 TRUE, IN과 다른 점은 비교 연산자를 함께 사용한다는 점이다.
            ALL(100, 200, 300)
            SALARY > ALL(...)  : 최대값 보다 크면 TRUE
            SALARY < ALL(...)  : 최소값 보다 작으면 TRUE
*/

-- 1) 각 부서별 최고 급여를 받는 직원의 이름, 직급 코드, 부서 코드, 급여 조회
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

-- 2) 전 직원들에 대해 사번, 이름, 부서 코드, 구분(사수/사원) --SELECT문 안에 서브쿼리
SELECT 
    EMP_ID AS 사번
    ,EMP_NAME AS 이름
    ,DEPT_CODE AS 부서코드
    ,CASE 
        WHEN EMP_ID IN (
                        SELECT DISTINCT(MANAGER_ID)
                        FROM EMPLOYEE
                        WHERE MANAGER_ID IS NOT NULL
                        )THEN '사수'  
        ELSE '사원'
        END
    AS 구분
FROM EMPLOYEE
;
----------
SELECT DISTINCT(MANAGER_ID)
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL
;
-----------
-- 3) 대리 직급임에도 과장 직급들의 최소 급여보다 많이 받는 직원의 사번, 이름, 직급명, 급여 조회
SELECT
    EMP_ID
    ,EMP_NAME
    ,JOB_NAME
    ,SALARY
FROM EMPLOYEE E
JOIN JOB J
ON E.JOB_CODE = J.JOB_CODE
WHERE JOB_NAME = '대리'
AND SALARY >ANY(
                SELECT SALARY
                FROM EMPLOYEE E
                JOIN JOB J
                ON E.JOB_CODE = J.JOB_CODE
                WHERE JOB_NAME = '과장'
                )
;
/*
SELECT SALARY
FROM EMPLOYEE E
JOIN JOB J
ON E.JOB_CODE = J.JOB_CODE
WHERE JOB_NAME = '과장'
;
*/

-- 4) 과장 직급임에도 차장 직급의 최대 급여보다 더 많이 받는 직원들의 사번, 이름, 직급명, 급여 조회 
SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME, E.SALARY
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE J.JOB_NAME = '과장'
  AND SALARY > ALL(
    SELECT E.SALARY
    FROM EMPLOYEE E
    JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
    WHERE J.JOB_NAME = '차장'
  ); 
  
/*
    <다중열 서브 쿼리>
        조회 결과 값은 한 행이지만 나열된 칼럼 수가 여러 개일 때
*/
--1) 하이유 사원과 같은 부서 코드, 같은 직급 코드에 해당하는 사원들 조회
SELECT *
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (
                                    SELECT DEPT_CODE, JOB_CODE
                                    FROM EMPLOYEE
                                    WHERE EMP_NAME ='하이유'
                                )
;

-- 2) 박나라 사원과 직급 코드가 일치하면서 같은 사수를 가지고 있는 사원의 사번, 이름, 직급 코드, 사수 사번, 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) IN (
    SELECT JOB_CODE, MANAGER_ID
    FROM EMPLOYEE
    WHERE EMP_NAME = '박나라'
);
/*
    <다중행 다중열 서브 쿼리>
        서브 쿼리의 조회 결과값이 여러 행, 여러 열일 경우
*/

-- 1. 각 직급별로 최소 급여를 받는 사원들의 사번, 이름, 직급 코드, 급여 조회
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
    <인라인 뷰>
        FROM 절에 서브 쿼리를 제시하고, 서브 쿼리를 수행한 결과를 테이블 대신 사용한다.
        ==테이블인 것처럼 FROM에 서브쿼리 달아도 됨
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

--ROWNUM 순위매기기  E.G.게시글 새로고침 -새 글 상위10 개 보여줌
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
