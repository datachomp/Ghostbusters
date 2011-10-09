SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[tsu__private_createTestResult] @suiteName NVARCHAR(255)=''
-- GENERAL INFO:    This stored procedure is a part of the tsqlunit
--                  unit testing framework. It is open source software
--                  available at http://tsqlunit.sourceforge.net
--
-- DESCRIPTION:     This procedure intializes the testrsult before the 
--                  tests in a suite are called.
-- PARAMETERS:      @suiteName          The name of the testsuite
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
INSERT INTO tsuTestResults
	( runs, testName, startTime) 
VALUES (0,@suiteName, GetDate())
IF @@ERROR <>0 
	RETURN 100



GO
