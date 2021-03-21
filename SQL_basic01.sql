--[ �ǽ����� ]

--1. DEPT ���̺��� ����Ͽ� deptno �� �μ�# , dname �μ��� , loc �� ��ġ�� ������ �����Ͽ� 
--����ϼ���.
select DEPTNO AS �μ�#, DNAME �μ���, LOC ��ġ 
  from dept;

--2. EMP ���̺��� �μ���(deptno)�� ����ϴ� ����(job)�� �ϳ��� ��µǵ��� �Ͽ���.
select distinct deptno, job
  from emp;

--3. �л� ���̺�(student)�� ����Ͽ� ��� �л�����
--�������� �� Ű�� 180 cm, �����Դ� 55 kg �Դϴ١� �� ���� �������� ���
--�ǵ��� �ϰ� , Į���̸��� ���л��� Ű�� �����ԡ���� �������� ����� ������.
select NAME||'�� Ű�� '||HEIGHT||' cm, �����Դ� '||WEIGHT||' kg �Դϴ�' 
       AS "�л��� Ű�� ������"
  from STUDENT;

--4. ���� ���̺�(professor)�� ����Ͽ� ������ �̸��� ������ �Ʒ��� ���� 
--ȫ�浿 (����) , ȫ�浿 �������� �̷��� �������� ����غ�����. 
--��µ� �÷� �̸��� ������ �Դϴ�.
select NAME||' ('||POSITION||') , '||NAME||' '''||POSITION||''''
  from PROFESSOR;
  
--5. EMP ���̺��� �޿�(sal)�� 3000 �̻��� ����� �����ȣ(empno), �̸�(ename), ����(job), 
--�޿�(sal)�� ����϶�.
select empno, ename, job, sal 
  from emp
 where sal >= 3000;
 
--6. EMP ���̺��� �������� Manager�� ����� ������ �����ȣ, ����, ����, �޿�, 
--�μ���ȣ(deptno)�� ����϶�.
select empno, ename, job, sal, deptno
  from emp
 where initcap(job) = 'Manager';

select empno, ename, job, sal, deptno
  from emp
 where job = 'MANAGER';
 
--7. EMP ���̺��� �޿��� 1300���� 1700 ������ ����� ����, ����, �޿�, �μ���ȣ(deptno)�� 
--����Ͽ���.
select ename, job, sal, deptno 
  from emp
 where sal between 1300 and 1700;
 
--8. EMP���̺��� �����ȣ(empno)�� 7902, 7788, 7566�� ����� �����ȣ, ����, ����, �޿�, 
--�Ի�����(hiredate)�� ����Ͽ���.
select empno, ename, job, sal, hiredate
  from emp
 where empno in (7902, 7788, 7566);
 
--9. EMP ���̺��� �޿��� 1100 �̻��̰�, JOB�� Manager�� ����� �����ȣ, ����, ������,
--�޿�, �Ի�����, �μ���ȣ�� ����Ͽ���.
select empno, ename, job, sal, hiredate, deptno
  from emp
 where sal >= 1100
   and job = 'MANAGER';


--10. emp ���̺��� Ŀ�̼�(comm)�� ���� �ʴ� ����� �޿��� 10% �λ��Ͽ� ǥ���ϵ�, 
--������ �������� ����Ͽ���.
--The salary of SMITH after a 10% raise is 880
select 'The salary of '||ENAME||' after a 10% raise is '||SAL*1.1 
  from EMP
 where comm is null
    or comm = 0;
 
--11. student ���̺��� ������ȣ�� ������ ���� ����Ͽ���.
select name, tel, substr(tel,1,3),
       instr(TEL,')') AS ")�� ��ġ",
       substr(tel,
                1,
              instr(TEL,')') - 1) AS ������ȣ,
       instr(TEL,'-') AS "-�� ��ġ",
       instr(TEL,'-') - instr(TEL,')') - 1 AS ���ⰳ��,
       substr(tel, 
              instr(TEL,')') + 1,
              instr(TEL,'-') - instr(TEL,')') - 1) AS ����       
  from STUDENT;

--12. STUDENT ���̺��� ����Ͽ� �ֹι�ȣ, ������� ������ ����Ͽ� �� �л��� �¾ ���� 
--������ ����ϼ���.
select to_date('751023','RRMMDD') from dual;

select JUMIN, substr(JUMIN,1,6), 
       to_date(substr(JUMIN,1,6),'RRMMDD'),
       to_char(to_date(substr(JUMIN,1,6),'RRMMDD'), 'DAY'), 
       to_char(BIRTHDAY, 'DAY')
  from STUDENT;

--13. student ���̺��� ���� '��'�� �л��� �й�, �̸�, �г��� ����Ͽ���.
select studno, name, grade
  from STUDENT
 where substr(name,1,1) >= '��'
   and substr(name,1,1) < '��'
 ;

--14. EMPLOYEES ���̺��� ��Ҹ� �������� �ʰ� email�� last_name�� ���ԵǾ� ���� ���� 
--����� EMPLOYEE_ID, FIRST_NAME, EMAIL�� ����Ͽ���.
--(EMPLOYEES ���̺��� hr �������� ��ȸ ����)
--1) instr ���
select instr('DGRANT',upper('Grant')) from dual;

select * 
  from EMPLOYEES
 where instr(EMAIL,upper(LAST_NAME)) = 0 ;

--2) like ������ ���
select *
  from EMPLOYEES
 where EMAIL not like '%'||upper(LAST_NAME)||'%';