--1. 다음을 수행 한 후 중복된 데이터를 삭제하되 한 건은 남기도록 하여라(전부삭제X)
drop table STUDENT_TEST;
create table STUDENT_TEST as select * from STUDENT;
insert into STUDENT_TEST select * from STUDENT where deptno1 = 101;
insert into STUDENT_TEST select * from STUDENT where deptno1 = 101;
commit;

select * from STUDENT_TEST;

delete from STUDENT_TEST s1
 where ROWID != (select max(ROWID)
                    from STUDENT_TEST s2
                   where s1.studno = s2.studno
                   group by studno
                  having count(studno) >= 2);
                  
rollback;

--2. 다음과 같은 정보를 갖는 쿼리 작성(뷰들 활용)
--테이블명     pk이름          pk컬럼     인덱스수
--EMP2	    SYS_C0011047	   DEPTNO	        2
--STUDENT	SYS_C0011043	   GRADE	        8
--TEST       .                  .               0
user_indexes - user_tables - user_cons_columns(+) - user_constraints(+)
;
select TABLE_NAME
  from user_tables
 minus 
select distinct TABLE_NAME 
  from user_cons_columns;
  
select t.table_name, 
       c.constraint_name AS PK이름, 
       c.column_name AS PK컬럼,
       count(i.index_name) AS 인덱스수
  from user_tables t, user_cons_columns c, user_constraints c2, user_indexes i
 where t.table_name = c.table_name(+)
   and c.constraint_name = c2.constraint_name(+)
   and t.table_name = i.table_name(+)
   and c2.constraint_type(+) = 'P'
 group by t.table_name, c.constraint_name, c.column_name;

--3. student 테이블을 이용하여 적정체중이 75 이상인 사람의 수를 구하는
-- 쿼리를 작성하고 해당 쿼리가 인덱스를  정상적으로 scan하도록
-- 만들어라(인덱스 추가 생성 가능)
-- 단, 적정체중은 (키 - 100)*0.9를 의미한다.
create index idx_std_height on STUDENT(height);

select count(height)
  from STUDENT
 where height > 75/0.9 + 100;

select count(height)
  from STUDENT
 where (height - 100)*0.9 > 75;


--4. 다음 인덱스를 생성한 후 아래 쿼리가 해당 인덱스를 스캔할 수 있도록 변경하여라.
drop index idx_std_height;
create index idx_std_grade_height on STUDENT(grade, height);

select name, studno
  from student
 where height > 178
   and grade > 0;
 
 
 
 
 
 
 
 