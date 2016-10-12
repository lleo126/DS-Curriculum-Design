package models 
{
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	/**
	 * 毫秒(ms)转换成时间(time)
	 * @author leo126
	 */
	public class Clock extends TextField
	{
		private var _beginTime:Date;
		private var _currentTime:Date;
		private var _minutesZero:String;
		private var _secondsZero:String;
		private var _elapsedMinutes:int = 0;
		private var _elapsedSeconds:int = 0;
		private var timer:Timer = new Timer(1000);
		
		public function Clock()
		{
			_beginTime = new Date();
			_currentTime = new Date();
			
			timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			_currentTime.seconds++;
			
			_elapsedSeconds = (_currentTime.seconds + 60 - _beginTime.seconds) % 60;
			
			if (_elapsedMinutes < 10) { _minutesZero = "0"; } 
			if (_elapsedSeconds < 10) { _secondsZero = "0"; }
			text = _minutesZero + _elapsedMinutes.toString() + " : " + _secondsZero + _elapsedSeconds.toString();
			
			_minutesZero = _secondsZero = ""; 
			
			_elapsedMinutes += _elapsedSeconds / 59;
		}
		
		public function set time(value:Date):void
		{
			_currentTime = value;
			_beginTime = value;
			if (_currentTime.minutes < 10) { _minutesZero = "0"; }
			if (_currentTime.seconds < 10) { _secondsZero = "0"; }
			text = _minutesZero + _currentTime.minutes.toString() + " : " + _secondsZero + _currentTime.seconds.toString();
			
			_minutesZero = _secondsZero = ""; 
		}
		
		public function get time():Date
		{
			return _currentTime;
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
			_elapsedSeconds = 0;
			_elapsedMinutes = 0;
		}
	}

}