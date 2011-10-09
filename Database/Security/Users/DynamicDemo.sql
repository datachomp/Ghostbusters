IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'DynamicDemo')
CREATE LOGIN [DynamicDemo] WITH PASSWORD = 'p@ssw0rd'
GO
CREATE USER [DynamicDemo] FOR LOGIN [DynamicDemo]
GO
GRANT CONNECT TO [DynamicDemo]
