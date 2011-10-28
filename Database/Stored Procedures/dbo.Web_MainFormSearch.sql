
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--Web_MainFormSearch 'ray stantz'
--exec Web_MainFormSearch @SearchTerm=N'%Ray Stantz%',@SearchGhost=0
--exec Web_MainFormSearch @SearchTerm=N'%Zuul%',@SearchGhost=1
--exec Web_MainFormSearch @SearchTerm=N'%Ecto-1%',@SearchGhost=1, @SearchVehicles =1
CREATE PROCEDURE [dbo].[Web_MainFormSearch]
(	@SearchTerm VARCHAR(50)
	,@SearchGhost BIT =1
	,@SearchVehicles BIT =1
)	WITH EXECUTE AS 'DynamicDemo'
AS

DECLARE @sql NVARCHAR(4000)

SELECT @sql = 'SELECT EmployeeName AS SearchName, ''Employee'' AS GroupType
	FROM dbo.Employees
	WHERE EmployeeName like @SearchTerm'

IF @SearchGhost = 1
BEGIN
	SET @sql = @sql + ' union all '
	SET @Sql = @sql + 'SELECT GhostName AS SearchName, ''Ghosts'' AS GroupType
		FROM dbo.Ghosts
		WHERE GhostName like @SearchTerm'
END

/*
IF @SearchVehicles = 1
BEGIN
SET @sql = @sql + ' union all '
SET @Sql = @sql + 'SELECT VehicleName AS SearchName, ''Vehicles'' AS GroupType
	FROM dbo.Vehicles WHERE InService=1 and VehicleName like @SearchTerm'

END
*/

--PRINT @sql
--EXEC sp_Executesql @Sql, N'@empname varchar(50), @GhostName varchar(50)', @SearchTerm, @SearchTerm
EXEC sp_Executesql @Sql, N'@SearchTerm varchar(50)', @SearchTerm
GO

GRANT EXECUTE ON  [dbo].[Web_MainFormSearch] TO [DemoApp]
GO
