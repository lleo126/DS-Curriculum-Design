package controls 
{
	import assets.AssetManager;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class Slider extends Sprite 
	{
		public function Slider(value:Number) 
		{
			this.value = value;
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseUpDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addChild(bar);
			addChild(tick);
		}
		
		//==========
		// 变量
		//==========
		
		private var down:Boolean = false;
		private var bar:Bitmap = new AssetManager.SLIDER_BAR();
		private var tick:Bitmap = new AssetManager.SLIDER_TICK();
		
		//==========
		// 属性
		//==========
		
		public var _value:Number;
		public function get value():Number
		{
			return _value;
		}
		public function set value(val:Number):void 
		{
			_value = val;
			update();
		}
		
		//==========
		// 方法
		//==========
		
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
		
		private function onMouseOver(e:MouseEvent):void 
		{
			if (!down) return;
			
			value = mouseX - localToGlobal(new Point(x, y)).x;
		}
	}
}