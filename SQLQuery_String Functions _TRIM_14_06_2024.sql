/*
Topic: String Functions - TRIM, LTRIM, RTEIM, Replace, Sustring, Upper, Lower
*/

--Drop Table EmployeeErrors;

CREATE TABLE EmployeeErrors
(
EmployeeID varchar(50),
FirstName varchar(50),
LastName varchar(50)
)

INSERT INTO EmployeeErrors VALUES
('1001 ', 'Jimbo', 'Halbert'),
(' 1002', 'Pamela', 'Beasely'),
('1005', 'T0by', 'Flenderson - Fired')

SELECT *
FROM EmployeeErrors

--Using TRIM, LRIM, RTRIM

SELECT EmployeeID, TRIM(EmployeeID) AS IDTRIM
FROM EmployeeErrors

SELECT EmployeeID, LTRIM(EmployeeID) AS IDTRIM
FROM EmployeeErrors

SELECT EmployeeID, RTRIM(EmployeeID) AS IDTRIM
FROM EmployeeErrors

--Using Replace
SELECT *
FROM EmployeeErrors

SELECT LastName, REPLACE(LastName, '- Fired','') AS LastNameFixed
FROM EmployeeErrors

--Usinf Substring

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics

INSERT INTO SQLTutorial.dbo.EmployeeDemographics VALUES
('1005', 'T0by', 'Flenderson', 33, 'Male')

SELECT SUBSTRING(FirstName,3,3)
FROM EmployeeErrors

SELECT err.FirstName, dem.FirstName
FROM EmployeeErrors Err
JOIN
SQLTutorial.dbo.EmployeeDemographics dem
	ON err.FirstName = dem.FirstName

SELECT err.FirstName, SUBSTRING(err.FirstName,1,3), dem.FirstName, SUBSTRING(dem.FirstName,1,3)
FROM EmployeeErrors Err
JOIN
SQLTutorial.dbo.EmployeeDemographics dem
	ON SUBSTRING(err.FirstName,1,3) = SUBSTRING(dem.FirstName,1,3)

-- Gender
-- LastName
-- AGE
-- DOB

-- Using UPPER and Lower

SELECT FirstName, LOWER(FirstName)
FROM EmployeeErrors

SELECT FirstName, UPPER(FirstName)
FROM EmployeeErrors

SELECT *
FROM EmployeeErrors