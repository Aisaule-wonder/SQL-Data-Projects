/*
Topic: Partition By
*/
SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics

SELECT *
FROM SQLTutorial.dbo.EmployeeSalary

SELECT Dem.FirstName, Dem.LastName, Dem.Gender, Sal.Salary
FROM SQLTutorial.dbo.EmployeeDemographics AS Dem
JOIN
SQLTutorial.dbo.EmployeeSalary AS Sal
	ON Dem.EmployeeID = Sal.EmployeeID

SELECT FirstName, LastName, Gender, Salary,
	COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
FROM SQLTutorial.dbo.EmployeeDemographics AS Dem
JOIN
SQLTutorial.dbo.EmployeeSalary AS Sal
	ON Dem.EmployeeID = Sal.EmployeeID

SELECT FirstName, LastName, Gender, Salary, COUNT(Gender)
FROM SQLTutorial.dbo.EmployeeDemographics AS Dem
JOIN
SQLTutorial.dbo.EmployeeSalary AS Sal
	ON Dem.EmployeeID = Sal.EmployeeID
GROUP BY FirstName, LastName, Gender, Salary

SELECT Gender, COUNT(Gender)
FROM SQLTutorial.dbo.EmployeeDemographics AS Dem
JOIN
SQLTutorial.dbo.EmployeeSalary AS Sal
	ON Dem.EmployeeID = Sal.EmployeeID
GROUP BY Gender