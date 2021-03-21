--1. professor ���̺��� �� ������ �̸��� ���̵� ����ϵ�,
--������ Ư����ȣ�� ������ ���·� ����Ͽ���.
select EMAIL,
       instr(EMAIL,'@') AS "@��ġ",
       substr(EMAIL,1,instr(EMAIL,'@') -1) AS "email id",
       translate(substr(EMAIL,1,instr(EMAIL,'@') -1),
                 'a_-*&^%$',
                 'a')
  from PROFESSOR;

--2. student ���̺��� ��ȭ��ȣ ������ ������ ���� �����ϼ���.  
--051)426-1700 => 051 426 1700
select TEL, translate(TEL,')-','  ')
  from STUDENT;
  
--3. EMP ���̺��� �̿��Ͽ� ����̸�, �Ի��� �� �޿��������� ǥ���մϴ�. 
--�޿��������� ������ �ٹ��� �ش�Ǵ� ù��° �������Դϴ�. 
--��¥�� "Sunday the Seventh of September, 1981" �������� ǥ���ϵ��� �Ѵ�. 
--�� �̸��� check�� �Ѵ�.
alter session set nls_date_language='american';
select ENAME, HIREDATE, 
       next_day(add_months(HIREDATE,6),2),
       to_char(next_day(add_months(HIREDATE,6),2),
               'Day "the" Ddspth "of" Month, YYYY')
  from emp;
  
--4. student ���̺��� jumin �÷��� ����Ͽ� ��������� ���� ������ �л��� ������ ����ϼ���.
--(19760205 ~ 19760924)
select NAME, JUMIN, to_date(substr(JUMIN,1,6),'RRMMDD')
  from STUDENT
 where to_date(substr(JUMIN,1,6),'RRMMDD') between to_date('19760205','YYYYMMDD') 
   and to_date('19760924','YYYYMMDD');
  
--5. emp ���̺��� �̿��Ͽ� ������� �ٹ��ϼ��� XX�� XX���� XX�� ���·� ����ϼ���.
select ENAME, HIREDATE,
       trunc(sysdate - hiredate) AS �ٹ��ϼ�,
       trunc((sysdate - hiredate)/365) AS �ټӳ��,
       trunc(months_between(sysdate, hiredate)) AS �ѱٹ�������,
       mod(trunc(months_between(sysdate, hiredate)),12) AS �ټӰ�����,
       sysdate,
       trunc(sysdate - add_months(hiredate, trunc(months_between(sysdate, hiredate))))
       AS "������ �ٹ��ϼ�"
  from emp;
  
--6. Student ���̺��� jumin �÷��� �����Ͽ� �л����� �̸��� �¾ ��, �׸��� �б⸦ ����϶�.
--�¾ ���� 01-03�� �� 1/4�б�, 04-06���� 2/4 �б�, 
--07-09 ���� 3/4 �б�, 10-12���� 4/4 �б�� ����϶� (decode,case���)
select name, jumin, 
       to_char(to_date(substr(jumin,1,6),'RRMMDD'),'Q') AS �б�,
       decode(to_char(to_date(substr(jumin,1,6),'RRMMDD'),'Q'),'1','1/4�б�',
                                                               '2','2/4�б�',
                                                               '3','3/4�б�',
                                                                   '4/4�б�') AS �б�1,
       case when to_number(substr(jumin,3,2)) between 1 and 3 then '1/4�б�'
            when to_number(substr(jumin,3,2)) between 4 and 6 then '2/4�б�'
            when to_number(substr(jumin,3,2)) between 7 and 9 then '3/4�б�'
                                                              else '4/4�б�'
        end AS �б�2                                                                                                      
  from STUDENT;
  
--7. EMP2 ���̺��� ����⵵(1960,1970,1980,1990)���� ��տ����� ���϶�.
select trunc(to_char(BIRTHDAY,'YYYY'),-1), round(avg(nvl(pay,0)))
  from emp2
 group by trunc(to_char(BIRTHDAY,'YYYY'),-1); 
 
--8. emp ���̺��� �λ�� ������ �������� 2000 �̸��� 'C',
--2000�̻� 4000�̸��� 'B', 4000�̻��� 'A' ����� �ο��Ͽ� �� ������ ���� ������ �Բ� ���
--**�λ�� ������ ���� ���� ��� 15% ��·� + ���ʽ�(comm)
select ename, sal, 
       case when sal*1.15 + nvl(comm,0) < 2000 then 'C'
            when sal*1.15 + nvl(comm,0) < 4000 then 'B'
                                               else 'A'
        end AS ���
  from emp;

--9. emp ���̺��� ����Ͽ� �������� ����� �Ʒ��� ���ؿ� �°� ǥ���ϼ���.
--2000�̸� 'C', 2000�̻� 3000���� 'B', 3000�ʰ� 'A'
select ename, sal, sign(sal-2000), sign(sal-3000),
       decode(sign(sal-2000),-1,'C',decode(sign(sal-3000),1,'A','B'))
  from emp;

--10. ����Ʈ�� �ۼ��ϰ��� �Ѵ�.
--emp ���̺��� �̿��Ͽ� �� �μ��� �������� ����ϵ� ������ ���� �������� �ۼ��Ͽ���.
--
--����Ʈ��	       10_������	 20_������	  30_�л���
----------------------------------------------------------
--�۴ٿ� ����Ʈ	        3	         5           6


select '�۴ٿ� ����Ʈ' AS ����Ʈ��, 
        sum(decode(DEPTNO,10,1,0)) AS "10_������",
        sum(decode(DEPTNO,20,1,0)) AS "20_������",
        sum(decode(DEPTNO,30,1,0)) AS "30_������"
  from emp;




