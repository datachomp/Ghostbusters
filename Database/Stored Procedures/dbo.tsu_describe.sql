SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- Create stored procedures --

CREATE PROCEDURE [dbo].[tsu_describe]
-- GENERAL INFO:    This stored procedure is a part of the tsqlunit
--                  unit testing framework. It is open source software
--                  available at http://tsqlunit.sourceforge.net
--
-- DESCRIPTION:     This procedure returns information about all testcases 
--                  in the database.
-- PARAMETERS:      None
-- RETURNS:         Recordset with fields:
--                      TESTNAME:       the name of the test stored procedure 
--                      SUITE:          the name of the testsuite, or blank if 
--                                      the test does not belong to a suite. 
--                      HASSETUP:       1 if the suite has a setup procedure.
--                      HASTEARDOWN:    1 if the suite has a teardown procedure.    
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

SET NOCOUNT ON 

DECLARE @testcase sysname
DECLARE @testcase_prefix_removed sysname
DECLARE @ErrorSave INT
DECLARE @ErrorExec INT
DECLARE @hasSetup BIT
DECLARE @hasTearDown BIT
DECLARE @suitePrefixIndex INT

DECLARE @suite sysname
DECLARE @testPrefix varchar(10)
DECLARE @lengthOfTestPrefix INTEGER
DECLARE @LikeUnderscore char(3)
DECLARE @setupLikeExpression VARCHAR(255)
DECLARE @teardownLikeExpression VARCHAR(255)

SET @LikeUnderscore ='[_]'
SET @testPrefix='ut' + @LikeUnderscore
SET @lengthOfTestPrefix=3

CREATE TABLE #result (
 TESTNAME sysname,
 SUITE sysname,
 HASSETUP bit,
 HASTEARDOWN bit
)

DECLARE testcases_cursor CURSOR FOR 
	select name from sysobjects where xtype='P' and name LIKE  @testPrefix + '%'

OPEN testcases_cursor

FETCH NEXT FROM testcases_cursor INTO @testcase

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @hasSetup=0
    SET @hasTearDown=0
    SET @suite=''

    SET @testcase_prefix_removed=RIGHT(@testcase,LEN( @testcase)-@lengthOfTestPrefix)

    IF @testcase_prefix_removed LIKE '%' +@LikeUnderscore+ '%'  
    BEGIN
	SET @suitePrefixIndex=CHARINDEX ( '_', @testcase_prefix_removed  ) 
	SET @suite= LEFT(@testcase_prefix_removed, @suitePrefixIndex - 1)
            SET @setupLikeExpression=@testPrefix +  @suite + @LikeUnderscore  + 'setup'
            SET @hasSetup= (select count(*) from sysobjects where xtype='P' and name LIKE @setupLikeExpression )

            SET @teardownLikeExpression=@testPrefix +  @suite + @LikeUnderscore  + 'teardown'
	SET @hasTearDown= (select count(*) from sysobjects where xtype='P' and name LIKE @teardownLikeExpression )
    END

    IF NOT((@hasSetup=1 AND (@testcase LIKE @setupLikeExpression)) OR ( @hasTearDown=1 AND (@testcase LIKE @teardownLikeExpression)))
    BEGIN	
	 INSERT INTO  #result ( TESTNAME ,
				 SUITE,
				 HASSETUP,
				 HASTEARDOWN )
	 VALUES (@testcase, @suite,@hasSetup,@hasTearDown)
    END	
    FETCH NEXT FROM testcases_cursor  INTO @testcase
END
 
CLOSE testcases_cursor
DEALLOCATE testcases_cursor

SELECT TESTNAME, SUITE, HASSETUP, HASTEARDOWN FROM #result
GO
