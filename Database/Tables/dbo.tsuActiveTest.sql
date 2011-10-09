CREATE TABLE [dbo].[tsuActiveTest]
(
[isError] [bit] NOT NULL,
[isFailure] [bit] NOT NULL,
[procedureName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[message] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[tsuActiveTest] TO [DynamicDemo]
GO
