SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[tsu_AssertEqual] 
	@expected sql_variant, 
	@actual sql_variant
		
-- GENERAL INFO:    This stored procedure is a part of the tsqlunit
--                  unit testing framework. It is open source software
--                  available at http://tsqlunit.sourceforge.net
--
-- DESCRIPTION:     Simplifies creation of assertions. 
--                  
-- PARAMETERS:      @expected       Expected value
--                  @actual         Actual value
-- 
-- VERSION:         tsqlunit-0.92
--
-- Author:			Luke Winikates (rukednous)
--
-- COPYRIGHT:
--    Copyright (C) 2002-2011  Henrik Ekelund 
--    Email: <http://sourceforge.net/sendmessage.php?touser=618411>
--
--    This library is free software; you can redistribute it and/or
--    modify it under the terms of the GNU Lesser General Public
--    License as published by the Free Software Foundation; either
--    version 2.1 of the License, or (at your option) any later version.
--
--    This library is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
--    Lesser General Public License for more details.
--
--    You should have received a copy of the GNU Lesser General Public
--    License along with this library; if not, write to the Free Software
--    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA         
	
AS
BEGIN
	SET NOCOUNT ON;
	IF	(
		@expected != @actual or 
		@expected is null and @actual is not null or
		@expected is not null and @actual is null
		)
	BEGIN
		DECLARE @msg nvarchar(255)
		SELECT @msg = 'Expected: ' 
				+isnull(cast(@expected as nvarchar(55)),'NULL')
				+' Was: '
				+isnull(cast(@actual as nvarchar(55)),'NULL');
		EXEC tsu_failure @msg;
	END	
END
GO
