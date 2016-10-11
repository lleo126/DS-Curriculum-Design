package models 
{
	import flash.text.TextField;
	/**
	 * 毫秒(ms)转换成时间(time)
	 * @author leo126
	 */
	public class Clock extends TextField
	{
		private var _ms:int = 0;
		private var _currentTime:String = null;
		
		public function Clock()
		{
			
		}

		public function get ms():int
		{
			return _ms;
		}
		
		public function set ms(value:int):void
		{
			_ms = value;
			calculateTime();
		}
		
		public function get currentTime():String
		{
			return _currentTime;
		}
		
		private function calculateTime():void
		{
			var minutes:int = (_ms % (1000 * 60 * 60)) / (1000 * 60);
			var seconds:int = (_ms % (1000 * 60)) / 1000;
			
			if (seconds < 10)
			{
				_currentTime = minutes + " :0" + seconds;
			}
			else
			{			
				_currentTime = minutes + " : " + seconds;
			}
		}
	}

}