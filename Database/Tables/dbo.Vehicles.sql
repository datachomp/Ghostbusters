CREATE TABLE [dbo].[Vehicles]
(
[VehicleID] [tinyint] NOT NULL IDENTITY(1, 1),
[VehicleName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[InService] [bit] NOT NULL CONSTRAINT [DF_Vehicles_InService] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Vehicles] ADD CONSTRAINT [PK_Vehicles] PRIMARY KEY CLUSTERED  ([VehicleID]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[Vehicles] TO [DemoApp]
GRANT SELECT ON  [dbo].[Vehicles] TO [DynamicDemo]
GO
