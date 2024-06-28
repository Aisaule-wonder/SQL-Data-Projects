/*
Topic: Subqueries (in the Select, From, and Where Statement)
*/
SELECT *
FROM EmployeeSalary

-- Subquery in Select
SELECT EmployeeID, Salary, (SELECT AVG(Salary) FROM EmployeeSalary) AS AvgAllSalary
FROM EmployeeSalary



--How to do it with Partition By

SELECT EmployeeID, Salary, AVG(Salary) over () AS AvgAllSalary
FROM EmployeeSalary

--Why GROUP BY does not work

SELECT EmployeeID, Salary, AVG(Salary) AS AvgAllSalary
FROM EmployeeSalary
Group By EmployeeID, Salary
Order By 1,2



--Subquery in From
Select a.EmployeeID, AvgAllSalary
FROM (SELECT EmployeeID, Salary, AVG(Salary) over () AS AvgAllSalary
		FROM EmployeeSalary) AS a

-- SUbQuery in Where

SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary
WHERE EmployeeID in (
		SELECT EmployeeID
		FROM EmployeeDemographics
		WHERE Age > 30)
