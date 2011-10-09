using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;
using System.Configuration;
using Dapper;
using System.Diagnostics;
using System.Data.Common;
using Ghostbusters.Data.Model;
using System.Data;

namespace Ghostbusters.Test.Specs
{
	[TestFixture]
	public class MenuTest : TestBase
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


		[Test]
		public void a_menu_has_some_items()
		{
			this.IsPending();
		}

		[Test]
		public void a_menu_is_good()
		{
			//Arrange
			string SqlQuery;
			//IEnumerable<SearchTime> fav;
			SearchTime fav;
			Stopwatch stopwatch = new Stopwatch();

			//act
			stopwatch.Start();
			using (DbConnection sqlConnection = GetOpenConnection(connection))
			{
				//sqlConnection.Open();

				SqlQuery = "Web_MainFormSearch";
				
				var p = new DynamicParameters();
				p.Add("@SearchTerm", "Ray Stantz");
				p.Add("@SearchGhost", true);
				p.Add("@SearchVehicles", true);
				//p.Add("@RetVal", dbType: DbType.Int32, direction: ParameterDirection.ReturnValue);

				fav = sqlConnection.Query<SearchTime>(SqlQuery, p, commandType: CommandType.StoredProcedure).First();
			}

			stopwatch.Stop();
			int differ = (int)stopwatch.ElapsedMilliseconds;

			//Asserts
			Assert.Greater(fav.SearchName.Length, 1);
			Assert.Greater(fav.GroupType.Length, 1);
			//Assert.Greater(1200, differ);
		}
	}	
}