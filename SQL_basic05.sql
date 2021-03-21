--1.emp 테이블에서 이름이 S로 시작하는 사원의 연봉보다 큰 연봉을 갖는
-- 사원의 이름, 직업, 연봉을 출력

select ename, job, SAL
from EMP
where sal>(
select max(sal)
from EMP
where ename like 'S%');



-- 2. STUDENT테이블에서 성별로 평균몸무게보다 높은 학생의 이름, 학년, 몸무게, 평균몸무게 출력

 -- 2-1) 다중컬럼 서브쿼리 (최대몸무게로 비교)
 
 select *
 from STUDENT
 where ( decode(substr(jumin,7,1), '1', '남자','여자'),weight) in ( 
 
 
                        select  decode(substr(jumin,7,1), '1', '남자','여자'), max(weight)
                          from  STUDENT
                      group by  decode(substr(jumin,7,1), '1', '남자','여자'));
 
 
 
 
 -- 2-2) 인라인뷰
 
 select *
 from student s, (select  decode(substr(jumin,7,1), '1', '남자','여자') as 성별, round(avg(weight)) 평균몸무게
                    from  STUDENT
                group by  decode(substr(jumin,7,1), '1', '남자','여자')) i
                
 where decode(substr(jumin,7,1), '1', '남자','여자') = i.성별
 and s.WEIGHT > i.평균몸무게;
                
                
  
--3. emp2 테이블에서 각 지역별(지역번호 참조) 직원의 평균연봉보다 더 많은 연봉을 받는
-- 직원의 이름, 고용형태, 지역, pay, 직급을 구하여라.


select *
from emp2 e, (select substr(tel,1,instr(tel,')')-1) as 지역번호, avg(pay) as 평균페이
from emp2
group by substr(tel,1,instr(tel,')')-1)) i
where substr(e.tel,1,instr(e.tel,')')-1) = i.지역번호
and e.pay > i.평균페이;




--4. emp 테이블을 이용하여 본인과 상위관리자의 평균연봉보다 많은 연봉을 받는 직원의
--이름, 부서명, 연봉, 상위관리자명을 출력하여라.



select e1.ename as 직원이름, e1.sal as 직원연봉,
       e2. ename as 상위관리자이름, e2.sal as 상위관리자연봉, (e1.sal+e2.sal)/2 as 평균연봉, d.dname
from emp e1, emp e2, dept d
where e1.mgr = e2.empno(+)
and e1.sal> (e1.sal+e2.sal)/2  -- 한 행만 읽어도 데이터 얻을 수 있으면 조인, 서브쿼리 필요 없다.
and e1. deptno = d.deptno;   





--5. PROFESSOR 테이블에서 각 부서별 최대연봉을 갖는 교수의 이름, 교수번호, pay 출력


--1) 다중컬럼
                       
                       
 select name, profno, pay
 from PROFESSOR
 where (deptno, pay) in (
                       select deptno, max(pay)
                       from PROFESSOR
                        group by deptno); 


--2) 인라인뷰

select p.name, p.profno, p.pay, i.최대연봉
from PROFESSOR p,

(select max(pay) as 최대연봉, deptno 부서번호
from PROFESSOR
group by deptno) i

where p.pay = i.최대연봉
and p.deptno = i.부서번호; 




--6.  emp2 테이블에서 각 고용타입( emp_type) 별 평균연봉보다 높은 사람의
--이름, 부서이름, 연봉, 해당 고용타입의 평균연봉 출력

select *
from emp2 e1
where pay> (select avg(pay)
                 from emp2 e2
                where e1.emp_type =  e2.emp_type);
   
   desc emp2;  
   
   
 
 
 -- 인라인뷰 
 
select e.name, d.dname, e.pay, i.평균연봉, e.emp_type
from emp2 e, dept2 d, (select avg(pay)   as 평균연봉, emp_type as 고용형태
                from emp2
            group by emp_type) i
  
  where e.deptno = d.dcode
  and e.emp_type = i.고용형태
  and e.pay >= i.평균연봉;
  
  



--7. emp 테이블에서 직업별 최대연봉을 구하고, 직업별 최대연봉을 갖는
--직원의 이름, 직업, 연봉을 구하세요. 
--(다중컬럼, 인라인뷰, 상호연관 서브쿼리)



--인라인뷰
select e.ename, e.job, e.sal 
from emp e, 
 (select job, max(sal) as 최대연봉
from EMP
group by job) i
where e.sal = i.최대연봉
and e.job = i.job;


--다중컬럼 서브쿼리
select ename, job, sal
from EMp
where (job, sal) in (select job,  max(sal)
                       from EMP
           
                       group by job); 


--상호연관
select ename, job, sal
from emp e1
where sal = (select max(sal)
               from emp e2
              where e1.job = e2.job);
             



--8. STUDENT 테이블과 EXAM_01 테이블을 사용하여 각 학생의 시험성적을 이름과 함께 출력하여라
--(스칼라 서브쿼리)


select name, (select e.total  
              from EXAM_01 e 
              where s.studno = e.STUDNO) as 시험성적
from STUDENT s;



--9. professor 테이블에서 입사년도(1980,1990,2000년대)별 평균연봉보다 높은 연봉을 받는 
--교수의 이름, 연봉, 지도학생 수를 출력하여라.
--(인라인뷰, 상호연관)

      
--인라인뷰
select p.name, p.pay, count(s.studno), i.평균연봉
from professor p, (

select trunc(to_char(hiredate,'YYYY'),-1) as 입사년도 , round(avg(pay)) as 평균연봉
from PROFESSOR
group by trunc(to_char(hiredate,'YYYY'),-1)) I, student s
where p.pay> i.평균연봉
  and
      trunc(to_char(p.hiredate,'YYYY'),-1) = i.입사년도 
   and p.profno = s.profno(+)
   group by p.profno, p.name, p.pay, i.평균연봉 ;
 


  
 --상호연관
  
 select p1.name, p1.pay
  from professor p1
 where pay > ( select  round(avg(pay)) as 평균연봉
                  from PROFESSOR p2
                  where trunc(to_char(p1.hiredate,'YYYY'),-1) = 
                        trunc(to_char(p2.hiredate,'YYYY'),-1));
  
              
            
--10. student, professor 테이블에서 같은지역, 같은 성별의 친구가 몇명인지 구하고, 
--그 학생의 담당 교수이름도 함께 출력되도록 하여라.
--단, 같은지역, 같은 성별에 본인은 포함될 수 없다.


select s1.name, count(s2.studno), p.name
from student s1, student s2, PROFESSOR p
where substr(s1.jumin,7,1) = substr(s2.jumin(+),7,1)
  and substr(s1.tel,1,instr(s1.tel,')')-1) = substr(s2.tel(+),1,instr(s2.tel(+),')')-1)
  and s1.studno != s2.studno(+)
  and s1.profno = p.profno(+)
  group by s1.STUDno, s1.name, p.name
 ;
 