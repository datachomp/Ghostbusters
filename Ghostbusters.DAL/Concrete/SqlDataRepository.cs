using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using Dapper;
using Ghostbusters.Data.Abstract;
using Ghostbusters.Data.Model;
using System.Data.Common;
using System.Data;

namespace Ghostbusters.Data.Concrete
{
	public class SqlDataRepository : IDataRepository
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
		 IEnumerable<SearchTime> GetSearchResults(string searchitem, bool busters, bool ghosts);
		 */

		public IEnumerable<SearchTime> GetSearchResults(string searchitem, bool isghost, bool isvehicle)
		{
			string SqlQuery;

			IEnumerable<SearchTime> things = null;

			using (DbConnection sqlConnection = GetOpenConnection(connection))
			{
				SqlQuery = "Web_MainFormSearch";

				var p = new DynamicParameters();
				p.Add("@SearchTerm", searchitem);
				p.Add("@SearchGhost", isghost);
				p.Add("@SearchVehicles", isvehicle);
				
				//p.Add("@RetVal", dbType: DbType.Int32, direction: ParameterDirection.ReturnValue);

				things = sqlConnection.Query<SearchTime>(SqlQuery, p, commandType: CommandType.StoredProcedure);

			}
			return things;
		}

		public IEnumerable<string> GetExpensiveGhosts()
		{
			string SqlQuery;
			IEnumerable<string> ghosts = null;

			using (DbConnection sqlConnection = GetOpenConnection(connection))
			{
				SqlQuery = "SELECT GhostName FROM Ghosts WHERE Cost = 200000";
				ghosts = sqlConnection.Query<string>(SqlQuery);
			}
			return ghosts;
		}
		public IEnumerable<string> GetWorkingVehicles()
		{
			string SqlQuery;
			IEnumerable<string> vehicles = null;

			using (DbConnection sqlConnection = GetOpenConnection(connection))
			{
				SqlQuery = "SELECT VehicleName FROM dbo.Vehicles WHERE InService =1";
				vehicles = sqlConnection.Query<string>(SqlQuery);
			}

			return vehicles;
		}
		
	}
}
