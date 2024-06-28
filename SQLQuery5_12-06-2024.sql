/*
Topic: Union, Union All
*/
CREATE TABLE WareHouseemployeeDemographics
(EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50)
)


INSERT INTO WareHouseemployeeDemographics VALUES 
(1013,'Darryl', 'Philbin',NULL, 'Male'),
(1050,'Roy','Anderson',31,'Male'),
(1051,'Hidetoshi','Hasagawa',40,'Male'),
(1052,'Val','Johnson',31,'Female')

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics

SELECT *
FROM SQLTutorial.dbo.WareHouseemployeeDemographics

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
FULL Outer Join SQLTutorial.dbo.WareHouseemployeeDemographics
	ON EmployeeDemographics.EmployeeID = WareHouseemployeeDemographics.EmployeeID

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
UNION
SELECT *
FROM SQLTutorial.dbo.WareHouseemployeeDemographics

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
UNION ALL
SELECT *
FROM SQLTutorial.dbo.WareHouseemployeeDemographics
ORDER BY EmployeeID

/* Not Correct SQL statement
SELECT EmployeeID, FirstName, Age
FROM SQLTutorial.dbo.EmployeeDemographics
UNION
SELECT EmployeeID, JobTitle, Salary
FROM SQLTutorial.dbo.EmployeeSalary
ORDER BY EmployeeID
*/