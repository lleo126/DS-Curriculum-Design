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
		protected var rowNow:int;
		protected var dirNum:int;
		private var angleBegin:Number;
		private var angle:Number;
		
		public function OrientedAnimation(unit:Unit) 
		{
			super(unit);
			angleBegin = 360 / (dirNum * 2);
			angle = 360 / dirNum;
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
		
		override public function update(deltaTime:int):void 
		{
			while (rowNow< _row && angleBegin + rowNow*angle < unit.unitTransform.orientation) rowNow++;
			rowNow = rowNow == _row?0:rowNow;
			clipRect.y = rowNow * HEIGHT;
			super.update(deltaTime);
			
		}
	}
}