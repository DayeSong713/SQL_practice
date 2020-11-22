/*CREATE database SCOTT;

USE SCOTT;


CREATE TABLE IF NOT EXISTS `BONUS` (
  `ENAME` varchar(10) DEFAULT NULL,
  `JOB` varchar(9) DEFAULT NULL,
  `SAL` double DEFAULT NULL,
  `COMM` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `DEPT` (
  `DEPTNO` int(11) NOT NULL,
  `DNAME` varchar(14) DEFAULT NULL,
  `LOC` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`DEPTNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



INSERT INTO `DEPT` (`DEPTNO`, `DNAME`, `LOC`) VALUES
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');


CREATE TABLE IF NOT EXISTS `EMP` (
  `EMPNO` int(11) NOT NULL,
  `ENAME` varchar(10) DEFAULT NULL,
  `JOB` varchar(9) DEFAULT NULL,
  `MGR` int(11) DEFAULT NULL,
  `HIREDATE` datetime DEFAULT NULL,
  `SAL` double DEFAULT NULL,
  `COMM` double DEFAULT NULL,
  `DEPTNO` int(11) DEFAULT NULL,
  PRIMARY KEY (`EMPNO`),
  KEY `PK_EMP` (`DEPTNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `EMP` (`EMPNO`, `ENAME`, `JOB`, `MGR`, `HIREDATE`, `SAL`, `COMM`, `DEPTNO`) VALUES
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17 00:00:00', 800, NULL, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20 00:00:00', 1600, 300, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22 00:00:00', 1250, 500, 30),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02 00:00:00', 2975, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28 00:00:00', 1250, 1400, 30),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01 00:00:00', 2850, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09 00:00:00', 2450, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1987-04-19 00:00:00', 3000, NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17 00:00:00', 5000, NULL, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08 00:00:00', 1500, 0, 30),
(7876, 'ADAMS', 'CLERK', 7788, '1987-05-23 00:00:00', 1100, NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, '1981-12-03 00:00:00', 950, NULL, 30),
(7902, 'FORD', 'ANALYST', 7566, '1981-12-03 00:00:00', 3000, NULL, 20),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23 00:00:00', 1300, NULL, 10);

CREATE TABLE IF NOT EXISTS `SALGRADE` (
  `GRADE` double DEFAULT NULL,
  `LOSAL` double DEFAULT NULL,
  `HISAL` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `SALGRADE` (`GRADE`, `LOSAL`, `HISAL`) VALUES
(1, 700, 1200),
(2, 1201, 1400),
(3, 1401, 2000),
(4, 2001, 3000),
(5, 3001, 9999);


ALTER TABLE `EMP`
  ADD CONSTRAINT `PK_EMP` FOREIGN KEY (`DEPTNO`) REFERENCES `DEPT` (`DEPTNO`) ON DELETE SET NULL ON UPDATE CASCADE;
  
  */
 /* 
  
SELECT DISTINCT deptno FROM emp;

SELECT sal+1000 FROM emp;


SELECT
     *
  FROM emp
  WHERE sal>=3000;
  
  SELECT empno, sal*12 +IFNULL(comm,0) AS annsal FROM emp; 
  
  
SELECT * FROM emp 
WHERE deptno = 10;  

SELECT * FROM emp WHERE ename >= 'SMITH';

SELECT * FROM emp WHERE hiredate <= '1981/05/05';  

SELECT * FROM emp WHERE deptno=10 AND job = 'manager';

SELECT * FROM emp WHERE deptno =10 OR job = 'manager';  

SELECT * FROM emp WHERE NOT deptno = 10;

SELECT * FROM emp WHERE sal>= 2000 AND sal<=3000;

SELECT * FROM emp WHERE sal BETWEEN 2000 AND 3000;

SELECT * FROM emp WHERE comm not IN(300,500,1400);

SELECT * FROM emp WHERE ename LIKE 'F%';

SELECT * FROM emp WHERE ename LIKE '_O%';

SELECT * FROM emp WHERE ename LIKE '%A%';

SELECT * FROM emp WHERE ename LIKE '%N';

SELECT * FROM emp WHERE comm IS not NULL;

SELECT * FROM emp order BY sal DESC, ename ASC;

SELECT * FROM emp ORDER BY sal DESC, ename ASC LIMIT 0,5;


SELECT if(100>200, '참', '거짓');
SELECT NULLIF(100,100), NULLIF(100,200);


SELECT case 10
	when 1 THeN 'one'
	when 2 THeN 'two'
	when 10 THeN 'ten'
	ELSE '모름'
	END;
	
	SELECT ASCII ('a');
	SELECT CHAR(65);
	
	
	SELECT BIT_LENGTH('abc');
	
	SELECT CHAR_LENGTH('abc');
	SELECT LENGTH('abc');
	
	SELECT BIT_LENGTH('가나다');
	SELECT CHAR_LENGTH('가나다');
	SELECT LENGTH('가나다');
	


SELECT CONCAT('i am a ', 'person');


SELECT IFNULL(NULL, '널이군요'), IFNULL(100,'널이군요');

SELECT NULLIF(100,100), NULLIF(100,200);

SELECT case 100
when 1 then '1'
when 2 then '2'
when 10 then '10'
ELSE 'not'
END;


SELECT CONCAT_WS('/','2020','01','01');

SELECT ELT(2, 'one', 'two', 'three');

SELECT ELT(3, 'one', 'two', 'three');

SELECT FIELD('two','one','two','three');

SELECT FIND_IN_SET('three','one,tow,three');

SELECT INSTR('onetwothree','tw');

SELECT LOCATE('two','onetwothree');

SELECT AVG(sal) FROM emp;

SELECT SUM(sal) FROM emp;

SELECT COUNT(empno) FROM emp;

SELECT MAX(sal)FROM emp;

SELECT MIN(sal) FROM emp;

SELECT STDDEV(sal) FROM emp;

SELECT VARIANCE(sal) FROM emp;

SELECT SUM(comm) FROM emp;
SELECT AVG(comm) FROM emp;
SELECT COUNT(*) FROM emp;

SELECT COUNT(job) FROM emp;

SELECT COUNT(DISTINCT job) FROM emp;


SELECT MAX(sal), min(sal) FROM emp;

SELECT deptno, MAX(sal), MIN(sal) FROM emp GROUP BY deptno;

SELECT deptno, COUNT(*) FROM emp GROUP BY deptno;

SELECT COUNT(*) FROM emp WHERE sal>=2000;

SELECT deptno, AVG(sal) from emp GROUP BY deptno
having AVG(sal)>=2000;


SELECT deptno, MAX(sal), MIN(sal)
FROM emp
GROUP BY deptno
HAVING MAX(sal) >2900;


SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY deptno, job WITH ROLLUP;*/

USE scott;
SELECT * FROM dept;


SELECT * FROM emp CROSS JOIN dept;

SELECT * FROM emp INNER JOIN dept
ON emp.deptno = dept.deptno;

SELECT ename, loc from emp INNER JOIN dept
ON emp.deptno = dept.deptno
WHERE ename = 'Ford';

SELECT ename FROM emp INNER JOIN dept
USING(deptno)
WHERE ename = 'ford';

SELECT * FROM emp NATURAL JOIN dept WHERE ename = 'ford';

SELECT * FROM emp;

SELECT * FROM emp AS e1 INNER join emp AS m
ON e1.mgr = m.empno;

SELECT e.ename, m.ename FROM emp AS e inner JOIN emp AS m
ON e.mgr = m.empno;

SELECT e.ename AS emp, m.ename AS mgr FROM emp AS e left outer JOIN emp AS m
ON e.mgr = m.empno;



SELECT dname
FROM dept
WHERE deptno = (SELECT deptno
						FROM emp
						WHERE ename = 'ford');
						


SELECT deptno
						FROM emp
						WHERE ename = 'ford';
						
						
						
SELECT ename, deptno
FROM emp
WHERE deptno = (SELECT deptno FROM emp WHERE ename ='KING');


SELECT ename, sal
FROM emp
WHERE sal< (SELECT sal FROM emp WHERE ename='FORD');

SELECT ename, sal
FROM emp
WHERE sal<(SELECT AVG(sal) FROM emp);


SELECT dname FROM dept INNER JOIN emp
USING(deptno)
WHERE ename = 'FORD';


SELECT ename, sal, deptno
FROM emp
WHERE deptno IN (
SELECT DISTINCT deptno
FROM emp WHERE sal>=3000);



SELECT DISTINCT deptno
FROM emp WHERE sal>=3000;


SELECT sal FROM emp WHERE deptno = 30;


SELECT ename, sal
FROM emp
WHERE sal> any(SELECT sal FROM emp WHERE deptno=30);


SELECT sal FROM emp WHERE deptno=30;


SELECT e.empno, e.ename,e.sal,e.mgr FROM emp AS e INNER JOIN emp AS m
ON e.mgr = m.empno;






SELECT ename, sal
FROM emp
WHERE sal>
all(SELECT sal FROM emp
WHERE mgr = (SELECT empno FROM emp WHERE ename = 'ford'));



SELECT ename, sal 
FROM emp
WHERE sal > ALL ;


SELECT * FROM dept;

DESC emp;

SELECT ename, sal, hiredate 
FROM emp;

SELECT ename, sal*12 +comm
FROM emp;

SELECT ename, comm, sal*12+comm,
nvl(comm,0), sal*12 + nvl(comm,0)  "연봉"
FROM emp; 

SELECT ename ||'is a'||job
FROM emp;

SELECT DISTINCT job 
FROM emp;
