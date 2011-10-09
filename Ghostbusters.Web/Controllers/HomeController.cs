using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Ghostbusters.Data.Abstract;
using Ghostbusters.Web.Models;
using MvcMiniProfiler;

namespace Ghostbusters.Web.Controllers
{
	public class HomeController : Controller
	{
		//IOC 
		private IDataRepository idataRepository;
		public HomeController(IDataRepository idataRepository)
		{	this.idataRepository = idataRepository;	}

		[HttpGet]
		public ActionResult Index()
		{
			var profiler = MiniProfiler.Current; // it's ok if this is null

			var favorite = idataRepository.GetSearchResults("", false, false);

			var viewmodel = new HomeViewModel
			{
				searchy	= favorite
			};

			return View(viewmodel);
		}

		[HttpPost]
		public ActionResult Index(FormCollection collecty)
		{
			string searchTerm = collecty["Searchy"];
			bool isGhost = Convert.ToBoolean(collecty["isGhost"]);
			//bool isVehicle = Convert.ToBoolean(collecty["isVehicle"]);
			var profiler = MiniProfiler.Current; // it's ok if this is null

			var favorite = idataRepository.GetSearchResults("%"+searchTerm+"%", isGhost, false);
			//var favorite = idataRepository.GetSearchResults("%" + searchTerm + "%", isGhost, isVehicle);

			var viewmodel = new HomeViewModel
			{
				searchy = favorite
			};

			return View(viewmodel);
		}


		public ActionResult About()
		{
			return View();
		}
	}
}
