--DQL == DATA QUERY LANGUAGES(SELECT)

/*
<SELECT>절
    [문법]
       (조회)SELECT 컬럼, 컬럼, 컬럼, ....
             FROM 테이블명;
        
    -데이터를 조회할 때 사용
    -SELECT를 통해 얻은 결과를 RESULT SET 이라고 한다.(콘솔창?에 나온 결과)
    -조회하려는 칼럼은 반드시 FROM절에 기술한 테이블에 존재해야한다.
*/
--EMPLOYEE 테이블에서 EMP_ID, EMP_NAME 조회
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE;
--EMPLOYEE 테이블에서 사원번호, 사원명, 이메일, 급여조회

SELECT EMP_ID, EMP_NAME,EMAIL,SALARY
FROM EMPLOYEE;

--EMPLOYEE 테이블에서 전체 사원의 모든 컬럼(*)정보 조회
SELECT*
FROM EMPLOYEE;
--DB에서는 대소문자 구분이 없다.

/*
<산술연산>
    SELECT절에 칼럼명 입력 부분에서 산술 연산을 할 수 있다.
*/


--사원명, 연봉(월급*12) 조회
SELECT EMP_NAME, SALARY*12
FROM EMPLOYEE;

--직원명, 연봉, 보너스,보너스가 포함된 연봉((급여+(급여+보너스))*12)조회
--산술연산 중 NULL값이 존재할 경우, 결과값은 무조건 NULL
SELECT EMP_NAME, SALARY*12, BONUS, (SALARY+ (SALARY*BONUS))*12
FROM EMPLOYEE;

--직원명,입사일,근무일수(오늘날짜-입사일)SYSDATE : 현재시각
SELECT EMP_NAME, HIRE_DATE,FLOOR(SYSDATE- HIRE_DATE) AS "근무일수"
FROM EMPLOYEE;

/*
<칼럼명에 별칭 지정>
    [문법]
        칼럼명 AS 별칭
        칼럼명 AS "별칭"
        칼럼명 별칭
        칼럼명 "별칭"
        
        -별칭 지정시 공백, 특수문자가 포함될 경우 반드시 큰따옴표로 감싸야 한다.
        -왜씀? 보기 좋으라고
        -사용 이유 : 산술연산 등으로 인해 칼럼명이 지저분해 질 경우, 깔끔하게 작성하기 위해
    
*/
/*
<리터럴>
    SELECT 절에 리터럴(값 자체)을 사용하면 테이블에 존재하는 데이터처럼 조회가 가능하다.
    리터럴은 RESULT SET 의 모든 행에 반복적으로 출력된다.

*/
SELECT EMP_NAME, SALARY AS 급여, '단위(원)' AS 급여단위
FROM EMPLOYEE;


/*
    <DISTINCT>: 중복 제거
        칼럼에 포함된 중복 값을 한번씩만 표시
        SELECT 절에 한번만 사용 가능
        여러개 칼럼을 대상으로 하면 모든 칼럼이 중복되어야 제거한다.
*/

-- 직급코드 조회.중복제거
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

--직급코드, 부서코드 조회
SELECT DISTINCT JOB_CODE, DEPT_CODE
FROM EMPLOYEE;

/*
    <연결 연산자> : ||
        여러 칼럼 값을 하나의 컬럼인 것처럼 연결하거나,
        칼럼과 리터럴을 연결할 수 있다.

*/
--사번, 사원명, 급여 연결해서 조회
SELECT EMP_ID||EMP_NAME||'의 월급은' ||SALARY||'원 입니다.' AS "사원 정보 및 급여"
FROM EMPLOYEE;

------------------------------------------------------

/*

    <WHERE 절>
        [문법]
            SELECT 칼럼, 칼럼, ..., 칼럼
              FROM 테이블명
             WHERE 조건식;
             
        - 조회하고자 하는 테이블에서 해당 조건에 만족하는 결과만을 조회하고자 할 때 사용한다.
        - 조건식에는 다양한 연산자들을 사용할 수 있다.
        
    <비교 연산자>
        >, <, >=, <= : 대소 비교
        =            : 동등 비교
        !=, ^=, <>   : 같지 않다
*/
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID =210;



-- 부서 코드가 D9와 일치하는 사원들의 모든 컬럼 정보 조회
-- 부서 코드가 D9가 아닌 사원들의 사번, 사원명, 부서 코드 조회
-- 급여가 400만원 이상인 직원들의 직원명, 부서 코드, 급여 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

SELECT EMP_NAME, EMP_ID, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE != 'D9';

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;


-- 실습문제
--1. 재직중 칼럼값이 'N' 인 사원들의 사번,이름,입사일 조회
--2. 연봉이 5000만원 이상인 직원의 사번,이름,연봉 조회

SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

SELECT EMP_ID, EMP_NAME, SALARY*12 AS 연봉
FROM EMPLOYEE
WHERE SALARY*12 >= 50000000;
/*
    <논리 연산자>
        AND 
        OR 
        NOT
*/
--부서 코드가 D6이면서 급여가 300만원 이상인 직원들의 모든 컬럼 조회

SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' AND SALARY >= 3000000;

--급여가 400만원 이상, 직급 코드가 J2인 사원의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE ='J2' AND SALARY >= 4000000;

--부서코드가 D6이거나 D2에 해당하는 직원들의 모든 칼럼 조회

SELECT*
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' 
OR DEPT_CODE = 'D2';

--급여가 350 만원ㅇ 이상, 600만원 이하인 직원의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >=3500000 AND SALARY <=6000000;

/*
    <BETWEEN AND>
        [문법]
            WHERE 비교대상컬럼 BETWEEN A AND B
            - A~B범위
            
        - WHERE 절에서 사용되는 구문으로 범위에 대한 조건을 제시할 때 사용한다.
        - 비교대상컬럼 값이 하한값 이상이고, 상한값 이하인 경우 TRUE를 리턴한다.
*/

--급여가 350 만원ㅇ 이상, 600만원 이하인 직원의 이름, 부서코드, 급여 조회
SELECT *
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

--급여가 350 만원 이상, 600만원 이하가 아닌 직원의 이름, 부서코드, 급여 조회
SELECT *
FROM EMPLOYEE
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;

--입사일 '90/01/01'~ '01/01/01'인 사원의 모든 칼럼 조회
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

/*
    <LIKE>
        [문법]
            WHERE 비교대상칼럼 LIKE '특정 패턴';
            
        - 비교하려는 칼럼 값이 지정된 특정 패턴에 만족할 경우 TRUE를 리턴한다.
        - 특정 패턴에는 '%', '_'를 와일드카드로 사용할 수 있다.
          '%' : 0글자 이상
            ex) 비교대상칼럼 LIKE '문자%'  => 비교대상칼럼 값 중에 '문자'로 시작하는 모든 행을 조회한다.
                비교대상칼럼 LIKE '%문자'  => 비교대상칼럼 값 중에 '문자'로 끝나는 모든 행을 조회한다.
                비교대상칼럼 LIKE '%문자%' => 비교대상칼럼 값 중에 '문자'가 포함되어 있는 모든 행을 조회한다.
                
          '_' : 1글자
            ex) 비교대상칼럼 LIKE '_문자'  => 비교대상칼럼 값 중에 '문자'앞에 무조건 한 글자가 오는 모든 행을 조회한다.
                비교대상칼럼 LIKE '__문자' => 비교대상칼럼 값 중에 '문자'앞에 무조건 두 글자가 오는 모든 행을 조회한다.
*/

--성이 전씨인 사람의 모든 칼럼 조회
SELECT*
FROM EMPLOYEE
WHERE EMP_NAME LIKE'전%';

--이름 중 '하'가 포함된 사원의 모든 칼럼 조회
SELECT*
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

--전화번호 4번째 자리가 9로 시작하는 사원의 사원명,전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

--이메일 중 앞 글자가 3자리인 이메일 주소를 가진 사원의 사번, 사원명,이메일 조회
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '___a_%'ESCAPE'a';--특별한문자로 만들기=>ESCAPE
-----------실습 문제-----------------
--전화번호 처음 3자리가 010이 아닌 사원의 이름,전화번호 조회
--해외영업부에 대한 모든 컬럼 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%'
;

SELECT *
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D5'
OR DEPT_CODE = 'D6'
OR DEPT_CODE = 'D7'
;

/*
    <IS NULL / IS NOT NULL>
        [문법]
            WHERE 비교대상칼럼 IS [NOT] NULL;
            
        - 칼럼 값에 NULL이 있을 경우 NULL 값 비교에 사용된다.
          IS NULL : 비교대상칼럼 값이 NULL인 경우 TRUE를 리턴한다.
          IS NOT NULL : 비교대상칼럼 값이 NULL이 아닌 경우 TRUE 리턴한다.
*/  

--보너스를 받지 않는 사원의 모든 칼럼 조회
SELECT*
FROM EMPLOYEE
WHERE BONUS IS NULL;

--부서가 없는 사원의 모든 칼럼 조회
SELECT*
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL;

--부서가 있고, 보너스 받지 않는 사원의 모든 칼럼 조회
SELECT*
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
AND BONUS IS NULL;

/*

 <IN>
        [문법]
            WHERE 비교대상칼럼 IN('값', '값', '값', ..., '값');
        
        - 값 목록 중에 일치하는 값이 있을 때 TRUE 리턴한다.
*/

--해외영업부에 대한 모든 컬럼 조회
SELECT *
FROM EMPLOYEE 
WHERE DEPT_CODE IN('D5','D6','D7')
;

--직급코드가 J2,J3,J4에 해당하는 모든 사원 조회
SELECT*
FROM EMPLOYEE
WHERE JOB_CODE IN ('J2','J3','J4');

/*
    <연산자 우선순위>
        0. ()
        1. 산술 연산자
        2. 연결 연산자
        3. 비교 연산자
        4. IS NULL, LIKE, IN
        5. BETWEEN AND
        6. 논리 연산자 - NOT
        7. 논리 연산자 - AND
        8. 논리 연산자 - OR
*/
/*
    <ORDER BY>내가 조회한 결과에 순서를 매길 때
        [문법]
            SELECT 칼럼, 칼럼, ..., 칼럼
              FROM 테이블명
             WHERE 조건식
          ORDER BY 정렬시키고자 하는 칼럼명|별칭|칼럼 순번 [ASC|DESC] [NULLS FIRST | NULLS LAST];
          
        - SELECT 문에서 가장 마지막에 기입하는 구문으로 실행 또한 가장 마지막에 진행된다.
        - ASC : 오름차순으로 정렬한다. (ASC 또는 DESC 생략 시 기본값)
        - DESC : 내림차순으로 정렬한다.높은순부터 낮은순으로 
        - NULLS FIRST : 정렬하고자 하는 칼럼 값에 NULL이 있는 경우 해당 데이터 값을 맨 앞으로 정렬한다.
        - NULLS LAST : 정렬하고자 하는 칼럼 값에 NULL이 있는 경우 해당 데이터 값을 맨 뒤로 정렬한다.
*/
--급여 기준 정렬
SELECT *
FROM EMPLOYEE
ORDER BY SALARY DESC
;

--보너스 기준 정렬
SELECT EMP_NAME, BONUS
FROM EMPLOYEE
ORDER BY BONUS DESC NULLS FIRST--NULL값이 기본으로 제일 위
;