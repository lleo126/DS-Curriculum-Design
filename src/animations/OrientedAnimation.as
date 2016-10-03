package animations 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import units.Unit;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	internal class OrientedAnimation extends Animation 
	{
		protected var HEIGHT:Number;
		protected static var rowNow:int;
		
		public function OrientedAnimation(unit:Unit) 
		{
			super(unit);		
		}
		
		internal function get orientation():Number
		{
			return unit.unitTransform.orientation;
		}
		
		protected var _row:int;
		public function get row():int 
		{
			return _row;
		}
		public function set row(value:int):void 
		{
			_row = value;
		}
		
		override public function init():void
		{
			HEIGHT = _img.height / _row;
			WIDTH = _img.width / _column;
			clipRect = new Rectangle(0, 0, WIDTH, _img.height);
			imgNow = new Bitmap(new BitmapData(WIDTH, HEIGHT));
		}
		
		//override public function update(deltaTime:int):void 
		//{
			//clipRect.y = rowNow * HEIGHT;
			//super.update(deltaTime);
		//}
	}
}