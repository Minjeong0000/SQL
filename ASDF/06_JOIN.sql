--JOIN 행 사이를 연결/행과 행을 연결
/*
    <JOIN>
        두 개의 이상의 테이블에서 데이터를 조회하고자 할 때 사용하는 구문이다.
        
        1. 등가 조인(EQUAL JOIN) / 내부 조인(INNER JOIN)
            연결시키는 칼럼의 값이 일치하는 행들만 조인되서 조회한다.(일치하는 값이 없는 행은 조회 X)
            
            1) 오라클 전용 구문
                [문법]
                    SELECT 칼럼, 칼럼, ...
                    FROM 테이블1, 테이블2
                    WHERE 테이블1.칼럼명 = 테이블2.칼럼명;
                
                - FROM 절에 조회하고자 하는 테이블들을 콤마(,)로 구분하여 나열한다.
                - WHERE 절에 매칭 시킬 칼럼명에 대한 조건을 제시한다.
            
            2) ANSI 표준 구문
                [문법]
                    SELECT 칼럼, 칼럼, ...
                    FROM 테이블1
                    [INNER] JOIN 테이블2 ON (테이블1.칼럼명 = 테이블2.칼럼명);
                
                - FROM 절에 기준이 되는 테이블을 기술한다.
                - JOIN 절에 같이 조회하고자 하는 테이블을 기술 후 매칭 시킬 칼럼에 대한 조건을 기술한다.
                - 연결에 사용하려는 칼럼명이 같은 경우 ON 구문 대신에 USING(칼럼명) 구문을 사용한다.
*/

--사원명, 직급코드, 직급명 조회
SELECT EMP_NAME, ABC.JOB_CODE, JOB_NAME
FROM EMPLOYEE ABC JOIN JOB X ON(ABC.JOB_CODE = X.JOB_CODE) 
;

--부서별 급여 합계 조회
-- 부서명, 급여합계 출력
SELECT 
    D.DEPT_TITLE
    ,SUM(E.SALARY)
FROM EMPLOYEE E 
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE E.DEPT_CODE <> 'D5'
GROUP BY D.DEPT_TITLE
;



-- EMPLOYEE 테이블 , JOB 테이블을 이용하여
-- 사원명, 직급코드, 직급명 조회
SELECT EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E  
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
;

-- EMPLOYEE 테이블 , DEPARTMENT 테이블을 이용하여
-- 사원명, 부서코드, 부서명 조회
SELECT EMP_NAME, E.DEPT_CODE, DEPT_TITLE 
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON (E.DEPT_CODE = D.DEPT_ID)
;

-- DEPARTMENT 테이블 , LOCATION 테이블을 이용하여
-- 부서코드, 부서명, 지역코드, 지역명, 국가코드 조회
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


-- LOCATION 테이블 , NATIONAL 테이블을 이용하여
-- 지역코드, 지역명, 국가코드, 국가명 조회
SELECT 
    LOCAL_CODE
    ,LOCAL_NAME
    ,L.NATIONAL_CODE
    ,NATIONAL_NAME
FROM LOCATION L
JOIN NATIONAL N
ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
;


-- DEPARTMENT 테이블 , LOCATION 테이블 , NATIONAL 테이블을 이용하여
-- 부서코드, 부서명, 지역명, 국가명 조회
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



