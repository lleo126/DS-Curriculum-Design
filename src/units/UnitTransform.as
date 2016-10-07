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
		 * @return	若在水平面上有两个切点，则数组有两个元素表示切点；否则为空数组
		 */
		public static function getSupportUnitTransforms(pointUnitTransform:UnitTransform, circleUnitTransform:UnitTransform):Vector.<UnitTransform> 
		{
			var res:Vector.<UnitTransform> = new <UnitTransform>[];
			
			// 圆心坐标 (待测试)
			var a:Number = circleUnitTransform._x, b:Number = circleUnitTransform._y;
			var dz:Number = Math.abs(pointUnitTransform.centerZ - circleUnitTransform.centerZ);
			if (circleUnitTransform.radiusZ <= dz) return res; // 水平面截不到圆
			
			// 半径 (待测试)
			var r:Number = circleUnitTransform.radius * circleUnitTransform.radiusZ * Math.sqrt((circleUnitTransform.radiusZ + dz) * (circleUnitTransform.radiusZ - dz));
			
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
				//trace("点在圆内，无切点");
			}
			else if ( d2 == r2 )
			{
				//trace("点在圆上，切点为给定点");
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
				
				res.push(new UnitTransform(), new UnitTransform());
				
				res[0]._x = x1;
				res[0]._y = y1;
				res[0]._z = pointUnitTransform._z;
				
				res[1]._x = x2;
				res[1]._y = y2;
				res[1]._z = pointUnitTransform._z;
			}
			
			return res;
		}
		
		[inline]
		/**
		 * 计算两个 UnitTransform 的中点连线距离
		 * @param	ut1
		 * @param	ut2
		 * @return	两个 UnitTransform 的中点连线距离
		 */
		public static function getDistance(ut1:UnitTransform, ut2:UnitTransform):Number
		{
			return Math.sqrt((ut1.x - ut2.x) * (ut1.x - ut2.x) + (ut1.y - ut2.y) * (ut1.y - ut2.y) + (ut1.centerZ - ut2.z) * (ut1.centerZ - ut2.centerZ));
		}
		
		public function UnitTransform(unit:Unit = null)
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
		
		private var _speed:Number = 0.0;
		private var _x:Number = 0.0;
		private var _y:Number = 0.0;
		private var _z:Number = 0.0;
		
		//==========
		// 属性
		//==========
		
		/**
		 * X 和 Y 分量上的总移动速度
		 */
		public function get speed():Number { return _speed; }
		public function set speed(value:Number):void 
		{
			_speed = Math.min(value, unit.maxSpeed);
		}
		
		/**
		 * X 方向上移动速度
		 */
		public function get vx():Number { return speed * Math.cos(orientation * Math.PI / 180); }
		
		/**
		 * Y 方向上移动速度
		 */
		public function get vy():Number { return speed * Math.sin(orientation * Math.PI / 180); }
		
		/**
		 * Z 轴顶部坐标
		 */
		public function get top():Number { return _z + altitude; }
		
		/**
		 * X 轴坐标
		 */
		public function get x():Number { return _x; }
		public function set x(value:Number):void 
		{
			_x = value;
			update();
		}
		
		/**
		 * Y 轴坐标
		 */
		public function get y():Number { return _y; }
		public function set y(value:Number):void 
		{
			_y = value;
			update();
		}
		
		/**
		 * Z 轴坐标（底部）
		 */
		public function get z():Number { return _z; }
		public function set z(value:Number):void 
		{
			_z = value;
			update();
		}
		
		/**
		 * Z 轴坐标（中部）
		 */
		public function get centerZ():Number { return _z + altitude * 0.5; }
		public function set centerZ(value:Number):void 
		{
			_z = value - altitude * 0.5;
		}
		
		/**
		 * Z 轴半径
		 */
		public function get radiusZ():Number { return altitude * 0.5; }
		
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
		 * 获取从此 UnitTransform 中心到目标点连线与此 UnitTransform 的交点（此方向的面上的点）
		 * @param	target	目标 UnitTransform
		 * @return	交点
		 */
		public function getUnitTransformOnSurface(targetX:Number, targetY:Number, targetZ:Number):UnitTransform
		{
			var dx:Number	= targetX - _x,
				dy:Number	= targetY - _y,
				dz:Number	= targetZ - centerZ,
				r2:Number	= radius * radius,
				rz2:Number	= radiusZ * radiusZ,
				A:Number	= (dx * dx + dy * dy) / r2 + dz * dz / rz2,
				C:Number	= -1.0,
				discriminant:Number = -4.0 * A * C,
 				t:Number	=  0.5 * Math.sqrt(discriminant) / A;
			//if (t < 0.0) t = -t;
			var res:UnitTransform = new UnitTransform();
			res._x = _x + dx * t;
			res._y = _y + dy * t;
			res._z = centerZ + dz * t;
			return res;
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
		
		public function clone():UnitTransform
		{
			var ut:UnitTransform = new UnitTransform();
			ut.vz = vz;
			ut.altitude = altitude;
			ut.radius = radius;
			ut._speed = _speed;
			ut.setByUnitTransform(this);
			return ut;
		}
	}
}