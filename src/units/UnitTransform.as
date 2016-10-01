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
		 * z 轴高度，从 z 轴底部坐标（bottom）到 z 轴顶部坐标（top）的高度
		 */
		public var altitude:Number = 0.0;
		
		/**
		 * 朝向，单位的图片根据朝向设定
		 */
		public var orientation:Number = 90.0;
		
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
		private var _x:Number = 0.0;
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
		private var _y:Number = 0.0;
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
		
		/**
		 * 底部坐标
		 */
		private var _bottom:Number = 0.0;
		public function get bottom():Number 
		{
			return _bottom;
		}
		public function set bottom(value:Number):void 
		{
			_bottom = value;
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
			unit.y = _y;
			unit.body.y = - unit.radius * 0.5 - bottom;
		}
		
		/**
		 * 更新成下一帧的位置信息
		 */
		public function advance(deltaTime:Number):void 
		{
			_x += vx * deltaTime;
			_y += vy * deltaTime;
			z += vz * deltaTime;
			update();
		}
		
		/**
		 * 根据点设置坐标
		 * @param	point
		 */
		public function setByPoint(point:Point):void 
		{
			_x = point.x;
			_y = point.y;
			update();
		}
		
		/**
		 * 根据 UnitTransform 设置位置信息，不设置速度信息
		 * @param	unitTransform
		 */
		public function setByUnitTransform(unitTransform:UnitTransform):void 
		{
			_x = unitTransform._x;
			_y = unitTransform._y;
			z = unitTransform.z;
			orientation = unitTransform.orientation;
			update();
		}
	}
}