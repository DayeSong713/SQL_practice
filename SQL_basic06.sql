--1. ������ ���� ��ü �ڷḦ ������ ���� �������� ����� ����
--(��, ��� �����鿡 ���� ��µǵ��� �Ѵ�)
--�����̸�	�����л��� �����л�_�������	A_�����ڼ�	B_�����ڼ�	C_�����ڼ�	D_�����ڼ�
--�ɽ�      	2	        79	                    1	        0	        0	        1
--����	        2	        83	                    0	        1	        1	        0
--������	    1	        97	                    1	        0	        0	        0
p - s(+) - e(+) - h(+);

select p.NAME, count(s.STUDNO) AS �л���, nvl(avg(e.TOTAL),0),
       sum(decode(substr(h.GRADE,1,1),'A',1,0)) AS A�����ڼ�,
       count(decode(substr(h.GRADE,1,1),'B',1,null)) AS B�����ڼ�,
       sum(decode(substr(h.GRADE,1,1),'C',1,0)) AS C�����ڼ�,
       sum(decode(substr(h.GRADE,1,1),'D',1,0)) AS D�����ڼ�
  from PROFESSOR p, STUDENT s, EXAM_01 e, HAKJUM h
 where p.PROFNO = s.PROFNO(+)
   and s.STUDNO = e.STUDNO(+)
   and e.TOTAL between h.MIN_POINT(+) and h.MAX_POINT(+)
 group by p.NAME;


--2. STUDENT ���̺�� EXAM_01 ���̺��� ����Ͽ�
--�� �л����� ���� �г� ���� ���輺���� ���� ģ���� ���� ����ϵ�,
--�л��̸�, �г�, �а���ȣ, ���輺���� �Բ� ����Ͽ���.
s1(+) - e1(+)               (s1 - e1)
|        |         =>           |
s2(+) - e2(+)               (s2 - e2)(+);

select s1.NAME AS �л��̸�, s1.GRADE, s1.DEPTNO1, e1.TOTAL,
       count(s2.STUDNO) AS ģ���� 
  from STUDENT s1, EXAM_01 e1, STUDENT s2, EXAM_01 e2
 where s1.STUDNO = e1.STUDNO(+)
   and s2.STUDNO(+) = e2.STUDNO
   and s1.GRADE(+)  = s2.GRADE
   and e1.TOTAL  < e2.TOTAL(+)
 group by s1.STUDNO, s1.NAME, s1.GRADE, s1.DEPTNO1, e1.TOTAL;


select i1.name as �л��̸�, i1.grade, i1.deptno1, i1.total,
       count(i2.studno) as ģ���� 
  from (select s1.studno, s1.name, s1.grade, s1.deptno1, e1.total
          from student s1, exam_01 e1
         where s1.studno = e1.studno) i1,
       (select s2.studno, s2.name, s2.grade, s2.deptno1, e2.total
          from student s2, exam_01 e2
         where s2.studno = e2.studno) i2
 where i1.grade = i2.grade(+)
   and i1.total < i2.total(+)
 group by i1.studno, i1.name, i1.grade, i1.deptno1, i1.total; 

--3. student2 ���̺��� student ���̺�� �����ϰ� ����� 
--create table STUDENT2 as select * from STUDENT;
--student2 ���̺��� ��1�� ������ȣ�� 301�� �л����� ����⵵�� ������ �л����� �����Ͽ���.
create table STUDENT2 as select * from STUDENT;

delete from STUDENT2
 where to_char(BIRTHDAY,'YYYY') in (select to_char(BIRTHDAY,'YYYY')
                                      from STUDENT2
                                     where deptno1 = 301);

--4. STUDENT2 ���̺��� �� �г⺰ �ִ�Ű�� ���� �л��� ã�� �����Ͽ���.
delete from STUDENT2
 where (grade, height) in (select grade, max(height)
                             from STUDENT2
                            group by grade);

delete from STUDENT2 s1
 where height = (select max(height)
                    from STUDENT2 s2
                   where s1.grade = s2.grade);

rollback;









