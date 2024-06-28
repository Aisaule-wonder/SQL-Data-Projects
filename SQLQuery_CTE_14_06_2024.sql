/*
Topic^ CTEs
*/

WITH CTE_Employee AS
(SELECT FirstName, LastName, Gender, Salary,
	COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender,
	AVG(Salary) OVER (PARTITION BY Gender) AS AvgSalary
FROM SQLTutorial.dbo.EmployeeDemographics AS emp
JOIN
SQLTutorial.dbo.EmployeeSalary AS Sal
	ON emp.EmployeeID = Sal.EmployeeID
WHERE Salary > '45000'
)
SELECT *
FROM CTE_Employee