using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Ghostbusters.Data.Abstract;
using Ghostbusters.Web.Models;

namespace Ghostbusters.Web.Controllers
{
	public class SidebarController : Controller
	{
		//IOC 
		private IDataRepository idataRepository;
		public SidebarController(IDataRepository idataRepository)
		{	this.idataRepository = idataRepository;	}

		public ActionResult FrontPage()
		{
			IEnumerable<string> ghosts = idataRepository.GetExpensiveGhosts().OrderBy(s => s);
			IEnumerable<string> cars = idataRepository.GetWorkingVehicles().OrderBy(s => s);

			var viewmodel = new SidebarViewModel
			{
				Ghosts = ghosts,
				Cars = cars
				
			};

			//return View(viewmodel);
			return PartialView(viewmodel);
		}

	}
}
