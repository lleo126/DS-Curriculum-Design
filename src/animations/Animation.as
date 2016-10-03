package animations 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import units.Unit;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	internal class Animation extends Sprite 
	{
		protected var timeNow:int;
		protected var timeNum:int;
		protected var timeMax:int;
		protected var clipRect:Rectangle;
		
		protected var imgNow:Bitmap;
		protected var WIDTH:Number;
		
		public function Animation(unit:Unit) 
		{
			this.unit = unit;
			timeNow = 0;
			timeMax = _speed * _column;
			init();
			addChild(imgNow);
		}
		
		public function init():void 
		{
			WIDTH = _img.width / _column;
			clipRect = new Rectangle(0, 0, WIDTH, _img.height);
			imgNow = new Bitmap(new BitmapData(WIDTH, _img.height));
		}
		
		protected var _unit:Unit;
		public function get unit():Unit 
		{
			return _unit;
		}
		public function set unit(value:Unit):void 
		{
			_unit = value;
		}
		
		protected var _img:Bitmap;
		public function set img(value:Bitmap):void
		{
			_img = value;
		}
		
		protected var _speed:int;
		public function get speed():int 
		{
			return _speed;
		}
		public function set speed(value:int):void 
		{
			_speed = value;
		}
		
		protected var _column:int;
		public function get column():int 
		{
			return _column;
		}
		public function set column(value:int):void 
		{
			_column = value;
		}
		
		public function update(deltaTime:int):void 
		{
			timeNow += _speed;
			
			if (timeNow > timeNum * _speed)
			{
				timeNow = timeNow > timeMax? timeNow - timeMax:timeNow;
				timeNum = timeNum + 1 == _column? 0:timeNum + 1;
			}
			imgNow.bitmapData.fillRect(new Rectangle(0, 0, imgNow.bitmapData.width, imgNow.bitmapData.height), 0xFFFFFF);
			imgNow.bitmapData.copyPixels(_img.bitmapData, clipRect, new Point(), null, null, true);
			clipRect.x = timerNum * WIDTH;
		}
	}
}