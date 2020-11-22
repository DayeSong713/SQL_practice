SELECT *
FROM emp, dept;

SELECT ename, dname
FROM emp, dept
WHERE emp.deptno=dept.DEPTNO AND ename='scott';

SELECT ename, dname, d.deptno
FROM emp, dept d
WHERE emp.deptno=d.deptno
AND ename='scott';

SELECT e.ename, d.dname, e.deptno,d.deptno
FROM emp e, dept d
WHERE e.deptno=d.deptno
AND e.ENAME='scott';

SELECT ename, sal
FROM emp e, dept d
WHERE e.deptno=d.deptno
AND d.LOC='NEW YORK';

SELECT ename, hiredate
FROM emp e, dept d
WHERE e.deptno=d.deptno
AND d.dname='accounting';


SELECT ename, dname
FROM emp e, dept d
WHERE d.deptno=e.deptno
AND e.JOB='manager';

SELECT * FROM salgrade;

SELECT ename, sal, grade
FROM emp, salgrade
WHERE sal BETWEEN losal AND hisal
ORDER BY sal;

SELECT e.ENAME, e.JOB
FROM emp e, emp m
WHERE e.MGR=m.EMPNO
AND m.ENAME='king';

SELECT e1.ENAME, e2.ename
FROM emp e1, emp e2
WHERE e1.ename='scott'
AND e1.DEPTNO=e2.deptno
AND e2.ename!='scott';

SELECT e.ENAME AS emp, m.ename AS mgr
FROM emp e
left outer join emp m
ON E.MGR=m.empno;


