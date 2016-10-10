package units 
{
	import asunit.errors.UnimplementedFeatureError;
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
		 * @return	若在水平面上有四个切点，则数组有四个元素表示切点；否则为空数组
		 */
		public static function getSupportUnitTransforms(pointUnitTransform:UnitTransform, circleUnitTransform:UnitTransform):Vector.<UnitTransform> 
		{
			var res:Vector.<UnitTransform>;
				
			// 截出的圆的圆心坐标
			var p_x:Number = circleUnitTransform._x;
			var p_y:Number = circleUnitTransform._y;
			var dz:Number = Math.abs(pointUnitTransform.centerZ - circleUnitTransform.centerZ);
			if (circleUnitTransform.radiusZ <= dz) return res; // 水平面截不到圆
			
			res = new <UnitTransform>[];
			
			// 截出的圆的半径
			var r:Number = circleUnitTransform.radius / circleUnitTransform.radiusZ * Math.sqrt((circleUnitTransform.radiusZ + dz) * (circleUnitTransform.radiusZ - dz));
		
			// 圆外该点的座标
			var sp_x:Number = pointUnitTransform.x,
				sp_y:Number = pointUnitTransform.y;
				
			// 截出圆的圆心与圆外该点的中点设为圆心
			var p2_x:Number = (p_x + sp_x) / 2,
				p2_y:Number = (p_y + sp_y) / 2;
			
			// 求新圆的半径
			var dx2:Number = p2_x - p_x, 
				dy2:Number = p2_y - p_y,
				r2:Number = Math.sqrt(dx2 * dx2 + dy2 * dy2); 
			
			var a:Number = dx2, 
				b:Number = dy2,
				r1:Number = (a * a + b * b + r * r - r2 * r2) / 2; 
			
			// 两切点坐标
			var rp1_x:Number, rp1_y:Number,
				rp2_x:Number, rp2_y:Number;
			
			if(a==0&&b!=0)
			{ 
					rp1_y = rp2_y = r1 / b;
					rp1_x = Math.sqrt(r * r - rp1_y * rp1_y); 
					rp2_x=-rp1_x; 
			} 
			else if(a!=0&&b==0) 
			{ 
					rp1_x = rp2_x = r1 / a; 
					rp1_y = Math.sqrt(r * r - rp1_x * rp2_x); 
					rp2_y =-rp1_y; 
			} 
			else if(a!=0&&b!=0) 
			{  
					var delta:Number = b * b * r1 * r1 - (a * a + b * b) * (r1 * r1 - r * r * a * a);
					rp1_y = (b * r1 + Math.sqrt(delta)) / (a * a + b * b); 
					rp2_y = (b * r1 - Math.sqrt(delta)) / (a * a + b * b); 
					rp1_x = (r1 - b * rp1_y) / a; 
					rp2_x = (r1 - b * rp2_y) / a; 
			} 

			// 将两切点坐标值赋值
			res.push(new UnitTransform(), new UnitTransform());
			
			res[0]._x = rp1_x + p_x;
			res[0]._y = rp1_y + p_y;
			res[0]._z = pointUnitTransform._z;
			
			res[1]._x = rp2_x + p_x;
			res[1]._y = rp2_y + p_y;
			res[1]._z = pointUnitTransform._z;

			// 两切点的中点到圆心的连线
			var L:Number = Math.sqrt( ( (res[0]._x + res[1]._x) / 2 - p_x ) * ( (res[0]._x + res[1]._x) / 2 - p_x )
									+ ( (res[0]._y + res[1]._y) / 2 - p_y ) * ( (res[0]._y + res[1]._y) / 2 - p_y ) );
			
			if (L < pointUnitTransform.radius)
			{
				res.push(new UnitTransform(), new UnitTransform());
				// 求两切于大圆的直线交圆心与小圆切点连线的交点
				var	x3:Number = p_x + (res[0]._x - p_x) * pointUnitTransform.radius * Snowball.ATTACK_RANGE_RATIO / L,
					y3:Number = p_y + (res[0]._y - p_y) * pointUnitTransform.radius * Snowball.ATTACK_RANGE_RATIO / L,
					x4:Number = p_x + (res[1]._x - p_x) * pointUnitTransform.radius * Snowball.ATTACK_RANGE_RATIO / L,
					y4:Number = p_y + (res[1]._y - p_y) * pointUnitTransform.radius * Snowball.ATTACK_RANGE_RATIO / L;
									
				res[2]._x = x3;
				res[2]._y = y3;
				res[2]._z = pointUnitTransform._z;
				
				res[3]._x = x4;
				res[3]._y = y4;
				res[3]._z = pointUnitTransform._z;
				
				return res;
			}
			return null;
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