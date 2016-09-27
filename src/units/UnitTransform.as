package units 
{
	import flash.geom.Point;
	/**
	 * 单位的位置、速度和碰撞信息，与单位绑定
	 * @author 彩月葵☆彡
	 */
	public class UnitTransform 
	{
		public function UnitTransform()
		{
			
		}
		
		//==========
		// 变量
		//==========
		
		public var unit:Unit;
		
		/**
		 * X 和 Y 分量上的总移动速度
		 */
		public var speed:Number = 0.0;
		
		/**
		 * Z 方向上移动速度
		 */
		public var vz:Number = 0.0;
		
		/**
		 * 底部坐标
		 */
		public var bottom:Number = 0.0;
		
		/**
		 * z 轴高度，从 z 轴底部坐标（bottom）到 z 轴顶部坐标（top）的高度
		 */
		public var altitude:Number = 0.0;
		
		/**
		 * 朝向，单位的图片根据朝向设定
		 */
		public var orientation:Number = 90.0;
		
		/**
		 * 碰撞半径
		 */
		public var radius:Number = 0.0;
		
		//==========
		// 属性
		//==========
		
		/**
		 * X 方向上移动速度
		 */
		public function get vx():Number 
		{
			return speed * Math.cos(orientation * Math.PI / 180);
		}
		
		/**
		 * Y 方向上移动速度
		 */
		public function get vy():Number 
		{
			return speed * Math.sin(orientation * Math.PI / 180);
		}
		
		/**
		 * Z 轴顶部坐标
		 */
		public function get top():Number 
		{
			return bottom + altitude;
		}
		
		/**
		 * X 轴中心坐标
		 */
		private var _x:Number;
		public function get x():Number 
		{
			return _x;
		}
		public function set x(value:Number):void 
		{
			_x = value;
			update();
		}
		
		/**
		 * Y 轴中心坐标
		 */
		private var _y:Number;
		public function get y():Number 
		{
			return _y;
		}
		public function set y(value:Number):void 
		{
			_y = value;
			update();
		}
		
		/**
		 * Z 轴中心坐标
		 */
		public function get z():Number
		{
			return bottom + altitude * 0.5;
		}
		public function set z(value:Number):void 
		{
			bottom = value - altitude * 0.5;
			update();
		}
		
		//==========
		// 方法
		//==========
		
		/**
		 * 更新单位的位置
		 */
		public function update():void 
		{
			if (!unit) return;
			
			unit.x = _x;
			unit.y = _y + bottom;
		}
		
		/**
		 * 更新成下一帧的位置信息
		 */
		public function advance(deltaTime:Number):void 
		{
			_x += vx;
			_y += vy;
			z += vz;
			update();
		}
		
		/**
		 * 根据点设置坐标
		 * @param	point
		 */
		public function setByPoint(point:Point):void 
		{
			x = point.x;
			y = point.y;
		}
	}
}