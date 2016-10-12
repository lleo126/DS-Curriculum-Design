package models 
{
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	/**
	 * 毫秒(ms)转换成时间(time)
	 * @author leo126
	 */
	public class Clock extends TextField
	{
		private var _currentTime:Date;
		private var _minutesZero:String;
		private var _secondsZero:String;
		private var timer:Timer = new Timer(1000);
		
		public function Clock()
		{
			_currentTime = new Date(0, 0, 1, 0, 0, 0, 0);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			update();
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			_currentTime.seconds++;
			update();
		}
		
		public function set time(value:Date):void
		{
			_currentTime = value;
			if (_currentTime.minutes < 10) { _minutesZero = "0"; }
			if (_currentTime.seconds < 10) { _secondsZero = "0"; }
			text = _minutesZero + _currentTime.minutes.toString() + " : " + _secondsZero + _currentTime.seconds.toString();
			
			_minutesZero = _secondsZero = ""; 
		}
		
		public function get time():Date
		{
			return _currentTime;
		}
		
		override public function set defaultTextFormat(value:TextFormat):void 
		{
			super.defaultTextFormat = value;
			update();
		}
		
		public function start():void 
		{
			timer.start();
		}
		
		public function stop():void 
		{
			timer.stop();
		}
		
		public function reset():void 
		{
			timer.reset();
			_currentTime = null;
			_currentTime = new Date(0, 0, 1, 0, 0, 0, 0);
			update();
		}
		
		private function update(e:TimerEvent = null):void 
		{
			time = _currentTime;
		}
	}

}