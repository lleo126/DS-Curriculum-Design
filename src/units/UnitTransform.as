package units 
{
	import flash.geom.Point;
	/**
	 * 单位的位置、速度和碰撞信息，与单位绑定
	 * @author 彩月葵☆彡
	 */
	public class UnitTransform 
	{
		/**
		 * 求两个切点
		 * @param	pointUnitTransform	发出射线的点
		 * @param	circleUnitTransform	圆
		 * @return	Vector.<UnitTransform>(2, true)	表示两个切点
		 */
		public static function getSupportUnitTransforms(pointUnitTransform:UnitTransform, circleUnitTransform:UnitTransform):Vector.<UnitTransform> 
		{
			var res:Vector.<UnitTransform> = new Vector.<UnitTransform>(2, true);
			
			// TODO (翔宇): 求切点
			
			return res;
		}
		
		public function UnitTransform(unit:Unit)
		{
			this.unit = unit;
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
			return z + altitude;
		}
		
		/**
		 * X 轴坐标
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
		 * Y 轴坐标
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
		 * Z 轴坐标
		 */
		private var _z:Number = 0.0;
		public function get z():Number 
		{
			return _z;
		}
		public function set z(value:Number):void 
		{
			_z = value;
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
			unit.body.y = - z;
		}
		
		/**
		 * 更新成下一帧的位置信息
		 */
		public function advance(deltaTime:Number):void 
		{
			_x += vx * deltaTime;
			_y += vy * deltaTime;
			_z += vz * deltaTime;
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
			_z = unitTransform._z;
			orientation = unitTransform.orientation;
			update();
		}
	}
}