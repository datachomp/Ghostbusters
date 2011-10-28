SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--Declare @ID int ; exec tsu_runTests @lastTestResultID = @ID;
CREATE PROCEDURE [dbo].[ut_Test_MainVehicleFormSearch]
AS
BEGIN

	--Arrange
	DECLARE @SearchName VARCHAR(50) = NULL
			, @GroupType VARCHAR(50) = NULL;
	
	DECLARE @blah Table(SearchName varchar(50), GroupType varchar(50))
	
	
	--Act
	INSERT INTO @Blah(SearchName, GroupType)
	EXEC Web_MainFormSearch 'Ecto-1'

	SELECT @SearchName = SearchName, @GroupType = GroupType
	FROM @Blah

	--Assert
	IF(@@ROWCOUNT = 0)
		EXEC dbo.tsu_failure @message = N'No rows returned.Cats and Dogs living together!'

	IF (LEN(@SearchName)= 0 OR @SearchName IS NULL OR @SearchName <> 'Ecto-1')
		EXEC dbo.tsu_failure @message = N'Ray is dead.'
		
	IF (@GroupType <> 'Vehicles')
		EXEC dbo.tsu_failure @message = N'The Group is jacked up dude'
	
END
GO
