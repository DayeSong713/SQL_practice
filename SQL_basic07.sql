--1. student3 테이블을 만들고 비만여부를 나타내는 컬럼을 새로 추가하고, 
--각 학생들의 비만정보를 update 하여라.
--비만여부는 체중이 표준체중보다 크면 과체중, 작으면 저체중, 같으면 표준으로 분류하여라.
-- *표준체중 = (키-100)*0.9
create table STUDENT3 as select * from STUDENT;
alter table STUDENT3 add (biman varchar2(10));

select name, height, weight, 
       case when weight > (height - 100)*0.9 then '과체중'
            when weight < (height - 100)*0.9 then '저체중'
                                             else '표준'
        end AS 비만여부                                    
  from STUDENT3;

update STUDENT3
   set biman = case when weight > (height - 100)*0.9 then '과체중'
                    when weight < (height - 100)*0.9 then '저체중'
                                                     else '표준'
                end
;

update STUDENT3 s1
   set biman = (select case when weight > (height - 100)*0.9 then '과체중'
                            when weight < (height - 100)*0.9 then '저체중'
                                                             else '표준'
                        end
                  from STUDENT3 s2
                 where s1.STUDNO = s2.STUDNO)
;

--2. user_tab_columns 뷰를 사용하여 desc emp 결과와 동일하게 출력
desc emp;
select COLUMN_NAME AS "Column",
       decode(NULLABLE,'N','NOT NULL') AS "Nullable",       
       case DATA_TYPE when 'NUMBER' then DATA_TYPE||'('
                                         ||DATA_PRECISION||
                                         decode(DATA_SCALE,0,null,','||DATA_SCALE)
                                         ||')'
                      when 'DATE'   then DATA_TYPE
                                    else DATA_TYPE||'('||DATA_LENGTH||')'
        end AS "Type"
  from user_tab_columns
 where table_name = 'EMP';

--3. 다음의 쿼리를 실행한 후 중복된 데이터를 모두 삭제하는 쿼리를 작성하여라.
insert into STUDENT3 select * from STUDENT3 where deptno1 = 101;
commit;

delete from STUDENT3
  where studno in (select STUDNO
                     from STUDENT3
                    group by STUDNO
                   having count(STUDNO) >= 2);









