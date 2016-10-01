package controls 
{
	import assets.AssetManager;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author leo126
	 */
	public class Bar extends Range 
	{
		private static const FONT_SIZE:Number = 20.0;
		
		public function Bar(value:Number, maxValue:Number, groove:Bitmap) 
		{
			super(value, maxValue);
			
			text.defaultTextFormat = new TextFormat(null, FONT_SIZE);
			text.selectable = false;
			bar	= new AssetManager.WHITEBAR_IMG();
			this.groove = groove;
			groove.mask = bar;
		}
		
		override protected function init(e:Event):void 
		{
			super.init(e);
			
			addChild(groove);
			addChild(bar);
			addChild(text);
			
			update();
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
		
		//==========
		// 方法
		//==========
		
		override protected function update():void 
		{
			groove.width = valueX;
			text.text = _value.toString() + ' / ' + maxValue.toString();
			text.x = (width	- text.width) * 0.5;
			text.y = (height - text.height) * 0.5;
		}
	}
}