package controls 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author leo126
	 */
	public class Range extends Sprite 
	{
		
		public function Range(value:Number, maxValue:Number) 
		{
			_value		= value;
			_maxValue	= maxValue;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		protected function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * 那个横杠
		 */
		protected var bar:Bitmap;
		
		protected var _value:Number = 0.0;
		protected var _maxValue:Number;
		
		//==========
		// 属性
		//==========
		
		/**
		 * 值，从 0 ~ 100
		 */
		public function get value():Number { return _value; }
		public function set value(val:Number):void 
		{
			if (val < 0.0) val = 0.0;
			else if (maxValue < val) val = maxValue;
			_value = val;
			update();
		}
		
		/**
		 * 最大值
		 */
		public function get maxValue():Number { return _maxValue; }
		public function set maxValue(value:Number):void 
		{
			_maxValue = value;
			update();
		}
		
		/**
		 * 条子的分割处 X 坐标
		 */
		public function get valueX():Number { return bar.width * _value / maxValue; }
		
		//==========
		// 方法
		//==========
		
		protected function update():void 
		{
			
		}
	}

}