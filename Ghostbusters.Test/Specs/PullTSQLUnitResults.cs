using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;
using System.Data;
using Dapper;
using System.Configuration;
using System.Data.Common;

namespace Ghostbusters.Test.Specs
{
[TestFixture]
public class PullTSQLUnitResults : TestBase
{
	//this is for Dapper
	string connection = ConfigurationManager.ConnectionStrings["gbConn"].ToString();
	public static DbConnection GetOpenConnection(string connectionString)
	{
		var factory = DbProviderFactories.GetFactory("System.Data.SqlClient");
		var connection = factory.CreateConnection();
		connection.ConnectionString = connectionString;
		connection.Open();
		return connection;
	}
	/*
	[Test]
	public void Run_TSQLUNITTest_And_Check_Results()
	{
		//arrange
		var p = new DynamicParameters();
		p.Add("@Success", dbType: DbType.Int32, direction: ParameterDirection.Output);
		p.Add("@lastTestResultID", dbType: DbType.Int32, direction: ParameterDirection.Output);
		p.Add("@retval", dbType: DbType.Int32, direction: ParameterDirection.ReturnValue);
		int retval;
		int success;
		int testid;

		using (DbConnection sqlConnection = GetOpenConnection(connection))
		{
			sqlConnection.Execute("tsu_runtests", p, commandType: CommandType.StoredProcedure);
			success = p.Get<int>("@Success");
			testid = p.Get<int>("@lastTestResultID");
			retval = p.Get<int>("@retval");
		}

		// everything ran ok
		//Assert.AreEqual(@retval, 0);

		// we grabbed the right id to use for the fail table
		//Assert.Greater(testid, 1);
		
		int pass = -1;
		using (DbConnection sqlConnection = GetOpenConnection(connection))
		{
			pass = sqlConnection.Query<int>("SELECT COUNT(0) FailCount FROM dbo.tsuFailures WHERE testResultID = @tester",  new { tester = testid}).First();
		}

		// check the failure table to make sure nothing "bad" happened
		//Assert.AreEqual(pass, 0);
	 
	}
	*/

}
}
