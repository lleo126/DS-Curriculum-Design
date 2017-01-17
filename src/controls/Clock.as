package controls 
{
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	/**
	 * 游戏时间控制类
	 * @author leo126
	 */
	public class Clock extends TextField
	{
		/**
		 * 系统当前时间
		 */
		private var _currentTime:Date;
		
		/**
		 * 前导0
		 */
		private var _minutesZero:String;
		private var _secondsZero:String;
		
		/**
		 * 计时器
		 */
		private var timer:Timer = new Timer(1000);
		
		public function Clock()
		{
			selectable	= false;
			_currentTime = new Date(0, 0, 1, 0, 0, 0, 0);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			update();
		}
		
		/**
		 * 设置字体大小
		 */
		override public function set defaultTextFormat(value:TextFormat):void 
		{
			super.defaultTextFormat = value;
			update();
		}
		
		/**
		*返回当前时间
		*/
	    public function get time():Date
	    {
			return _currentTime;
		   
		}
		
		/**
		*设置并显示当前时间
		*/
		public function set time(value:Date):void
		{
			_currentTime = value;
			if (_currentTime.minutes < 10) { _minutesZero = "0"; }
			if (_currentTime.seconds < 10) { _secondsZero = "0"; }
			text = _minutesZero + _currentTime.minutes.toString() + " : " + _secondsZero + _currentTime.seconds.toString();
			  
			_minutesZero = _secondsZero = ""; 
		}
		
		/**
		 * 计时器开启
		 */
		public function start():void 
		{
			timer.start();
		}
		
		/**
		 * 计时器暂停
		 */
		public function stop():void 
		{
			timer.stop();
		}
		
		/**
		 * 计时器重置
		 */
		public function reset():void 
		{
			timer.reset();
			_currentTime = null;
			_currentTime = new Date(0, 0, 1, 0, 0, 0, 0);
			update();
		}
		
		/**
		 * 计时器活动时触发事件
		 * @param	e
		 */
		private function onTimer(e:TimerEvent):void 
		{
			_currentTime.seconds++;
			update();
		}

		private function update(e:TimerEvent = null):void 
		{
			time = _currentTime;
		}
	}

}