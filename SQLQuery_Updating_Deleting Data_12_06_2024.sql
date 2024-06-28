/*
Topic: Updating/Deleting Data
*/
SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics

UPDATE SQLTutorial.dbo.EmployeeDemographics
SET Age = 31, Gender = 'Female'
WHERE EmployeeID = 1012 AND FirstName = 'Holly' AND LastName = 'Flax'

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
WHERE EmployeeID = 1005

DELETE FROM SQLTutorial.dbo.EmployeeDemographics
WHERE EmployeeID = 1005