CREATE TABLE [dbo].[ContainmentUnits]
(
[UnitID] [int] NOT NULL IDENTITY(1, 1),
[fk_GhostID] [int] NOT NULL,
[FK_BusterID] [int] NOT NULL,
[DateBusted] [date] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ContainmentUnits] ADD CONSTRAINT [PK_ContainmentUnits] PRIMARY KEY CLUSTERED  ([UnitID]) ON [PRIMARY]
GO
