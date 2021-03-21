--1. ������ ���� �� �� �ߺ��� �����͸� �����ϵ� �� ���� ���⵵�� �Ͽ���(���λ���X)
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

--2. ������ ���� ������ ���� ���� �ۼ�(��� Ȱ��)
--���̺��     pk�̸�          pk�÷�     �ε�����
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
       c.constraint_name AS PK�̸�, 
       c.column_name AS PK�÷�,
       count(i.index_name) AS �ε�����
  from user_tables t, user_cons_columns c, user_constraints c2, user_indexes i
 where t.table_name = c.table_name(+)
   and c.constraint_name = c2.constraint_name(+)
   and t.table_name = i.table_name(+)
   and c2.constraint_type(+) = 'P'
 group by t.table_name, c.constraint_name, c.column_name;

--3. student ���̺��� �̿��Ͽ� ����ü���� 75 �̻��� ����� ���� ���ϴ�
-- ������ �ۼ��ϰ� �ش� ������ �ε�����  ���������� scan�ϵ���
-- ������(�ε��� �߰� ���� ����)
-- ��, ����ü���� (Ű - 100)*0.9�� �ǹ��Ѵ�.
create index idx_std_height on STUDENT(height);

select count(height)
  from STUDENT
 where height > 75/0.9 + 100;

select count(height)
  from STUDENT
 where (height - 100)*0.9 > 75;


--4. ���� �ε����� ������ �� �Ʒ� ������ �ش� �ε����� ��ĵ�� �� �ֵ��� �����Ͽ���.
drop index idx_std_height;
create index idx_std_grade_height on STUDENT(grade, height);

select name, studno
  from student
 where height > 178
   and grade > 0;
 
 
 
 
 
 
 
 