SELECT SUM(sal)
FROM emp;

SELECT SUM(comm)
FROM emp;

SELECT AVG(sal)
FROM emp;

SELECT MAX(sal), MIN(sal)
FROM emp;

SELECT ename, MAX(sal)
FROM emp;

SELECT MAX(hiredate), MIN(hiredate)
FROM emp;

SELECT COUNT(comm)
FROM emp;

SELECT COUNT(*), COUNT(comm)
FROM emp;

SELECT COUNT(comm)
FROM emp
WHERE deptno=10;

SELECT COUNT(distinct job) 업무수
FROM emp;

SELECT deptno
FROM emp
GROUP BY deptno;

SELECT deptno, AVG(sal)
FROM emp
GROUP BY deptno;

SELECT deptno, MAX(sal), MIN(sal)
FROM emp
GROUP by deptno;

SELECT deptno, COUNT(*), COUNT(comm)
FROM emp
GROUP BY deptno;

SELECT deptno, AVG(sal)
FROM emp
GROUP BY deptno
HAVING AVG(sal)>=2000;

SELECT deptno, MAX(sal), MIN(sal)
FROM emp
GROUP BY deptno
HAVING MAX(sal)>2900;

SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY deptno, job WITH ROLLUP;





