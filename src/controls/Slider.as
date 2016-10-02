package controls 
{
	import assets.AssetManager;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	[Event(Event.CHANGE)]
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class Slider extends Range 
	{
		public function Slider(value:Number, maxValue:Number) 
		{
			super(value, maxValue);
			bar = new AssetManager.SLIDER_BAR_IMG();
		}
		
		override protected function init(e:Event):void 
		{
			super.init(e);
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseUpDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpDown);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			
			addChild(bar);
			addChild(tick);
			
			update();
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * 表示鼠标处于按下的状态
		 */
		private var down:Boolean = false;
		
		/**
		 * 那个圆圈
		 */
		private var tick:Bitmap = new AssetManager.SLIDER_TICK_IMG();
		
		//==========
		// 属性
		//==========
		
		override public function set value(val:Number):void 
		{
			super.value = val;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		//==========
		// 方法
		//==========
		
		/**
		 * 更新滑块的位置
		 */
		override protected function update():void 
		{
			tick.x = valueX - tick.width * 0.5;
			tick.y = (bar.height - tick.height) * 0.5;
		}
		
		private function onMouseUpDown(e:MouseEvent):void 
		{
			if (e.type == MouseEvent.MOUSE_DOWN)	down = true;
			else if (e.type == MouseEvent.MOUSE_UP)	down = false;
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			if (!down) return;
			
			value = mouseX / width * maxValue;
		}
	}
}