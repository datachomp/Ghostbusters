using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;
using System.Diagnostics;

namespace Ghostbusters.Test
{
	public class TestBase
	{

		public void IsPending()
		{
			Console.WriteLine(" {0} -- Pending", GetCaller());
			Assert.Inconclusive();
		}

		public string GetCaller()
		{
			StackTrace stack = new StackTrace();
			return stack.GetFrame(2).GetMethod().Name.Replace("_"," ");
		}
	}
}
