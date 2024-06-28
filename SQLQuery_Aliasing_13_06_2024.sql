/*
Topic: Aliasing
*/

SELECT * 
FROM [SQLTutorial].[dbo].[EmployeeDemographics]

SELECT FirstName AS Fname
FROM [SQLTutorial].[dbo].[EmployeeDemographics]

SELECT FirstName + ' ' + LastName AS FullName
FROM [SQLTutorial].[dbo].[EmployeeDemographics]

SELECT AVG(Age) AS AvgAge
FROM [SQLTutorial].[dbo].[EmployeeDemographics]

SELECT Demo.EmployeeID, Sal.Salary
FROM [SQLTutorial].[dbo].[EmployeeDemographics] AS Demo
JOIN 
[SQLTutorial].[dbo].[EmployeeSalary] AS Sal
	ON Demo.EmployeeID = SAL.EmployeeID

/* Not recommended to use (a,b,c) as Alias
SELECT a.EmployeeID, a.FirstName, a.LastName, b.JobTitle, c.Age
FROM [SQLTutorial].[dbo].[EmployeeDemographics] AS a
LEFT JOIN 
[SQLTutorial].[dbo].[EmployeeSalary] AS b
	ON a.EmployeeID = b.EmployeeID
LEFT JOIN [SQLTutorial].[dbo].[WareHouseEmployeeDemographics] AS c
	ON a.EmployeeID = c.EmployeeID
*/

SELECT Demo.EmployeeID, Demo.FirstName, Demo.LastName, Sal.JobTitle, Sal.Salary, Ware.Age
FROM [SQLTutorial].[dbo].[EmployeeDemographics] AS Demo
LEFT JOIN 
[SQLTutorial].[dbo].[EmployeeSalary] AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID
LEFT JOIN [SQLTutorial].[dbo].[WareHouseEmployeeDemographics] AS Ware
	ON Demo.EmployeeID = Ware.EmployeeID