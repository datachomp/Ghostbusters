using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Ghostbusters.Data.Model;

namespace Ghostbusters.Data.Abstract
{
	public interface IDataRepository
	{
		IEnumerable<SearchTime> GetSearchResults(string searchitem, bool isghosts, bool isvehicles);

		IEnumerable<string> GetExpensiveGhosts();
		IEnumerable<string> GetWorkingVehicles();
	}
}
