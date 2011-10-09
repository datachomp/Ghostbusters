CREATE TABLE [dbo].[Employees]
(
[EmployeeID] [tinyint] NOT NULL IDENTITY(1, 1),
[EmployeeName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProtonPackCertified] [bit] NOT NULL CONSTRAINT [DF_Employees_ProtonPackCertified] DEFAULT ((0)),
[DateHired] [date] NOT NULL CONSTRAINT [DF_Employees_DateHired] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Employees] ADD CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED  ([EmployeeID]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[Employees] TO [DemoApp]
GRANT SELECT ON  [dbo].[Employees] TO [DynamicDemo]
GO
