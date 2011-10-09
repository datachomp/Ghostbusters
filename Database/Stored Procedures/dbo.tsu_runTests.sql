SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[tsu_runTests]
	@suite NVARCHAR(255)='' OUTPUT,
	@success BIT = 0 OUTPUT,
	@testCount INTEGER = 0 OUTPUT,
	@failureCount INTEGER = 0 OUTPUT,
	@errorCount INTEGER = 0 OUTPUT,
	@lastTestResultID INT OUTPUT -- modified by me to grab the results
-- GENERAL INFO:    This stored procedure is a part of the tsqlunit
--                  unit testing framework. It is open source software
--                  available at http://tsqlunit.sourceforge.net
--
-- DESCRIPTION:     This is the procedure you call when you want to run 
--                  the tests and look at the result. It may also be called 
--                  from code. Statistics are returned in the output parameters,
--                  and in the table tsuLastTestResult
--                  
-- PARAMETERS:      @suite          Optional name of a suite, if this is not
--                                  provided all tests in the database will be
--                                  executed.
--                  @success        1 if all tests were successful.  
--                  @testCount      The number of tests executed.
--                  @failureCount   The number of failing tests.
--                  @errorCount     The number of tests with errors.
--
-- AE, 2009-07-02, ENHANCEMENT: https://sourceforge.net/apps/trac/tsqlunit/ticket/1 
-- RETURNS:         0 if all tests ran successfully, 1 otherwise. 
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
DECLARE @testsuite NVARCHAR(255)
--DECLARE @lastTestResultID INTEGER
DECLARE @startTime DATETIME
DECLARE @stopTime DATETIME
SET @success=0
SET @testCount=0
SET @failureCount=0
SET @errorCount=0

IF @suite='' OR @suite IS NULL SET @suite='%' 

CREATE TABLE #tests (
	 TESTNAME sysname,
	 SUITE sysname,
	 HASSETUP bit,
	 HASTEARDOWN bit
)

INSERT INTO #tests EXECUTE tsu_describe

DECLARE testsuites_cursor CURSOR FOR 
	SELECT DISTINCT SUITE FROM #tests 
	WHERE SUITE LIKE @suite
	ORDER BY SUITE 
OPEN testsuites_cursor

SET @startTime=GetDate()
PRINT REPLICATE ( '=' , 80 ) 
PRINT ' Run tests starts: ' + CAST(@startTime AS VARCHAR(30))

FETCH NEXT FROM testsuites_cursor INTO @testsuite
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC tsu_runTestSuite @testsuite	
SET @lastTestResultID=(SELECT MAX(testResultID) FROM
tsuTestResults)
	SET @testCount= @testCount+ (SELECT runs FROM tsuTestResults 
					 WHERE testResultID=@lastTestResultID)
	SET @failureCount= @failureCount+ (SELECT COUNT(*) FROM tsuFailures 
 					    WHERE testResultID=@lastTestResultID)
	SET @errorCount= @errorCount+ (SELECT COUNT(*) FROM tsuErrors 
					 WHERE testResultID=@lastTestResultID)


	FETCH NEXT FROM testsuites_cursor  INTO @testsuite
END
SET @stopTime=GetDate()
IF @failureCount=0 and @errorCount=0 
	 SET @success=1	

CLOSE testsuites_cursor
DEALLOCATE testsuites_cursor

PRINT REPLICATE ( '=' , 80 ) 

EXEC tsu_showTestResults @startTime, @stopTime

PRINT REPLICATE ( '-' , 80 ) 
PRINT ' Run tests ends: ' + CAST(@stopTime AS VARCHAR(30))
PRINT ' Summary: '
PRINT '     ' + LTRIM(STR(@testCount)) + ' tests, of which ' + 
          LTRIM(STR(@failureCount)) + ' failed and ' + 
          LTRIM(STR(@errorCount)) + ' had an error.'
PRINT ''
IF @success=1 
	PRINT '     SUCCESS!'
ELSE
	PRINT '     FAILURE!'

PRINT REPLICATE ( '-' , 80 ) 
PRINT REPLICATE ( '=' , 80 ) 
--
--# According to Knownledge base article Q313861 a recordset will not return to ADO if the
--# stored procedure fails with a severe error. As a work around, the result of the
--# last test is saved to the table tsuLastTestResult
--
DELETE FROM tsuLastTestResult
INSERT INTO tsuLastTestResult ( suite, success, testCount, failureCount, errorCount, startTime, stopTime)
	VALUES (@suite, @success, @testCount, @failureCount, @errorCount, @startTime, @stopTime)

-- AE, 2009-07-02, ENHANCEMENT: https://sourceforge.net/apps/trac/tsqlunit/ticket/1 
IF @success=1 
	RETURN 0
ELSE
	RETURN 1

END


GO
GRANT EXECUTE ON  [dbo].[tsu_runTests] TO [DemoApp]
GO
