CREATE TABLE [dbo].[tsuTestResults]
(
[testResultID] [int] NOT NULL IDENTITY(1, 1),
[startTime] [datetime] NOT NULL,
[stopTime] [datetime] NULL,
[runs] [int] NOT NULL,
[testName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
