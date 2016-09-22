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
	public class Slider extends Sprite 
	{
		public function Slider(value:Number = 100.0) 
		{
			this.value = value;
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseUpDown);
			addEventListener(Event.ADDED_TO_STAGE, init);
			addChild(bar);
			addChild(tick);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpDown); // TODO: 给 stage 加
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * 表示鼠标处于按下的状态
		 */
		private var down:Boolean = false;
		
		/**
		 * 那个横杠
		 */
		private var bar:Bitmap = new AssetManager.SLIDER_BAR_IMG();
		
		/**
		 * 那个圆圈
		 */
		private var tick:Bitmap = new AssetManager.SLIDER_TICK_IMG();
		
		//==========
		// 属性
		//==========
		
		/**
		 * 值，从 0 ~ 100
		 */
		private var _value:Number;
		public function get value():Number
		{
			return _value;
		}
		public function set value(val:Number):void 
		{
			_value = val;
			update();
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		//==========
		// 方法
		//==========
		
		/**
		 * 更新滑块的位置
		 */
		private function update():void 
		{
			tick.x = bar.width * value / 100.0 - tick.width * 0.5;
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
			
			var newValue:Number = mouseX / width * 100;
			if (newValue < 0.0) newValue = 0.0;
			else if (100.0 < newValue) newValue = 100.0;
			
			value = newValue;
		}
	}
}