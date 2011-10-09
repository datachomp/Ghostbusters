CREATE TABLE [dbo].[tsuFailures]
(
[testResultID] [int] NOT NULL,
[test] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[message] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
