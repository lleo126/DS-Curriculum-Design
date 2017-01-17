package controls 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.utils.getTimer;
	
	/**
	 * 印章效果
	 * @author 彩月葵☆彡
	 */
	public class Stamp extends Sprite 
	{
		public function Stamp(displayObject:DisplayObject) 
		{
			this.displayObject = displayObject;
			addChild(displayObject);
		}
		
		public var beginWidth:Number;
		public var beginHeight:Number;
		public var endWidth:Number;
		public var endHeight:Number;
		public var startBlur:Number = 5.0;
		public var endBlur:Number = 0.0;
		public var deltaMultiplier:Number = 1.0;
		
		private var displayObject:DisplayObject;
		private var stampTime:int;
		private var startTime:int;
		private var blurFilter:BlurFilter;
		private var flashTime:int = 300.0;
		private var colorTransform:ColorTransform;
		
		/**
		 * 播放印上去的动画
		 */
		public function play(time:int):void 
		{
			this.stampTime = time;
			startTime = getTimer();
			addEventListener(Event.ENTER_FRAME, onStamp);
			blurFilter = new BlurFilter(startBlur, startBlur);
			colorTransform = transform.colorTransform;
		}
		
		private function onStamp(e:Event):void 
		{
			var dt:int = Math.min(getTimer() - startTime, stampTime),
				t:Number = dt / stampTime;
			width = beginWidth + (endWidth - beginWidth) * t * t * t * t * t;
			height = beginHeight + (endHeight - beginHeight) * t * t * t * t * t;
			blurFilter.blurX = blurFilter.blurY = startBlur + (endBlur - startBlur) * t * t * t * t * t;
			filters = [ blurFilter ];
			if (dt == stampTime)
			{
				startTime = getTimer();
				
				removeEventListener(Event.ENTER_FRAME, onStamp);
				addEventListener(Event.ENTER_FRAME, onFlash);
			}
		}
		
		private function onFlash(e:Event):void 
		{
			var dt:int = Math.min(getTimer() - startTime, flashTime),
				t:Number = dt / flashTime;
			colorTransform.redMultiplier = colorTransform.greenMultiplier = colorTransform.blueMultiplier = 1.0 + deltaMultiplier * Math.sin(Math.PI * t);
			transform.colorTransform = colorTransform;
			if (dt == flashTime) removeEventListener(Event.ENTER_FRAME, onFlash);
		}
	}
}