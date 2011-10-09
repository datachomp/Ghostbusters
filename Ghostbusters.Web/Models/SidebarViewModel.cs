using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Ghostbusters.Web.Models
{
	public class SidebarViewModel
	{
		public IEnumerable<String> Ghosts { get; set; }
		public IEnumerable<String> Cars { get; set; }
	}
}