SELECT TOP (1000) [EmployeeID]
      ,[FirstName]
      ,[LastName]
      ,[Age]
      ,[Gender]
  FROM [SQLTutorial].[dbo].[EmployeeDemographics]

INSERT INTO EmployeeDemographics VALUES 
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly', 'Flax', NULL , NULL),
(1013,'Darryl', 'Philbin',NULL, 'Male')

INSERT INTO EmployeeSalary VALUES 
(1010, NUll, 47000),
(Null, 'Salesman', 43000)