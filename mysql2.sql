SELECT * FROM emp
WHERE hiredate <='1982/01/01';

SELECT * FROM emp
WHERE deptno!=10;

SELECT * FROM emp
WHERE not deptno=10;


SELECT empno, sal
FROM emp
WHERE empno = 7521 or empno = '7654' OR empno='7844';

SELECT * 
FROM emp
WHERE sal BETWEEN 2000 AND 3000;

SELECT * 
FROM emp
WHERE sal>3000 OR sal<2000;

SELECT * 
FROM emp
WHERE sal NOT BETWEEN 2000 AND 3000;

SELECT *
FROM emp
WHERE hiredate not BETWEEN '1987/01/01' AND '1987/12/31';

SELECT * 
FROM emp
WHERE comm=300 OR comm=500 OR comm=1400;

SELECT *
FROM emp
WHERE comm IN(300,500,1400);

SELECT *
FROM emp
WHERE empno IN(7521,7654,7844);

SELECT *
FROM emp
WHERE comm<>300 AND comm<>500 AND comm<>1400;

SELECT *
FROM emp
WHERE comm NOT IN (300,500);

SELECT *
FROM emp
WHERE empno<>7521 AND empno<>7564 AND empno<>7844;

SELECT *
FROM emp
WHERE empno NOT IN (7521,7564,7844);

SELECT *
FROM emp
WHERE NOT empno=7521 AND NOT empno=7564;

SELECT *
FROM emp
WHERE ename LIKE 'F%';

SELECT *
FROM emp
WHERE ename LIKE 'J%';

SELECT *
FROM emp
WHERE ename LIKE '%A%';

SELECT *
FROM emp
WHERE ename LIKE '%N';

SELECT *
FROM emp
WHERE ename LIKE '_A%';

SELECT *
FROM emp
WHERE ename LIKE '__A%';

SELECT *
FROM emp
WHERE ename NOT LIKE '%A%';

SELECT *
FROM emp
WHERE comm=NULL;

SELECT *
FROM emp
WHERE comm IS not NULL;

SELECT *
FROM emp
WHERE mgr IS NULL;

SELECT *
FROM emp
ORDER BY sal;

SELECT *
FROM emp
ORDER BY sal DESC;

SELECT empno, ename, job, hiredate
FROM emp
ORDER BY hiredate;

SELECT *
FROM emp
ORDER BY sal DESC;

SELECT empno, ename
FROM emp
ORDER BY empno DESC;

SELECT *
FROM emp
ORDER BY ename;

SELECT *
FROM emp
ORDER BY sal DESC, ename ASC
LIMIT 0,5;

SELECT empno, hiredate, ename, sal
FROM emp
ORDER BY deptno, hiredate DESC;


SELECT -10, ABS(-10)
FROM DUAL;

SELECT 34.5678, FLOOR(34.5678)
FROM DUAL;

SELECT 34.5678, ROUND(34.5678)
FROM DUAL;

select 34.5678, ROUND(34.5678,2)
FROM DUAL;

SELECT 34.5678, ROUND(34.5678, -1)
FROM DUAL;

SELECT Truncate(34.5678,3)
FROM DUAL;

SELECT MOD (27,2),MOD(27,5), MOD(27,7)
FROM DUAL;

SELECT *
FROM emp
WHERE MOD(empno,2) =1;

SELECT empno, ename, job
from emp
WHERE job = 'manager';

SELECT LENGTHb('Oracle'), LENGTHb('오라클')
FROM DUAL;

SELECT SUBSTR('Welcome to Oracle',4,3)
FROM DUAL;

SELECT SUBSTR('Welcome to Oracle',-5,3)
FROM DUAL;

SELECT SUBSTR(hiredate,1,4)"년도", SUBSTR(hiredate,6,2) AS MONTH, hiredate
FROM emp;

SELECT *
FROM emp
WHERE SUBSTR(hiredate,6,2)='09';

SELECT * FROM emp
WHERE SUBSTR(hiredate,1,4)='1987';

SELECT *
FROM emp
WHERE SUBSTR(ename,-1,1) = 'E';

SELECT INSTR('Welcome to Oracle''O')
FROM DUAL;

SELECT RPAD('Oracle',10,'#')
FROM DUAL;

SELECT LTRIM('  Oracle  '), RTRIM('  Oracle  '), TRIM('  Oracle  '), ('  Oracle  ')
FROM DUAL;

SELECT TRIM('a' FROM 'aaaoracle')
FROM DUAL;

SELECT curDATE()
FROM DUAL;

SELECT NOW();

SELECT CURTIME();

SELECT hiredate,ROUND( hiredate, 'month')
FROM emp;

SELECT ename, hiredate, add_month(hiredate,6)
FROM emp;

SELECT STR_TO_DATE('18,05,2020','%d,%m,%Y');

SELECT ename, sal, comm, sal*12+comm, nvl(comm,0), sal*12+nvl(comm,0)
FROM emp
ORDER BY job;

SELECT empno, ename,nvl(mgr, 'CEO') AS manager
FROM emp 
WHERE mgr IS NULL;

SELECT ename, deptno,
case when deptno=10 then 'accounting' 
	  when deptno=20 then 'Research'
	  when deptno=30 then 'sales'
	  ELSE' operations' END AS dname
FROM emp;

SELECT empno, ename, job, sal,
case when job = 'analyst' then sal*1.05
	  when job = 'salesman' then sal*1.1
	  when job = 'manager' then sal*1.15
	  when job = 'clerk' then sal*1.2
	  ELSE sal
	  END AS upsal
FROM emp;	   

