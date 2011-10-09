SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[tsu_showTestResults] 
	@startTime datetime=NULL,
	@endTime datetime=NULL 
-- GENERAL INFO:    This stored procedure is a part of the tsqlunit
--                  unit testing framework. It is open source software
--                  available at http://tsqlunit.sourceforge.net
--
-- DESCRIPTION:     This procedure shows the result of all tests done, or 
--                  all tests within a certain period.
-- PARAMETERS:      @suite        The name of the suite
--
-- RETURNS:         Nothing
-- 
-- VERSION:         tsqlunit-0.92
-- COPYRIGHT:
--    Copyright (C) 2002-2009  Henrik Ekelund 
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
	SET NOCOUNT ON
	DECLARE @testResultID INTEGER
	IF @startTime IS NULL 
		SET @startTime=CONVERT(DATETIME,'1900-01-01',121)
	IF @endTime IS NULL 
		SET @endTime=CONVERT(DATETIME,'2100-01-01',121)
	DECLARE cursortestResultID CURSOR FOR
	       SELECT testResultID FROM tsuTestResults WHERE 
		startTime>= CAST(@startTime AS timestamp) AND 
		stopTime <= @endTime 
		ORDER BY startTime
	OPEN cursortestResultID
	FETCH NEXT FROM cursortestResultID INTO @testResultID
	WHILE @@FETCH_STATUS =0 
	BEGIN
		EXEC tsu__private_showTestResult @testResultID
		FETCH NEXT FROM cursortestResultID INTO @testResultID
	END
	CLOSE cursortestResultID
	DEALLOCATE cursortestResultID
END





GO
