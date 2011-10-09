using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Ghostbusters.Data.Model;

namespace Ghostbusters.Web.Models
{
	public class HomeViewModel
	{
		public IEnumerable<SearchTime> searchy { get; set; }
	}
}