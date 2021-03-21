--1. professor 테이블에서 각 교수의 이메일 아이디를 출력하되,
--다음의 특수기호를 제거한 형태로 출력하여라.
select EMAIL,
       instr(EMAIL,'@') AS "@위치",
       substr(EMAIL,1,instr(EMAIL,'@') -1) AS "email id",
       translate(substr(EMAIL,1,instr(EMAIL,'@') -1),
                 'a_-*&^%$',
                 'a')
  from PROFESSOR;

--2. student 테이블에서 전화번호 형식을 다음과 같이 변경하세요.  
--051)426-1700 => 051 426 1700
select TEL, translate(TEL,')-','  ')
  from STUDENT;
  
--3. EMP 테이블을 이용하여 사원이름, 입사일 및 급여검토일을 표시합니다. 
--급여검토일은 여섯달 근무후 해당되는 첫번째 월요일입니다. 
--날짜는 "Sunday the Seventh of September, 1981" 형식으로 표시하도록 한다. 
--열 이름은 check로 한다.
alter session set nls_date_language='american';
select ENAME, HIREDATE, 
       next_day(add_months(HIREDATE,6),2),
       to_char(next_day(add_months(HIREDATE,6),2),
               'Day "the" Ddspth "of" Month, YYYY')
  from emp;
  
--4. student 테이블에서 jumin 컬럼을 사용하여 생년월일이 다음 사이인 학생의 정보를 출력하세요.
--(19760205 ~ 19760924)
select NAME, JUMIN, to_date(substr(JUMIN,1,6),'RRMMDD')
  from STUDENT
 where to_date(substr(JUMIN,1,6),'RRMMDD') between to_date('19760205','YYYYMMDD') 
   and to_date('19760924','YYYYMMDD');
  
--5. emp 테이블을 이용하여 현재까지 근무일수를 XX년 XX개월 XX일 형태로 출력하세요.
select ENAME, HIREDATE,
       trunc(sysdate - hiredate) AS 근무일수,
       trunc((sysdate - hiredate)/365) AS 근속년수,
       trunc(months_between(sysdate, hiredate)) AS 총근무개월수,
       mod(trunc(months_between(sysdate, hiredate)),12) AS 근속개월수,
       sysdate,
       trunc(sysdate - add_months(hiredate, trunc(months_between(sysdate, hiredate))))
       AS "나머지 근무일수"
  from emp;
  
--6. Student 테이블의 jumin 컬럼을 참조하여 학생들의 이름과 태어난 달, 그리고 분기를 출력하라.
--태어난 달이 01-03월 은 1/4분기, 04-06월은 2/4 분기, 
--07-09 월은 3/4 분기, 10-12월은 4/4 분기로 출력하라 (decode,case모두)
select name, jumin, 
       to_char(to_date(substr(jumin,1,6),'RRMMDD'),'Q') AS 분기,
       decode(to_char(to_date(substr(jumin,1,6),'RRMMDD'),'Q'),'1','1/4분기',
                                                               '2','2/4분기',
                                                               '3','3/4분기',
                                                                   '4/4분기') AS 분기1,
       case when to_number(substr(jumin,3,2)) between 1 and 3 then '1/4분기'
            when to_number(substr(jumin,3,2)) between 4 and 6 then '2/4분기'
            when to_number(substr(jumin,3,2)) between 7 and 9 then '3/4분기'
                                                              else '4/4분기'
        end AS 분기2                                                                                                      
  from STUDENT;
  
--7. EMP2 테이블에서 출생년도(1960,1970,1980,1990)별로 평균연봉을 구하라.
select trunc(to_char(BIRTHDAY,'YYYY'),-1), round(avg(nvl(pay,0)))
  from emp2
 group by trunc(to_char(BIRTHDAY,'YYYY'),-1); 
 
--8. emp 테이블에서 인상된 연봉을 기준으로 2000 미만은 'C',
--2000이상 4000미만은 'B', 4000이상은 'A' 등급을 부여하여 각 직원의 현재 연봉과 함께 출력
--**인상된 연봉은 기존 연봉 대비 15% 상승률 + 보너스(comm)
select ename, sal, 
       case when sal*1.15 + nvl(comm,0) < 2000 then 'C'
            when sal*1.15 + nvl(comm,0) < 4000 then 'B'
                                               else 'A'
        end AS 등급
  from emp;

--9. emp 테이블을 사용하여 연봉기준 등급을 아래의 기준에 맞게 표현하세요.
--2000미만 'C', 2000이상 3000이하 'B', 3000초과 'A'
select ename, sal, sign(sal-2000), sign(sal-3000),
       decode(sign(sal-2000),-1,'C',decode(sign(sal-3000),1,'A','B'))
  from emp;

--10. 레포트를 작성하고자 한다.
--emp 테이블을 이용하여 각 부서별 직원수를 출력하되 다음과 같은 형식으로 작성하여라.
--
--레포트명	       10_직원수	 20_직원수	  30_학생수
----------------------------------------------------------
--송다예 레포트	        3	         5           6


select '송다예 레포트' AS 레포트명, 
        sum(decode(DEPTNO,10,1,0)) AS "10_직원수",
        sum(decode(DEPTNO,20,1,0)) AS "20_직원수",
        sum(decode(DEPTNO,30,1,0)) AS "30_직원수"
  from emp;




