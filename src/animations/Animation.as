package animations 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import interfaces.IUpdate;
	import managers.Logger;
	import managers.LoggerManager;
	import units.Unit;
	
	[event(Event.COMPLETE)]
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class Animation extends Sprite implements IUpdate
	{
		private static const origin:Point = new Point();
		protected var timeNow:int;
		protected var selfRect:Rectangle;
		protected var timeNum:int;
		protected var timeMax:int;
		protected var clipRect:Rectangle;
		
		protected var imgNow:Bitmap;
		protected var WIDTH:Number;
		private var logger:Logger = LoggerManager.CIRCULAR_QUEUE.newLogger();
		
		public function Animation(unit:Unit = null) 
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
			imgNow.smoothing = true;
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
			enterFrame(deltaTime);
			renderImg();
		}
		
		/**
		 * 销毁资源
		 */
		public function dispose():void 
		{
			
		}
		
		//时间间隔判断，决定是否调到下一张图下标
		protected function enterFrame(deltaTime:int):void 
		{
			logger.input(deltaTime);
			
			//当前的时间加上传入间隔时间
			timeNow += deltaTime;
		
			// TODO: 还是停留在同一帧就不用渲染
			// 如果大于下一帧的图片的起始时间，下标加一
			if (timeNow >= (timeNum + 1) * _delay)
			{
				//如果超过最大下标，返回第一个下标
				if (timeNow >= timeMax)
				{
					timeNow = timeNow - timeMax;
					dispatchEvent(new Event(Event.COMPLETE));
				}
				timeNum = timeNow / _delay;
			}
			
			logger.output(timeNum);
		}
		
		//加载图片的功能
		private function renderImg():void 
		{
			//图片填充
			imgNow.bitmapData.lock();
			imgNow.bitmapData.fillRect(selfRect, 0xFFFFFF);
			imgNow.bitmapData.copyPixels(_img.bitmapData, clipRect, origin, null, null, true);
			//根据enterFrame方法决定的图的下标决定下一次加载的图片的X坐标
			clipRect.x = timeNum * WIDTH;
			imgNow.bitmapData.unlock();
			imgNow.smoothing = true;
		}
	}
}