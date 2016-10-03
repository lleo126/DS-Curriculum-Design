package animations 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import interfaces.IUpdate;
	import units.Unit;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	internal class Animation extends Sprite implements IUpdate
	{
		private static const origin:Point = new Point();
		protected var timeNow:int;
		protected var selfRect:Rectangle;
		protected var timeNum:int;
		protected var timeMax:int;
		protected var clipRect:Rectangle;
		
		protected var imgNow:Bitmap;
		protected var WIDTH:Number;
		
		public function Animation(unit:Unit) 
		{
			this.unit = unit;
			timeNow = 0;
			timeMax = _delay * _column;
			init();
			addChild(imgNow);
		}
		
		public function init():void 
		{
			WIDTH = _img.width / _column;
			clipRect = new Rectangle(0, 0, WIDTH, _img.height);
			imgNow = new Bitmap(new BitmapData(WIDTH, _img.height));
			selfRect = new Rectangle(0, 0, imgNow.bitmapData.width, imgNow.bitmapData.height)
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
		
		protected var _delay:int;
		public function get delay():int 
		{
			return _delay;
		}
		public function set delay(value:int):void 
		{
			_delay = value;
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
			timeNow += deltaTime;
			
			// TODO: 还是停留在同一帧就不用渲染
			if (timeNow >= (timeNum + 1) * _delay)
			{
				timeNow = timeNow >= timeMax? timeNow - timeMax:timeNow;
				timeNum = timeNow / _delay;
				//timeNum = timeNum + 1 == _column? 0:timeNum + 1;
			}
			imgNow.bitmapData.lock();
			imgNow.bitmapData.fillRect(selfRect, 0xFFFFFF);
			imgNow.bitmapData.copyPixels(_img.bitmapData, clipRect, origin, null, null, true);
			clipRect.x = timeNum * WIDTH;
			imgNow.bitmapData.unlock();
		}
	}
}