IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'DemoApp')
CREATE LOGIN [DemoApp] WITH PASSWORD = 'p@ssw0rd'
GO
CREATE USER [DemoApp] FOR LOGIN [DemoApp]
GO
GRANT CONNECT TO [DemoApp]
