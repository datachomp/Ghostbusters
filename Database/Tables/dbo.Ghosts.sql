CREATE TABLE [dbo].[Ghosts]
(
[GhostID] [int] NOT NULL IDENTITY(1, 1),
[GhostName] [varchar] (75) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[GhostType] [varchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Cost] [smallmoney] NOT NULL CONSTRAINT [DF_Ghosts_Cost] DEFAULT ((100))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Ghosts] ADD CONSTRAINT [PK_Ghosts] PRIMARY KEY CLUSTERED  ([GhostID]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[Ghosts] TO [DemoApp]
GRANT SELECT ON  [dbo].[Ghosts] TO [DynamicDemo]
GO
