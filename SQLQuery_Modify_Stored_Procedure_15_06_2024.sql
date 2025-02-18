USE [SQLTutorial]
GO
/****** Object:  StoredProcedure [dbo].[Temp_Employee]    Script Date: 15-Jun-24 2:27:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Temp_Employee]
@JobTitle varchar(100)
AS
CREATE TABLE #temp_employee
(JobTitle varchar(100),
EmployeePerJob int,
AvgAge int,
AvgSalary int)

INSERT INTO #temp_employee
SELECT JobTitle, COUNT(JobTitle), Avg(Age), AVG(Salary)
FROM SQLTutorial.dbo.EmployeeDemographics AS emp
JOIN
SQLTutorial.dbo.EmployeeSalary AS Sal
	ON emp.EmployeeID = Sal.EmployeeID
WHERE JobTitle = @JobTitle
GROUP BY JobTitle

SELECT *
FROM #temp_employee