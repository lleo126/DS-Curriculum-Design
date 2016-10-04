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
		 * 一个为发出射线的点，一个为椭球的球心
		 * 以发出射线的点所在水平面截椭球，降三维为二维
		 * 然后从这点发出两条切线，切刚才截出的圆为两点，求这两点
		 * @param	pointUnitTransform	发出射线的点
		 * @param	circleUnitTransform	球心
		 * @return	两个切点
		 */
		public static function getSupportUnitTransforms(pointUnitTransform:UnitTransform, circleUnitTransform:UnitTransform):Vector.<UnitTransform> 
		{
			var res:Vector.<UnitTransform> = new Vector.<UnitTransform>(2, true);
			
			// 圆心坐标
			var a:Number, b:Number;
			// 半径
			var r:Number;
			// 圆外该点的座标
			var m:Number = pointUnitTransform.x;
			var n:Number = pointUnitTransform.y;
			// 点到圆心距离的平方
			var d2:Number = (m - a) * (m - a) + (n - b) * (n - b);
			// 点到圆心距离
			var d:Number  = Math.sqrt( d2 );
			// 半径的平方
			var r2:Number = r * r;
			if ( d2 < r2 )
			{
				trace("点在圆内，无切点");
			}
			else if ( d2 == r2 )
			{
				trace("点在圆上，切点为给定点");
			}
			else
			{
				// 点到切点距离
				var l:Number = Math.sqrt( d2 - r2 );
				// 点->圆心的单位向量
				var x0:Number = ( a - m ) / d;
				var y0:Number = ( b - n ) / d;
				// 计算切线与点心连线的夹角
				var f:Number = Math.asin( r / d );
				// 向正反两个方向旋转单位向量
				var x1:Number = x0 * Math.cos( f ) - y0 * Math.sin( f );
				var y1:Number = x0 * Math.sin( f ) + y0 * Math.cos( f );
				var x2:Number = x0 * Math.cos(-f ) - y0 * Math.sin(-f );
				var y2:Number = x0 * Math.sin(-f ) + y0 * Math.cos(-f );
				// 得到新座标
				x1 = ( x1 + m ) * l;
				y1 = ( y1 + n ) * l;
				x2 = ( x2 + m ) * l;
				y2 = ( y2 + n ) * l;
				// 将坐标值赋值
				
			}
			
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
		
		/**
		 * 所属的 unit
		 */
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
			return z + altitude;
		}
		
		private var _x:Number = 0.0;
		/**
		 * X 轴坐标
		 */
		public function get x():Number 
		{
			return _x;
		}
		public function set x(value:Number):void 
		{
			_x = value;
			update();
		}
		
		private var _y:Number = 0.0;
		/**
		 * Y 轴坐标
		 */
		public function get y():Number 
		{
			return _y;
		}
		public function set y(value:Number):void 
		{
			_y = value;
			update();
		}
		
		private var _z:Number = 0.0;
		/**
		 * Z 轴坐标
		 */
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