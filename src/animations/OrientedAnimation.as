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
			selfRect = new Rectangle(0, 0, imgNow.bitmapData.width, imgNow.bitmapData.height)
		}
		
		//查找是否是下一行的图片
		public function findRow():void
		{
			//初始化为0
			rowNow = 0;
			//按顺序查找正确的下标
			while (rowNow< _row && angleBegin + rowNow*angle < unit.unitTransform.orientation) rowNow++;
			//如果超过最大下标，则返回第一个下标
			rowNow = rowNow == _row?0:rowNow;
			//最终决定最后的行数
			clipRect.y = rowNow * HEIGHT;
		}
		
	}
}