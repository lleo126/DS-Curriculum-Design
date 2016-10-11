package models 
{
	/**
	 * 毫秒(ms)转换成时间(time)
	 * @author leo126
	 */
	public class msToTime 
	{
		private var _ms:uint = 0;
		private var _currentTime:String = null;
		
		public function msToTime()
		{
			
		}

		public function get ms():uint
		{
			return _ms;
		}
		
		public function set ms(value:uint):void
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
			var days:int	= _ms / (1000 * 60 * 60 * 24);
			var hours:int	= (_ms % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60);
			var minutes:int = (_ms % (1000 * 60 * 60)) / (1000 * 60);
			var seconds:int = (_ms % (1000 * 60)) / 1000;
			
			_currentTime = (days + " days " + hours + " hours " + minutes + " minutes " + seconds  + " seconds ");
		}
	}

}