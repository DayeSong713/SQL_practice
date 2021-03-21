--1. student3 ���̺��� ����� �񸸿��θ� ��Ÿ���� �÷��� ���� �߰��ϰ�, 
--�� �л����� �������� update �Ͽ���.
--�񸸿��δ� ü���� ǥ��ü�ߺ��� ũ�� ��ü��, ������ ��ü��, ������ ǥ������ �з��Ͽ���.
-- *ǥ��ü�� = (Ű-100)*0.9
create table STUDENT3 as select * from STUDENT;
alter table STUDENT3 add (biman varchar2(10));

select name, height, weight, 
       case when weight > (height - 100)*0.9 then '��ü��'
            when weight < (height - 100)*0.9 then '��ü��'
                                             else 'ǥ��'
        end AS �񸸿���                                    
  from STUDENT3;

update STUDENT3
   set biman = case when weight > (height - 100)*0.9 then '��ü��'
                    when weight < (height - 100)*0.9 then '��ü��'
                                                     else 'ǥ��'
                end
;

update STUDENT3 s1
   set biman = (select case when weight > (height - 100)*0.9 then '��ü��'
                            when weight < (height - 100)*0.9 then '��ü��'
                                                             else 'ǥ��'
                        end
                  from STUDENT3 s2
                 where s1.STUDNO = s2.STUDNO)
;

--2. user_tab_columns �並 ����Ͽ� desc emp ����� �����ϰ� ���
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

--3. ������ ������ ������ �� �ߺ��� �����͸� ��� �����ϴ� ������ �ۼ��Ͽ���.
insert into STUDENT3 select * from STUDENT3 where deptno1 = 101;
commit;

delete from STUDENT3
  where studno in (select STUDNO
                     from STUDENT3
                    group by STUDNO
                   having count(STUDNO) >= 2);









