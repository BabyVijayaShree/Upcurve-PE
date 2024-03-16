-- 1. QUERY TO DISPLAY LASTNAME, DEPARTMENTNUMBER AND DEPARTMENTNAME FOR ALL EMPLOYEES --
SELECT EMP.LAST_NAME, DEP.DEPARTMENT_ID, DEP.DEPARTMENT_NAME 
FROM EMPLOYEES AS EMP JOIN DEPARTMENTS AS DEP 
ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID;

-- 2. QUERY TO LIST UNIQUE JOBS IN DEPARTMENT 30 ALONG WITH LOCATIONID --
SELECT DISTINCT EMP.JOB_ID, DEP.LOCATION_ID 
FROM EMPLOYEES AS EMP, DEPARTMENTS AS DEP
WHERE EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
AND EMP.DEPARTMENT_ID=30;

-- 3. QUERY TO DISPLAY LASTNAME, DEPARTMENTNAME, LOCATION_ID AND CITY OF ALL EMPLOYEES EARNING A COMMISSION --
SELECT EMP.LAST_NAME, DEP.DEPARTMENT_NAME, DEP.LOCATION_ID, LOC.CITY 
FROM EMPLOYEES AS EMP, DEPARTMENTS AS DEP, LOCATIONS AS LOC
WHERE EMP.DEPARTMENT_ID=DEP.DEPARTMENT_ID
AND DEP.LOCATION_ID=LOC.LOCATION_ID
AND EMP.COMMISSION_PCT IS NOT NULL;

-- 4. QUERY TO DISPLAY LASTNAME, DEPARTMENTNAME, LOCATIONID AND CITY OF EMPLOYEES HAVING 'A' IN THEIR LAST NAME --
SELECT EMP.LAST_NAME, DEP.DEPARTMENT_NAME, DEP.LOCATION_ID, LOC.CITY
FROM EMPLOYEES AS EMP, DEPARTMENTS AS DEP, LOCATIONS AS LOC
WHERE EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
AND DEP.LOCATION_ID = LOC.LOCATION_ID
AND LAST_NAME LIKE '%a%';

-- 5. QUERY TO DISPLAY LASTNAME, JOB, DEPARTMENTNUMBER AND DEPARTMENTNAME FOR EMPLOYEES WORKING IN TORONTO --
SELECT EMP.LAST_NAME, EMP.JOB_ID, EMP.DEPARTMENT_ID, DEP.DEPARTMENT_NAME
FROM EMPLOYEES AS EMP JOIN DEPARTMENTS AS DEP
ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
JOIN LOCATIONS AS LOC
ON DEP.LOCATION_ID = LOC.LOCATION_ID
WHERE LOC.CITY='Toronto';

-- 6. QUERY TO DISPLAY LASTNAME, EMPLOYEENUMBER, MANAGER'S LASTNAME AND MANAGERNUMBER AS EMPLOYEE, EMP#, MANAGER, MANAGER# --
SELECT EMP.LAST_NAME AS "Employee", EMP.EMPLOYEE_ID AS "Emp#", MAG.LAST_NAME AS "Manager", MAG.EMPLOYEE_ID AS "Manager#"
FROM EMPLOYEES AS EMP
JOIN EMPLOYEES AS MAG
ON EMP.MANAGER_ID = MAG.EMPLOYEE_ID;

-- 7. MODIFY THE ABOVE QUERY INCLUDE KING FOR EMPLOYEE WITH NO MANAGER AND ORDER THE RESULT BY EMPLOYEE NUMBER --
SELECT EMP.LAST_NAME AS "Employee", EMP.EMPLOYEE_ID AS "Emp#", MAG.LAST_NAME AS "Manager", MAG.EMPLOYEE_ID AS "Manager#"
FROM EMPLOYEES AS EMP
LEFT JOIN EMPLOYEES AS MAG
ON EMP.MANAGER_ID = MAG.EMPLOYEE_ID;

-- 8. QUERY TO DISPLAY LASTNAME, DEPARTMENTNUMBERS AND EMPLOYEES WORKING IN THE SAME DEPARTMENT AS A GIVEN EMPLOYEE --
SELECT EMP.DEPARTMENT_ID AS "Department", EMP.LAST_NAME AS "Employee", COL.LAST_NAME "Colleague"
FROM EMPLOYEES AS EMP
JOIN EMPLOYEES AS COL
ON EMP.DEPARTMENT_ID = COL.DEPARTMENT_ID
WHERE EMP.EMPLOYEE_ID <> COL.EMPLOYEE_ID
ORDER BY EMP.DEPARTMENT_ID, EMP.LAST_NAME, COL.LAST_NAME;

-- 9.QUERY THAT DISPLAYS NAME, JOB, DEPARTMENTNAME, SALARY AND GRADE FOR ALL EMPLOYEES --
SELECT EMP.LAST_NAME, EMP.JOB_ID, DEPT.DEPARTMENT_ID, EMP.SALARY, JB.GRADE_LEVEL
FROM EMPLOYEES AS EMP
JOIN DEPARTMENTS AS DEPT
ON EMP.DEPARTMENT_ID = DEPT.DEPARTMENT_ID
JOIN JOB_GRADES JB
ON EMP.SALARY BETWEEN JB.LOWEST_SAL AND JB.HIGHEST_SAL;

-- 10. QUERY TO DISPLAY THE NAME AND HIREDATE OF ALL EMPLOYEES HIRED AFTER EMPLOYEE "DAVIES" --
SELECT EMP.LAST_NAME, EMP.HIRE_DATE 
FROM EMPLOYEES AS EMP
WHERE EMP.HIRE_DATE > (SELECT EMP.HIRE_DATE FROM EMPLOYEES AS EMP WHERE LAST_NAME="Davies");

-- 11. QUERY TO DISPLAY NAMES, HIREDATES FOR ALL EMPLOYEES WHO WERE HIRED BEFORE THEIR MANAGERS --
-- ALONG WITH THEIR MANAGER'S NAMES AND HIREDATES. --
-- LABELLING AS "EMPLOYEE", "EMP HIRED", "MANAGER", "MANAGER HIRED: --
SELECT EMP.LAST_NAME AS "Employee", EMP.HIRE_DATE AS "Emp Hired", MANG.LAST_NAME AS "Manager", MANG.HIRE_DATE AS "Manager Hired"
FROM EMPLOYEES AS EMP 
JOIN EMPLOYEES AS MANG
ON EMP.MANAGER_ID = MANG.EMPLOYEE_ID 
WHERE EMP.HIRE_DATE < MANG.HIRE_DATE;

-- 12. QUERY TO DISPLAY HIGHEST, LOWEST, SUM, AVERAGE SALARY OF ALL EMPLOYEES.--
-- LABELLED AS "MAXIMUM", "MINIMUM", "Sum", "Average". --
SELECT MAX(SALARY) AS "Maximum", MIN(SALARY) AS "Minimum", SUM(SALARY) AS "Sum", AVG(SALARY) AS "Aerage"
FROM EMPLOYEES;

-- 13. MODIFY THE ABOVE QUERY TO DISPLAY THE SAME DATA FOR EACH JOB TYPE --
SELECT JOB_ID, MAX(SALARY) AS "Maximum", MIN(SALARY) AS "Minimum", SUM(SALARY) AS "Sum", AVG(SALARY) AS "Average"
FROM EMPLOYEES
GROUP BY JOB_ID;

-- 14. QUERY TO DISPLAY THE NUMBER OR PEOPLE WITH THE SAME JOB --
SELECT JOB_ID, COUNT(EMPLOYEE_ID) AS "Number of Employees"
FROM EMPLOYEES
GROUP BY JOB_ID;

-- 15. QUERY TO DISPLAY THE NUMBER OF MANAGERS WITHOUT LISTING THEM. --
-- LABEL THE COLUMN AS "NUMBER OF MANAGERS" --
SELECT COUNT(DISTINCT(MANAGER_ID)) AS "Number of Manager"
FROM EMPLOYEES;

-- 16. QUERY TO DISPLAY THE DIFFERENCE BETWEEN HIGHEST AND LOWEST SALARIES. --
-- LABEL THE COLUMN AS "Difference". --
SELECT (MAX(SALARY)-MIN(SALARY)) AS "Difference"
FROM EMPLOYEES;

-- 17.QUERY TO DISPLAY THE MANAGERNUMBER AND THE SALARY OF THE LOWEST PAID EMPLOYEE FOR THAT MANAGER. --
-- EXCLUDE ANYONE WHOSE MANAGER IS UNKNOWN --
-- EXCLUDE ANY GROUP WHERE THE MINIMUM SALARY IS LESS THAN $6000. --
-- SORT THE OUTPUT IN DESCENDING ORDER OF SALARY --
SELECT MANAGER_ID, MIN(SALARY)
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID
HAVING MIN(SALARY) > 6000
ORDER BY MIN(SALARY) DESC;

-- 18. QUERY TO DISPLAY EACH DEPARTMENTSNAME, LOCATION, NUMBEROFEMPLOYEES, AVERAGESALARY FOR ALL THE EMPLOYEES IN THAT DEPARTMENT.--
-- LABEL THE COLUMNS AS "Name", "LOCATION", "NO.OF.PEOPLE", "SALARY" --
-- ROUND THE AVERAGE TO TWO DECIMAL PLACES. --
SELECT DEPT.DEPARTMENT_NAME AS "Name", DEPT.LOCATION_ID AS "Location", COUNT(EMP.EMPLOYEE_ID) AS "No. of People",
ROUND(AVG(EMP.SALARY),2) AS "Salary"
FROM DEPARTMENTS AS DEPT
JOIN EMPLOYEES AS EMP
ON DEPT.DEPARTMENT_ID = EMP.DEPARTMENT_ID
GROUP BY EMP.DEPARTMENT_ID;

-- 19. QUERY TO DISPLAY LASTNAME, HIREDATE OF ANY EMPLOYEE IN THE DEPARTMENT AS THE EMPLOYEE "ZLOTKEY". --
-- EXCLUDE "ZLOTKEY". --
SELECT LAST_NAME, HIRE_DATE 
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE LAST_NAME="Zlotkey")
AND LAST_NAME != "Zlotkey";

-- 20. QUERY TO DISPLAY THE EMPLOYEENUMBER, LASTNAME OF ALL EMPLOYEES WHO EARN MORE THAN THE AVERAGE SALARY. --
-- SORT THE RESULT IN ASCENDING ORDER OF SALARY. --
SELECT EMPLOYEE_ID, LAST_NAME 
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES)
ORDER BY SALARY;

-- 21. QUERY TO DISPLAY THE EMPLOYEENUMBER, LASTNAME OF ALL EMPLOYEES--
-- EMPLOYEES WHO WORK IN A DEPARTMENT WITH ANY EMPLOYEE WHOSE LASTNAME CONTAINS A "U".--
SELECT EMPLOYEE_ID, LAST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE LAST_NAME LIKE "%u%");

-- 22.QUERY TO DISPLAY THE LASTNAME, DEPARTMENTNUMBER, JOBID OF EMPLOYEES WHOSE DEPARTMENT LOCATION_ID IS 1700 --
SELECT LAST_NAME, DEPARTMENT_ID
FROM EMPLOYEES 
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE LOCATION_ID = 1700);

-- 23. DISPLAY THE LASTNAME, SALARY OF EVERY EMPLOYEE WHO REPORTS TO "KING" --
SELECT LAST_NAME, SALARY
FROM EMPLOYEES
WHERE MANAGER_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE LAST_NAME ="King");

-- 24. QUERY TO DISPLAY THE DEPARTMENTNUMBER, LASTNAME, JOBID FOR EVERY EMPLOYEE IN THE "EXECUTIVE" DEPARTMENT. --
SELECT DEPARTMENT_ID, LAST_NAME, JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = "Executive");

-- 25. QUERY TO DISPLAY EMPLOYEENUMBER, LASTNAME, SALARY OF ALL EMPLOYEES WHO EARN MORE THAN THE AVERAGE SALARY--
-- AND WORK IN A DEPARTMENT WITH ANY EMPLOYEE WITH A "U" IN THEIR LASTNAME. -- 
SELECT EMPLOYEE_ID, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES)
AND DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE LAST_NAME LIKE "%u%");

-- 26.QUERY TO GET UNIQUE DEPARTMENT_ID FROM EMPLOYEES TABLE. --
SELECT DISTINCT(DEPARTMENT_ID)
FROM EMPLOYEES;

-- 27. QUERY TO GET ALL EMPLOYEES DETAILS FROM THE EMPLOYEE TABLE ORDER BY FIRSTNAME DESCENDING. --
SELECT * 
FROM EMPLOYEES
ORDER BY FIRST_NAME DESC;

-- 28. QUERY TO GET THE NAMES(FIRST_NAME, LAST_NAME), SALARY, PF OF ALL THE EMPLOYEES --
SELECT CONCAT(FIRST_NAME,' ',LAST_NAME) AS "Name", SALARY, (0.15*SALARY) AS "PF"
FROM EMPLOYEES;

-- 29. QUERY TO GET THE EMPLOYEEID, NAMES(FIRST_NAME, LAST_NAME), SALARY IN ASCENDING ORDER OF SALARY. --
SELECT EMPLOYEE_ID, CONCAT(FIRST_NAME,' ', LAST_NAME) AS "Name", SALARY
FROM EMPLOYEES 
ORDER BY SALARY;

-- 30.QUERY TO GET THE TOTAL SALARIES PAYABLE TO EMPLOYEES. --
SELECT SUM(SALARY)
FROM EMPLOYEES;

-- 31. QUERY TO GET MINIMUM AND MAXIMUM SALARY FROM EMPLOYEES TABLE--
SELECT MIN(SALARY) AS "Minimum", MAX(SALARY) AS "Maximum"
FROM EMPLOYEES;

-- 32. QUERY TO GET THE AVERAGE SALARY AND NUMBER OF EMPLOYEES IN THE EMPLOYEE TABLE. --
SELECT AVG(SALARY) AS "Average Salary",COUNT(EMPLOYEE_ID) AS "Number of Employees"
FROM EMPLOYEES;

-- 33. QUERY TO GET THE NUMBER OF EMPLOYEES WORKING WITH THE COMPANY. --
SELECT COUNT(EMPLOYEE_ID) AS "Number of Employees" 
FROM EMPLOYEES;

-- 34. QUERY TO GET THE NUMBER OF JOBS AVAILABLE IN THE EMPLOYEES TABLE--
SELECT JB.JOB_TITLE, COUNT(EMP.JOB_ID) AS "Number of Jobs"
FROM EMPLOYEES AS EMP
JOIN JOBS AS JB
ON EMP.JOB_ID = JB.JOB_ID
GROUP BY EMP.JOB_ID;

-- 35. QUERY TO GET ALL FIRSTNAMES IN UPPERCASE. --
SELECT UPPER(FIRST_NAME) AS "First Name"
FROM EMPLOYEES;

-- 36. QUERY TO GET FIRST 3 CHARACTERS OF FIRSTNAME FROM EMPLOYEES TABLE. --
SELECT SUBSTRING(FIRST_NAME, 1, 3) 
FROM EMPLOYEES;

-- 37. QUERY TO GET THE NAMES OF ALL EMPLOYEES. --
SELECT CONCAT(FIRST_NAME,' ',LAST_NAME) AS "Name"
FROM EMPLOYEES;

-- 38. QUERY TO GET FIRSTNAME BY REMOVING SPACES FROM BOTH SIDES. --
SELECT TRIM(FIRST_NAME) AS "First Name"
FROM EMPLOYEES;

-- 39. QUERY TO GET THE LENGTH OF THE FULL NAME OF EMPLOYEES. --
SELECT LENGTH(CONCAT(FIRST_NAME,' ',LAST_NAME)) AS "Length"
FROM EMPLOYEES;

-- 40. QUERY TO CHECK FOR NUMBERS IN FIRSTNAME. --
SELECT * 
FROM EMPLOYEES
WHERE FIRST_NAME REGEXP '[0-9]';

-- 41. QUERY TO SELECT FIRST 10 RECORDS FROM A TABLE.--
SELECT * 
FROM EMPLOYEES
LIMIT 10;

-- 42. QUERY TO GET MONTHLY SALARY OF EACH EMPLOYEE. --
-- ROUND THE SALARY TO 2 DECIMAL PLACES. --
SELECT ROUND((SALARY/12), 2) AS "Monthly Salary"
FROM EMPLOYEES;

-- 43. QUERY TO DISPLAY FIRSTNAME , LASTNAME, SALARY FOR ALL EMPLOYEES--
-- WHOSE SALARY IS NOT IN RANGE $10,000 AND $15,000.--
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY NOT BETWEEN 10000 AND 15000;

-- 44. QUERY TO DISPLAY THE NAME, DEPARTMENTID OF ALL EMPLOYEES IN 30 OR 100 DEPARTMENT IN ASCENDING ORDER. --
SELECT CONCAT(FIRST_NAME,' ',LAST_NAME) AS "Name", DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 30 OR
DEPARTMENT_ID = 100;

-- 45. QUERY TO DISPLAY NAME, SALARY FOR ALL EMPLOYEES--
-- WHOSE SALARY IS NOT IN RANGE 10,000 AND 15,000 --
-- AND ARE IN 30 OR 100 DEPARTMENT. --
SELECT CONCAT(FIRST_NAME,' ',LAST_NAME) AS "Name", SALARY
FROM EMPLOYEES
WHERE SALARY NOT BETWEEN 10000 AND 15000
AND (DEPARTMENT_ID = 30 OR DEPARTMENT_ID =100);

-- 46. QUERY TO DISPLAY THE NAME, HIREDATE FOR ALL EMPLOYEES WHO WERE HIRED IN 1987--
SELECT CONCAT(FIRST_NAME,' ',LAST_NAME) AS "Name", HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE LIKE '1987%';

-- 47. QUERY TO DISPLAY THE FIRSTNAME OF EMPLOYEES WHO HAVE BOTH "B" AND "C" IN THEIR FIRSTNAME. --
SELECT FIRST_NAME 
FROM EMPLOYEES
WHERE FIRST_NAME LIKE "%b%"
AND FIRST_NAME LIKE "%c%";

-- 48.QUERY TO DISPLAY THE LASTNAME, JOB, SALARY FOR ALL EMPLOYEES--
-- WHOSE JOB IS THAT OF A PROGRAMMER OR A SHIPPING CLERK--
-- AND WHOSE SALARY IS NOT EQUAL TO $4,500 OR $10,000 OR $15,000.--
SELECT LAST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE JOB_ID IN(SELECT JOB_ID FROM JOBS WHERE JOB_TITLE = "Programmer" OR JOB_TITLE = "Shipping Clerk")
AND SALARY NOT IN (4500, 10000, 15000);

-- 49.QUERY TO DISPLAY THE LASTNAME WHOSE NAME HAS EXACTLY 6 CHARACTERS. --
SELECT LAST_NAME
FROM EMPLOYEES
WHERE LAST_NAME LIKE '______';

-- 50. QUERY TO DISPLAY THE LASTNAME OF EMPLOYEES HAVING 'E' AS THE THIRD CHARACTER. --
SELECT LAST_NAME 
FROM EMPLOYEES
WHERE LAST_NAME LIKE '__e%';

-- 51. QUERY TO DISPLAY THE JOBS AVAILABLE IN EMPLOYEES TABLE. --
SELECT DISTINCT(JB.JOB_TITLE) AS "Available Jobs"
FROM EMPLOYEES AS EMP
JOIN JOBS AS JB
ON EMP.JOB_ID = JB.JOB_ID;

-- 52. QUERY TO GET THE NAMES(FIRST_NAME, LAST_NAME), SALARY, PF OF ALL THE EMPLOYEES --
SELECT CONCAT(FIRST_NAME,' ',LAST_NAME) AS "Name", SALARY, (0.15*SALARY) AS "PF"
FROM EMPLOYEES;

-- 53. QUERY TO SELECT ALL RECORDS FROM EMPLOYEES WHERE LASTNAME IN 'BLAKE', 'SCOTT', 'KING', 'FORD'. --
SELECT * 
FROM EMPLOYEES
WHERE LAST_NAME IN ('Blake', 'Scott', 'King', 'Ford');

-- 54. QUERY TO GET THE NUMBER OF JOBS AVAILABLE IN THE EMPLOYEES TABLE--
SELECT JB.JOB_TITLE, COUNT(EMP.JOB_ID) AS "Number of Jobs"
FROM EMPLOYEES AS EMP
JOIN JOBS AS JB
ON EMP.JOB_ID = JB.JOB_ID
GROUP BY EMP.JOB_ID;

-- 55. QUERY TO GET THE TOTAL SALARIES PAYABLE TO EMPLOYEES. --
SELECT SUM(SALARY) AS "Payable"
FROM EMPLOYEES;

-- 56. QUERY TO GET MINIMUM SALARY FROM EMPLOYEES TABLE.--
SELECT MIN(SALARY) AS "Minimum Salary"
FROM EMPLOYEES;

-- 57. QUERY TO GET MAXIMUM SALARY OF AN EMPLOYEE WORKING AS A PROGRAMMER. --
SELECT MAX(SALARY) AS "Maximum Salary"
FROM EMPLOYEES
WHERE JOB_ID IN(SELECT JOB_ID FROM JOBS WHERE JOB_TITLE="Programmer");

-- 58. QUERY TO GET AVERAGE SALARY OF EMPLOYEES WORKING IN 90 DEPARTMENT.--
SELECT AVG(SALARY) AS "Average Salary", COUNT(EMPLOYEE_ID) AS "Number of Employees"
FROM EMPLOYEES
WHERE DEPARTMENT_ID =90;

-- 59. QUERY TO GET HIGHEST, LOWEST, SUM, AVERAGE SALARY OF ALL EMPLOYESS. --
SELECT MAX(SALARY) AS "Highest Salary", MIN(SALARY) AS "Lowest Salary", SUM(SALARY) AS "Sum", AVG(SALARY) AS "Average"
FROM EMPLOYEES;

-- 60. QUERY TO GET THE NUMBER OF EMPLOYEES WITH THE SAME JOB. --
SELECT DISTINCT(JB.JOB_TITLE), COUNT(EMP.EMPLOYEE_ID) AS "Number of Employees"
FROM EMPLOYEES AS EMP
JOIN JOBS AS JB
ON EMP.JOB_ID = JB.JOB_ID
GROUP BY EMP.JOB_ID;

-- 61.QUERY TO GET THE DIFFERENCE BETWEEN THE HIGHEST AND LOWEST SALARIES.--
SELECT (MAX(SALARY)-MIN(SALARY)) AS "Difference"
FROM EMPLOYEES;

-- 62. QUERY TO DISPLAY THE MANAGERID AND LOWEST PAID EMPLOYEE SALARY UNDER HIM. --
SELECT MANAGER_ID, MIN(SALARY)
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID;

-- 63. QUERY TO GET THE DEPARTMENTID AND TOTAL PAYABLE SALARY IN THAT DEPARTMENT. --
SELECT DEPARTMENT_ID, SUM(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

-- 64. QUERY TO GET THE AVERAGE SALARY FOR EACH JOBID EXCLUDING PROGRAMMER.--
SELECT JOB_ID, AVG(SALARY) AS "Average"
FROM EMPLOYEES
WHERE JOB_ID NOT IN(SELECT JOB_ID FROM JOBS WHERE JOB_TITLE="Programmer")
GROUP BY JOB_ID;

-- 65. QUERY TO GET THE TOTAL SALARY, MAXIMUM, MINIMUM, AVERAGE SALARY OF EMPLOYEES JOB_ID WISE--
-- FOR DEPARTMENT_ID 90 ONLY --
SELECT SUM(SALARY) AS "Total Salary", MAX(SALARY) AS "Maximum Salary", 
MIN(SALARY) AS "Minimum Salary", AVG(SALARY) AS "Average Salary"
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 90
GROUP BY JOB_ID;

-- 66. QUERY TO GET JOB_ID, MAXIMUM SALARY FOR EMPLOYEES WHERE MAXIMUM SALARY >= 4000. --
SELECT JOB_ID, MAX(SALARY)
FROM EMPLOYEES 
GROUP BY JOB_ID
HAVING MAX(SALARY) >= 4000;

-- 67. QUERY TO GET THE AVERAGE SALARY FOR ALL DEPARTMENTS EMPLOYING MORE THAN 10 EMPLOYEES.--
SELECT  DEPARTMENT_ID, AVG(SALARY) AS "Average Salary", COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING COUNT(*)>10;

-- 68. QUERY TO GET THE NAME, SALARY OF EMPLOYEES HAVING SALARY GREATER THAN EMPLOYEE WITH LASTNAME = "BULL". --
SELECT CONCAT_WS(' ',FIRST_NAME, LAST_NAME) AS "Name", SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE LAST_NAME="BULL");

-- 69. QUERY TO FIND NAME OF EMPLOYEES WORKING IN IT DEPARTMENT. --
SELECT CONCAT_WS(' ',FIRST_NAME,LAST_NAME) AS "Name"
FROM EMPLOYEES 
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = "IT");

-- 70. QUERY TO FIND THE NAME OF EMPLOYEES WHO HAVE A MANAGER AND WORKED IN A USA BASED DEPARTMENT. --
SELECT CONCAT_WS(' ',FIRST_NAME, LAST_NAME) AS "Name" 
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL
AND DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM DEPARTMENTS 
WHERE LOCATION_ID IN (SELECT LOCATION_ID FROM LOCATIONS 
WHERE COUNTRY_ID = 'US'));

-- 71. QUERY TO FIND NAME OF THE EMPLOYEES WHO ARE MANAGERS. --
SELECT CONCAT_WS(' ',FIRST_NAME,LAST_NAME) AS "Name"
FROM EMPLOYEES 
WHERE EMPLOYEE_ID IN (SELECT MANAGER_ID 
FROM EMPLOYEES 
WHERE MANAGER_ID IS NOT NULL);

-- 72. QUERY FIND THE NAME, SALARY OF EMPLOYEES WHOSE SALARY IS GREATER THAN AVERAGE SALARY.--
SELECT CONCAT_WS(' ', FIRST_NAMEE, LAST_NAME) AS "Name", SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

-- 73. WRITE A QUERY TO FIND THE NAME (FIRST_NAME, LAST_NAME), AND SALARY OF THE EMPLOYEES WHOSE SALARY IS EQUAL TO THE MINIMUM SALARY OF THIER JOB GRADE
SELECT CONCAT_WS(' ', FIRST_NAME, LAST_NAME) AS "Name", SALARY
FROM EMPLOYEES
WHERE EMPLOYEES.SALARY = (SELECT MIN_SALARY FROM JOBS WHERE EMPLOYEE.JOB_ID = JOBS.JOB_ID)

-- 74. 

-- 75.

-- 76.

-- 77. 

-- 78.

-- 79. 

-- 80.

-- 81. 

-- 82.

-- 83.

-- 84.

-- 85.

-- 86.

-- 87.

-- 88.

-- 89.

-- 90.

-- 91.
