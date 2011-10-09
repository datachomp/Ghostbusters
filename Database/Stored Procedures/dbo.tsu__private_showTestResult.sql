SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[tsu__private_showTestResult] 
    @testResultID INTEGER 
-- GENERAL INFO:    This stored procedure is a part of the tsqlunit
--                  unit testing framework. It is open source software
--                  available at http://tsqlunit.sourceforge.net
--
-- DESCRIPTION:     This procedure prints the results of testing a suite.
-- PARAMETERS:      @testResultID        The testresult is shown for this ID
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
	-- AE, 2009-06-10, FIX: http://apps.sourceforge.net/trac/tsqlunit/ticket/2
	DECLARE @outstr NVARCHAR(1024)
	SET @outstr=(SELECT 'Testsuite: ' + testName + ' (' + LTRIM(STR(runs)) + ' tests )' 
				+ ' execution time: '  + LTRIM(STR(datediff(ms,startTime,stopTime))) + ' ms.'
	       -- AE, 2009-06-10, FIX: http://apps.sourceforge.net/trac/tsqlunit/ticket/8
            FROM tsuTestResults WHERE testResultID=@testResultID)

	PRINT @outstr

	DECLARE msgcursor CURSOR FOR 
		SELECT '>>> Test: ' + test + '     '  + message FROM tsuErrors	
		WHERE testResultID=@testResultID UNION ALL
		SELECT '>>> Test: ' + test + '     '  + message FROM tsuFailures
		WHERE testResultID=@testResultID 
	FOR READ ONLY
	OPEN msgcursor
	FETCH NEXT FROM msgcursor INTO @outstr
	WHILE @@FETCH_STATUS =0 
	BEGIN
		PRINT @outstr
		FETCH NEXT FROM msgcursor INTO @outstr
	END
	CLOSE msgcursor
	DEALLOCATE msgcursor
END




GO
