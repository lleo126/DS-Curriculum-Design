package controls 
{
	import assets.AssetManager;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
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
			update();
			addChild(bar);
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * 那个横杠
		 */
		protected var bar:Bitmap;
		
		//==========
		// 属性
		//==========
		
		/**
		 * 值，从 0 ~ 100
		 */
		protected var _value:Number = 0.0;
		public function get value():Number
		{
			return _value;
		}
		public function set value(val:Number):void 
		{
			_value = val;
			update();
		}
		
		/**
		 * 最大值
		 */
		private var _maxValue:Number
		public function get maxValue():Number 
		{
			return _maxValue;
		}
		public function set maxValue(value:Number):void 
		{
			_maxValue = value;
			update();
		}
		
		/**
		 * 条子的分割处 X 坐标
		 */
		public function get valueX():Number
		{
			return bar.width * _value / maxValue;
		}
		
		//==========
		// 方法
		//==========
		
		protected function update():void 
		{
			
		}
	}

}