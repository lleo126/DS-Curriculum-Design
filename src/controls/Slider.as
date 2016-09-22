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
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp); // TODO: 给 stage 加
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addChild(bar);
			addChild(tick);
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
		private var bar:Bitmap = new AssetManager.SLIDER_BAR();
		
		/**
		 * 那个圆圈
		 */
		private var tick:Bitmap = new AssetManager.SLIDER_TICK();
		
		//==========
		// 属性
		//==========
		
		/**
		 * 值，从 0 ~ 100
		 */
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
		
		private function onMouseOver(e:MouseEvent):void 
		{
			if (!down) return;
			
			// TODO: 判定滑到外面去
			value = mouseX - localToGlobal(new Point(x, y)).x;
		}
	}
}