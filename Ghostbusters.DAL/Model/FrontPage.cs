using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Ghostbusters.Data.Model
{
	public class SearchTime
	{
		public string SearchName { get; set; }
		public string GroupType { get; set; }
	}

	public class Employees
	{
		public int GhostbusterID { get; set; }
		public string EmployeeName { get; set; }
		public bool ProtonPackCertified { get; set; }
		public DateTime DateHired { get; set; }
	}

	public class Ghosts
	{
		public int GhostID { get; set; }
		public string GhostName { get; set; }
		public string GhostType { get; set; }
		public decimal Cost { get; set; }
	}

	public class ContainmentUnits
	{
		public int UnitID { get; set; }
		Employees Employee {get;set;}
		Ghosts Ghost { get; set; }
		public DateTime DateBusted { get; set; }
	}

}
