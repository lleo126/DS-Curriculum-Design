package units 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * 可以设置中心点的 Sprite
	 * @author 彩月葵☆彡
	 * @example
	 *		var spriteEx:SpriteEx = new SpriteEx(new Shape());
	 *		with (spriteEx.displayObject as Shape) {
	 *			graphics.beginFill(0xE85012);
	 *			graphics.drawRect(0, 0, 100, 50);
	 *			graphics.endFill();
	 *		}
	 *		with (spriteEx) { x = 200; y = 200; }
	 *		addChild(spriteEx);
	 *		spriteEx.center();
	 *		var timer:Timer = new Timer(20);
	 *		timer.addEventListener(TimerEvent.TIMER, function ():void 
	 *		{
	 *			spriteEx.rotation += 10.0;
	 *		})
	 *		timer.start();
	 */
	public class SpriteEx extends Sprite 
	{
		public function SpriteEx(displayObject:DisplayObject) 
		{
			_displayObject = displayObject;
			addChild(_displayObject);
		}
		
		//==========
		// 变量
		//==========
		
		
		//==========
		// 属性
		//==========
		
		/**
		 * 内部包装的 DisplayObject
		 */
		protected var _displayObject:DisplayObject;
		public function get displayObject():DisplayObject 
		{
			return _displayObject;
		}
		
		/**
		 * 注册点 x 坐标
		 */
		public function get pivotX():Number 
		{
			return -displayObject.x;
		}
		public function set pivotX(value:Number):void 
		{
			displayObject.x = -value;
		}
		
		/**
		 * 注册点 y 坐标
		 */
		public function get pivotY():Number 
		{
			return -displayObject.y;
		}
		public function set pivotY(value:Number):void 
		{
			displayObject.y = -value;
		}
		
		//==========
		// 方法
		//==========
		
		/**
		 * 把注册点设置到中心
		 */
		public function center():void 
		{
			pivotX = displayObject.width	* 0.5;
			pivotY = displayObject.height	* 0.5;
		}
	}

}