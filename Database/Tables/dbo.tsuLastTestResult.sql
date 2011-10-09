CREATE TABLE [dbo].[tsuLastTestResult]
(
[suite] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[success] [bit] NULL,
[testCount] [int] NULL,
[failureCount] [int] NULL,
[errorCount] [int] NULL,
[startTime] [datetime] NULL,
[stopTime] [datetime] NULL
) ON [PRIMARY]
GO
