package 
{
	import asunit.textui.TestRunner;
	import flash.events.Event;
	import tests.TestCase1;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class Test extends TestRunner 
	{
		public function Test() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			start(TestCase1);
		}
		
	}

}