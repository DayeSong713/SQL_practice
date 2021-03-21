--1. 교수에 대한 전체 자료를 다음과 같은 형식으로 만들어 보자
--(단, 모든 교수들에 대해 출력되도록 한다)
--교수이름	지도학생수 지도학생_성적평균	A_학점자수	B_학점자수	C_학점자수	D_학점자수
--심슨      	2	        79	                    1	        0	        0	        1
--허은	        2	        83	                    0	        1	        1	        0
--조인형	    1	        97	                    1	        0	        0	        0
p - s(+) - e(+) - h(+);

select p.NAME, count(s.STUDNO) AS 학생수, nvl(avg(e.TOTAL),0),
       sum(decode(substr(h.GRADE,1,1),'A',1,0)) AS A학점자수,
       count(decode(substr(h.GRADE,1,1),'B',1,null)) AS B학점자수,
       sum(decode(substr(h.GRADE,1,1),'C',1,0)) AS C학점자수,
       sum(decode(substr(h.GRADE,1,1),'D',1,0)) AS D학점자수
  from PROFESSOR p, STUDENT s, EXAM_01 e, HAKJUM h
 where p.PROFNO = s.PROFNO(+)
   and s.STUDNO = e.STUDNO(+)
   and e.TOTAL between h.MIN_POINT(+) and h.MAX_POINT(+)
 group by p.NAME;


--2. STUDENT 테이블과 EXAM_01 테이블을 사용하여
--각 학생보다 같은 학년 내에 시험성적이 높은 친구의 수를 출력하되,
--학생이름, 학년, 학과번호, 시험성적과 함께 출력하여라.
s1(+) - e1(+)               (s1 - e1)
|        |         =>           |
s2(+) - e2(+)               (s2 - e2)(+);

select s1.NAME AS 학생이름, s1.GRADE, s1.DEPTNO1, e1.TOTAL,
       count(s2.STUDNO) AS 친구수 
  from STUDENT s1, EXAM_01 e1, STUDENT s2, EXAM_01 e2
 where s1.STUDNO = e1.STUDNO(+)
   and s2.STUDNO(+) = e2.STUDNO
   and s1.GRADE(+)  = s2.GRADE
   and e1.TOTAL  < e2.TOTAL(+)
 group by s1.STUDNO, s1.NAME, s1.GRADE, s1.DEPTNO1, e1.TOTAL;


select i1.name as 학생이름, i1.grade, i1.deptno1, i1.total,
       count(i2.studno) as 친구수 
  from (select s1.studno, s1.name, s1.grade, s1.deptno1, e1.total
          from student s1, exam_01 e1
         where s1.studno = e1.studno) i1,
       (select s2.studno, s2.name, s2.grade, s2.deptno1, e2.total
          from student s2, exam_01 e2
         where s2.studno = e2.studno) i2
 where i1.grade = i2.grade(+)
   and i1.total < i2.total(+)
 group by i1.studno, i1.name, i1.grade, i1.deptno1, i1.total; 

--3. student2 테이블을 student 테이블과 동일하게 만들고 
--create table STUDENT2 as select * from STUDENT;
--student2 테이블에서 제1의 전공번호가 301인 학생들의 출생년도와 동일한 학생들을 삭제하여라.
create table STUDENT2 as select * from STUDENT;

delete from STUDENT2
 where to_char(BIRTHDAY,'YYYY') in (select to_char(BIRTHDAY,'YYYY')
                                      from STUDENT2
                                     where deptno1 = 301);

--4. STUDENT2 테이블에서 각 학년별 최대키를 갖는 학생을 찾아 삭제하여라.
delete from STUDENT2
 where (grade, height) in (select grade, max(height)
                             from STUDENT2
                            group by grade);

delete from STUDENT2 s1
 where height = (select max(height)
                    from STUDENT2 s2
                   where s1.grade = s2.grade);

rollback;









