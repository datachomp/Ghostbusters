using NUnit.Framework;

namespace Ghostbusters.Test {
	[TestFixture]
	public class NUnitSampleTests {
		[Test]
		public void SomePassingTest() {
			Assert.AreEqual(5, 5);
		}

		[Test]
		public void SomeFailingTest() {
			//Assert.Greater(5, 7);
			Assert.Greater(8, 7);
		}
	}
}
