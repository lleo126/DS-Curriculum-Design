package controls 
{
	import assets.AssetManager;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.text.TextField;
	/**
	 * ...
	 * @author leo126
	 */
	public class Bar extends Range 
	{
		public function Bar(value:Number, maxValue:Number, groove:Bitmap) 
		{
			bar	= new AssetManager.WHITEBAR_IMG();
			
			this.groove = groove;
			groove.mask = bar;
			
			super(value, maxValue);
			addChild(groove);
			addChild(text);
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * 状态槽
		 */
		protected var groove:Bitmap;
		
		/**
		 * 显示具体血量的文本
		 */
		protected var text:TextField = new TextField();
		
		//==========
		// 属性
		//==========
		
		override public function set value(val:Number):void 
		{
			text.text = _value + ' / ' + maxValue;
			super.value = val;
		}
		
		//==========
		// 方法
		//==========
		
		override protected function update():void 
		{
			groove.width = valueX;
			text.x = (width	- text.width) * 0.5;
			text.y = (height - text.height) * 0.5;
		}
	}
}