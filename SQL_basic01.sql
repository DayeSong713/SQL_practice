--[ 실습문제 ]

--1. DEPT 테이블을 사용하여 deptno 를 부서# , dname 부서명 , loc 를 위치로 별명을 설정하여 
--출력하세요.
select DEPTNO AS 부서#, DNAME 부서명, LOC 위치 
  from dept;

--2. EMP 테이블에서 부서별(deptno)로 담당하는 업무(job)가 하나씩 출력되도록 하여라.
select distinct deptno, job
  from emp;

--3. 학생 테이블(student)을 사용하여 모든 학생들이
--‘서진수 의 키는 180 cm, 몸무게는 55 kg 입니다’ 와 같은 형식으로 출력
--되도록 하고 , 칼럼이름은 “학생의 키와 몸무게”라는 별명으로 출력해 보세요.
select NAME||'의 키는 '||HEIGHT||' cm, 몸무게는 '||WEIGHT||' kg 입니다' 
       AS "학생의 키와 몸무게"
  from STUDENT;

--4. 교수 테이블(professor)을 사용하여 교수의 이름과 직급이 아래와 같이 
--홍길동 (교수) , 홍길동 ‘교수’ 이렇게 나오도록 출력해보세요. 
--출력된 컬럼 이름은 교수님 입니다.
select NAME||' ('||POSITION||') , '||NAME||' '''||POSITION||''''
  from PROFESSOR;
  
--5. EMP 테이블에서 급여(sal)가 3000 이상인 사원의 사원번호(empno), 이름(ename), 업무(job), 
--급여(sal)를 출력하라.
select empno, ename, job, sal 
  from emp
 where sal >= 3000;
 
--6. EMP 테이블에서 담당업무가 Manager인 사원의 정보를 사원번호, 성명, 업무, 급여, 
--부서번호(deptno)를 출력하라.
select empno, ename, job, sal, deptno
  from emp
 where initcap(job) = 'Manager';

select empno, ename, job, sal, deptno
  from emp
 where job = 'MANAGER';
 
--7. EMP 테이블에서 급여가 1300에서 1700 사이인 사원의 성명, 업무, 급여, 부서번호(deptno)를 
--출력하여라.
select ename, job, sal, deptno 
  from emp
 where sal between 1300 and 1700;
 
--8. EMP테이블에서 사원번호(empno)가 7902, 7788, 7566인 사원의 사원번호, 성명, 업무, 급여, 
--입사일자(hiredate)를 출력하여라.
select empno, ename, job, sal, hiredate
  from emp
 where empno in (7902, 7788, 7566);
 
--9. EMP 테이블에서 급여가 1100 이상이고, JOB이 Manager인 사원의 사원번호, 성명, 담당업무,
--급여, 입사일자, 부서번호를 출력하여라.
select empno, ename, job, sal, hiredate, deptno
  from emp
 where sal >= 1100
   and job = 'MANAGER';


--10. emp 테이블에서 커미션(comm)을 받지 않는 사원의 급여를 10% 인상하여 표시하되, 
--다음의 형식으로 출력하여라.
--The salary of SMITH after a 10% raise is 880
select 'The salary of '||ENAME||' after a 10% raise is '||SAL*1.1 
  from EMP
 where comm is null
    or comm = 0;
 
--11. student 테이블에서 지역번호와 국번을 각각 출력하여라.
select name, tel, substr(tel,1,3),
       instr(TEL,')') AS ")의 위치",
       substr(tel,
                1,
              instr(TEL,')') - 1) AS 지역번호,
       instr(TEL,'-') AS "-의 위치",
       instr(TEL,'-') - instr(TEL,')') - 1 AS 추출개수,
       substr(tel, 
              instr(TEL,')') + 1,
              instr(TEL,'-') - instr(TEL,')') - 1) AS 국번       
  from STUDENT;

--12. STUDENT 테이블을 사용하여 주민번호, 생년월일 각각을 사용하여 각 학생의 태어난 날의 
--요일을 출력하세요.
select to_date('751023','RRMMDD') from dual;

select JUMIN, substr(JUMIN,1,6), 
       to_date(substr(JUMIN,1,6),'RRMMDD'),
       to_char(to_date(substr(JUMIN,1,6),'RRMMDD'), 'DAY'), 
       to_char(BIRTHDAY, 'DAY')
  from STUDENT;

--13. student 테이블에서 성이 'ㅅ'인 학생의 학번, 이름, 학년을 출력하여라.
select studno, name, grade
  from STUDENT
 where substr(name,1,1) >= '사'
   and substr(name,1,1) < '아'
 ;

--14. EMPLOYEES 테이블에서 대소를 구분하지 않고 email에 last_name이 포함되어 있지 않은 
--사람의 EMPLOYEE_ID, FIRST_NAME, EMAIL을 출력하여라.
--(EMPLOYEES 테이블은 hr 계정에서 조회 가능)
--1) instr 사용
select instr('DGRANT',upper('Grant')) from dual;

select * 
  from EMPLOYEES
 where instr(EMAIL,upper(LAST_NAME)) = 0 ;

--2) like 연산자 사용
select *
  from EMPLOYEES
 where EMAIL not like '%'||upper(LAST_NAME)||'%';