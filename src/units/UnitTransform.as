package units 
{
	import flash.geom.Point;
	/**
	 * 单位的位置、速度和碰撞信息，与单位绑定
	 * @author 彩月葵☆彡
	 */
	public class UnitTransform 
	{
		public static function globalToLocal(global:UnitTransform, parent:UnitTransform):UnitTransform
		{
			var local:UnitTransform = global.clone();
			local._x -= parent._x;
			local._y -= parent._y;
			local._z -= parent._z;
			return local;
		}
		
		/**
		 * 一个为发出射线的点，一个为椭球的球心
		 * 以发出射线的点所在水平面截椭球，降三维为二维
		 * 然后从这点发出两条切线，切刚才截出的圆为两点，求这两点与发出射线的点连线于圆的切线组成的梯形
		 * @param	pointUt		发出射线的点
		 * @param	circleUt	球心
		 * @return	若在水平面上有四个切点，则数组有四个元素表示切点；否则为空数组
		 */
		public static function getSupportUnitTransforms(pointUt:UnitTransform, circleUt:UnitTransform):Vector.<UnitTransform> 
		{
			// 截出的圆的圆心坐标
			var p_x:Number = circleUt._x;
			var p_y:Number = circleUt._y;
			//var dz:Number = Math.abs(pointUt.centerZ - circleUt.centerZ);
			//if (circleUt.radiusZ <= dz) return res; // 水平面截不到圆
			
			// 截出的圆的半径
			//var r:Number = circleUt.radius / circleUt.radiusZ * Math.sqrt((circleUt.radiusZ + dz) * (circleUt.radiusZ - dz));
			var r:Number = circleUt.getRadiusOn(pointUt.centerZ);
			if (isNaN(r)) return null;
		
			var res:Vector.<UnitTransform> = new <UnitTransform>[];	
		
			// 圆外该点的座标
			var sp_x:Number = pointUt.x,
				sp_y:Number = pointUt.y,
				sp_cz:Number = pointUt.centerZ,
				sp_r:Number = pointUt.radius * Snowball.ATTACK_RANGE_RATIO; // TODO: 传进来时半径先变大
				
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
			res[0]._z = sp_cz;
			
			res[1]._x = rp2_x + p_x;
			res[1]._y = rp2_y + p_y;
			res[1]._z = sp_cz;

			// 两切点的中点到圆心的连线
			var L:Number = Math.sqrt( ( (res[0]._x + res[1]._x) / 2 - sp_x ) * ( (res[0]._x + res[1]._x) / 2 - sp_x )
									+ ( (res[0]._y + res[1]._y) / 2 - sp_y ) * ( (res[0]._y + res[1]._y) / 2 - sp_y ) );
			
			if (L < sp_r)
			{
				res.push(new UnitTransform(), new UnitTransform());
				// 求两切于大圆的直线交圆心与小圆切点连线的交点
				var	x3:Number = sp_x + (res[0]._x - sp_x) * sp_r / L,
					y3:Number = sp_y + (res[0]._y - sp_y) * sp_r / L,
					x4:Number = sp_x + (res[1]._x - sp_x) * sp_r / L,
					y4:Number = sp_y + (res[1]._y - sp_y) * sp_r / L;
									
				res[3]._x = x3;
				res[3]._y = y3;
				res[3]._z = sp_cz;
				
				res[2]._x = x4;
				res[2]._y = y4;
				res[2]._z = sp_cz;
				
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
			return Math.sqrt((ut1.x - ut2.x) * (ut1.x - ut2.x) + (ut1.y - ut2.y) * (ut1.y - ut2.y) + (ut1.centerZ - ut2.centerZ) * (ut1.centerZ - ut2.centerZ));
		}
		
		public static function area2(p:UnitTransform, q:UnitTransform, r:UnitTransform):Number
		{
			return	p.x * q.y - p.y * q.x
				+	q.x * r.y - q.y * r.x
				+	r.x * p.y - r.y * p.x;
		}
		
		public static function toLeft(p:UnitTransform, q:UnitTransform, r:UnitTransform):Boolean
		{
			var s2:Number = area2(p, q, r);
			if (0.0 < s2) return true;
			if (s2 < 0.0) return false;
			return between(p, q, r);
		}
		
		public static function toRight(p:UnitTransform, q:UnitTransform, r:UnitTransform):Boolean
		{
			var s2:Number = area2(p, q, r);
			if (0.0 < s2) return false;
			if (s2 < 0.0) return true;
			return between(p, q, r);
		}
		
		public static function between(p:UnitTransform, q:UnitTransform, r:UnitTransform):Boolean
		{
			return 0.0 < (q.x - p.x) * (r.x - q.x) + (q.y - p.y) * (r.y - q.y);
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
		private var _orientation:Number = 90.0;
		
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
		
		public function get orientation():Number 
		{
			return _orientation;
		}
		
		public function set orientation(value:Number):void 
		{
			_orientation = (value + 360.0) % 360.0;
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
			unit.body.y = -z;
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
		 * 获取该 UnitTransform 在给定水平面上截出的半径
		 * @param	zLevel	水平面 Z 轴坐标
		 * @return	截出的半径，若截不出则返回 NaN
		 */
		public function getRadiusOn(zLevel:Number):Number
		{
			var dz:Number = Math.abs(zLevel - centerZ);
			if (radiusZ <= dz) return NaN; // 水平面截不到圆
			
			return radius / radiusZ * Math.sqrt((radiusZ + dz) * (radiusZ - dz));
		}
		
		/**
		 * 判断此 UnitTransform 所在水平面与所给 UnitTransform 是否有交
		 * @param	ut
		 * @return	true 表示有交
		 */
		public function determineCross(ut:UnitTransform):Boolean
		{
			return ut.radiusZ <= Math.abs(centerZ - ut.centerZ);
		}
		
		[obsolete]
		public function getSupportUnitTransform(target:UnitTransform):UnitTransform
		{
			var vx:Number = this.vx,
				vy:Number = this.vy,
				vz:Number = this.vz,
				x1:Number = _x,
				y1:Number = _y,
				z1:Number = _z,
				x2:Number = target._x,
				y2:Number = target._y,
				z2:Number = target._z,
				dx:Number = x1 - x2,
				dy:Number = y1 - y2,
				dz:Number = z1 - z2,
				r12:Number = radius * radius,
				r1z2:Number = radiusZ * radiusZ,
				r22:Number = target.radius * target.radius,
				r2z2:Number = target.radiusZ * target.radiusZ,
				k1:Number = (vx * vx + vy * vy) / r22 + vz * vz / r2z2,
				k2:Number = (vx * vx + vy * vy) / r12 + vz * vz / r1z2,
				k3:Number = (dx * dx + dy * dy) / r22 + dz * dz / r2z2,
				k4:Number = (dx * dx + dy * dy) / r12 + dz * dz / r1z2,
				a:Number = k1 * k4 - k2 * k3,
				b:Number = 2.0 * (k2 * k3 - k1 * k4),
				c:Number = k2 - k1 - k2 * k3 + k1 * k4,
				d:Number = -2.0 * k2,
				e:Number = k2,
				discriminant:Number = 256.0 * a * a * a * e * e * e - 192.0 * a * a * b * d * e * e - 128.0 * a * a * c * c * e * e + 144.0 * a * a * c * d * d * e - 27.0 * a * a * d * d * d * d + 144.0 * a * b * b * c * e * e - 6.0 * a * b * b * d * d * e - 80.0 * a * b * c * c * d * e + 18.0 * a * b * c * d * d * d + 16.0 * a * c * c * c * c * e - 4.0 * a * c * c * c * d * d - 27.0 * b * b * b * b * e * e + 18.0 * b * b * b * c * d * e - 4.0 * b * b * b * d * d * d - 4.0 * b * b * c * c * c * e + b * b * c * c * d * d;
			if (Math.abs(discriminant) < 1e-6) 
			{
				//trace('almost zero');
			}
			else 
			{
				throw new Error('unexpected non-zero discriminant');
			}
			var discriminant0:Number = c * c - 3.0 * b * d + 12.0 * a * e;
			if (Math.abs(discriminant0) < 1e-6) 
			{
				trace('almost zero');
			}
			else 
			{
				trace(discriminant0 < 0 ? 'negative' : 'positive');
				//if (discriminant < 0)
				//{
					//throw new Error('unexpected negitive discriminant0');
					//
				//}
			}
			var p:Number = 8.0 * a * c - 3.0 * b * b,
				q:Number = b * b * b + 8.0 * d * a * a - 4.0 * a * b * c,
				discriminant1:Number = 2.0 * c * c * c - 9.0 * b * c * d + 27.0 * b * b * e + 27.0 * a * d * d - 72.0 * a * c * e,
				Q:Number = Math.pow(0.5 * (discriminant1 + Math.sqrt(discriminant1 * discriminant1 - 4.0 * discriminant0 * discriminant0 * discriminant0)) , 1.0 / 3.0),
				S:Number = 0.5 * Math.sqrt( - 2.0 / 3.0 * p + 1.0 / (3.0 * a) * (Q + discriminant0 / Q));
				//u1:Number = -b / (4.0 * a) - S + 0.5 * Math.sqrt(-4.0 * S * S - 2.0 * p + q / S),
				//u2:Number = -b / (4.0 * a) - S - 0.5 * Math.sqrt(-4.0 * S * S - 2.0 * p + q / S),
				//u3:Number = -b / (4.0 * a) + S + 0.5 * Math.sqrt(-4.0 * S * S - 2.0 * p + q / S),
				//u4:Number = -b / (4.0 * a) + S - 0.5 * Math.sqrt(-4.0 * S * S - 2.0 * p + q / S);
				//u1:Number = -1 / 2 * Math.sqrt((2 ^ (1 / 3) * (k_4 * k_1 - k_1 + k_2 - k_2 * k_3) ^ 2) / (3 * (k_2 * k_3 - k_1 * k_4) * (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4) + Math.sqrt((2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4)) ^ 2 - 4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 6)) ^ (1 / 3)) - (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3)) / (3 * (k_2 * k_3 - k_1 * k_4)) + (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4) + Math.sqrt((2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4)) ^ 2 - 4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 6)) ^ (1 / 3) / (3 * 2 ^ (1 / 3) * (k_2 * k_3 - k_1 * k_4)) + 1) - 1 / 2 * Math.sqrt( -(2 ^ (1 / 3) * (k_4 * k_1 - k_1 + k_2 - k_2 * k_3) ^ 2) / (3 * (k_2 * k_3 - k_1 * k_4) * (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4) + Math.sqrt((2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4)) ^ 2 - 4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 6)) ^ (1 / 3)) - (4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3)) / (3 * (k_2 * k_3 - k_1 * k_4)) - (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4) + Math.sqrt((2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4)) ^ 2 - 4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 6)) ^ (1 / 3) / (3 * 2 ^ (1 / 3) * (k_2 * k_3 - k_1 * k_4)) - ( -(16 * k_2) / (k_2 * k_3 - k_1 * k_4) - (8 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3)) / (k_2 * k_3 - k_1 * k_4) + 8) / (4 * Math.sqrt((2 ^ (1 / 3) * (k_4 * k_1 - k_1 + k_2 - k_2 * k_3) ^ 2) / (3 * (k_2 * k_3 - k_1 * k_4) * (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4) + Math.sqrt((2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4)) ^ 2 - 4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 6)) ^ (1 / 3)) - (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3)) / (3 * (k_2 * k_3 - k_1 * k_4)) + (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4) + Math.sqrt((2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4)) ^ 2 - 4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 6)) ^ (1 / 3) / (3 * 2 ^ (1 / 3) * (k_2 * k_3 - k_1 * k_4)) + 1)) + 2) + 1 / 2,
				//u2:Number = -1 / 2 * Math.sqrt((2 ^ (1 / 3) * (k_4 * k_1 - k_1 + k_2 - k_2 * k_3) ^ 2) / (3 * (k_2 * k_3 - k_1 * k_4) * (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4) + Math.sqrt((2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4)) ^ 2 - 4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 6)) ^ (1 / 3)) - (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3)) / (3 * (k_2 * k_3 - k_1 * k_4)) + (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4) + Math.sqrt((2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4)) ^ 2 - 4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 6)) ^ (1 / 3) / (3 * 2 ^ (1 / 3) * (k_2 * k_3 - k_1 * k_4)) + 1) + 1 / 2 * Math.sqrt( -(2 ^ (1 / 3) * (k_4 * k_1 - k_1 + k_2 - k_2 * k_3) ^ 2) / (3 * (k_2 * k_3 - k_1 * k_4) * (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4) + Math.sqrt((2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4)) ^ 2 - 4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 6)) ^ (1 / 3)) - (4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3)) / (3 * (k_2 * k_3 - k_1 * k_4)) - (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4) + Math.sqrt((2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4)) ^ 2 - 4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 6)) ^ (1 / 3) / (3 * 2 ^ (1 / 3) * (k_2 * k_3 - k_1 * k_4)) - ( -(16 * k_2) / (k_2 * k_3 - k_1 * k_4) - (8 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3)) / (k_2 * k_3 - k_1 * k_4) + 8) / (4 * Math.sqrt((2 ^ (1 / 3) * (k_4 * k_1 - k_1 + k_2 - k_2 * k_3) ^ 2) / (3 * (k_2 * k_3 - k_1 * k_4) * (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4) + Math.sqrt((2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4)) ^ 2 - 4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 6)) ^ (1 / 3)) - (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3)) / (3 * (k_2 * k_3 - k_1 * k_4)) + (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4) + Math.sqrt((2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4)) ^ 2 - 4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 6)) ^ (1 / 3) / (3 * 2 ^ (1 / 3) * (k_2 * k_3 - k_1 * k_4)) + 1)) + 2) + 1 / 2,
				//u3:Number = 1 / 2 * Math.sqrt((2 ^ (1 / 3) * (k_4 * k_1 - k_1 + k_2 - k_2 * k_3) ^ 2) / (3 * (k_2 * k_3 - k_1 * k_4) * (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4) + Math.sqrt((2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4)) ^ 2 - 4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 6)) ^ (1 / 3)) - (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3)) / (3 * (k_2 * k_3 - k_1 * k_4)) + (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4) + Math.sqrt((2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4)) ^ 2 - 4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 6)) ^ (1 / 3) / (3 * 2 ^ (1 / 3) * (k_2 * k_3 - k_1 * k_4)) + 1) - 1 / 2 * Math.sqrt( -(2 ^ (1 / 3) * (k_4 * k_1 - k_1 + k_2 - k_2 * k_3) ^ 2) / (3 * (k_2 * k_3 - k_1 * k_4) * (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4) + Math.sqrt((2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4)) ^ 2 - 4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 6)) ^ (1 / 3)) - (4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3)) / (3 * (k_2 * k_3 - k_1 * k_4)) - (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4) + Math.sqrt((2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4)) ^ 2 - 4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 6)) ^ (1 / 3) / (3 * 2 ^ (1 / 3) * (k_2 * k_3 - k_1 * k_4)) + ( -(16 * k_2) / (k_2 * k_3 - k_1 * k_4) - (8 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3)) / (k_2 * k_3 - k_1 * k_4) + 8) / (4 * Math.sqrt((2 ^ (1 / 3) * (k_4 * k_1 - k_1 + k_2 - k_2 * k_3) ^ 2) / (3 * (k_2 * k_3 - k_1 * k_4) * (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4) + Math.sqrt((2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4)) ^ 2 - 4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 6)) ^ (1 / 3)) - (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3)) / (3 * (k_2 * k_3 - k_1 * k_4)) + (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4) + Math.sqrt((2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4)) ^ 2 - 4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 6)) ^ (1 / 3) / (3 * 2 ^ (1 / 3) * (k_2 * k_3 - k_1 * k_4)) + 1)) + 2) + 1 / 2,
				//u4:Number = 1 / 2 * Math.sqrt((2 ^ (1 / 3) * (k_4 * k_1 - k_1 + k_2 - k_2 * k_3) ^ 2) / (3 * (k_2 * k_3 - k_1 * k_4) * (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4) + Math.sqrt((2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4)) ^ 2 - 4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 6)) ^ (1 / 3)) - (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3)) / (3 * (k_2 * k_3 - k_1 * k_4)) + (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4) + Math.sqrt((2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4)) ^ 2 - 4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 6)) ^ (1 / 3) / (3 * 2 ^ (1 / 3) * (k_2 * k_3 - k_1 * k_4)) + 1) + 1 / 2 * Math.sqrt( -(2 ^ (1 / 3) * (k_4 * k_1 - k_1 + k_2 - k_2 * k_3) ^ 2) / (3 * (k_2 * k_3 - k_1 * k_4) * (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4) + Math.sqrt((2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4)) ^ 2 - 4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 6)) ^ (1 / 3)) - (4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3)) / (3 * (k_2 * k_3 - k_1 * k_4)) - (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4) + Math.sqrt((2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4)) ^ 2 - 4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 6)) ^ (1 / 3) / (3 * 2 ^ (1 / 3) * (k_2 * k_3 - k_1 * k_4)) + ( -(16 * k_2) / (k_2 * k_3 - k_1 * k_4) - (8 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3)) / (k_2 * k_3 - k_1 * k_4) + 8) / (4 * Math.sqrt((2 ^ (1 / 3) * (k_4 * k_1 - k_1 + k_2 - k_2 * k_3) ^ 2) / (3 * (k_2 * k_3 - k_1 * k_4) * (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4) + Math.sqrt((2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4)) ^ 2 - 4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 6)) ^ (1 / 3)) - (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3)) / (3 * (k_2 * k_3 - k_1 * k_4)) + (2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4) + Math.sqrt((2 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 3 + 108 * k_2 * (k_2 * k_3 - k_1 * k_4) * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) - 108 * k_2 * (k_2 * k_3 - k_1 * k_4) ^ 2 + 108 * k_2 ^ 2 * (k_2 * k_3 - k_1 * k_4)) ^ 2 - 4 * ( -k_4 * k_1 + k_1 - k_2 + k_2 * k_3) ^ 6)) ^ (1 / 3) / (3 * 2 ^ (1 / 3) * (k_2 * k_3 - k_1 * k_4)) + 1)) + 2) + 1 / 2,
				//u5:Number = Math.sqrt(k2) / (Math.sqrt(k2) - Math.sqrt(k1));
			//trace(u1, u2, u3, u4, u5);
				
			return null;
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
			_orientation = unitTransform._orientation;
			update();
		}
		
		/**
		 * 复制一份 UnitTransform，不复制所属单位信息
		 * @return
		 */
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
		
		/**
		 * 判断此 UnitTransform 的注册点在不在由所给 UnitTransform 数组定义的多边形内（XoY面投影）
		 * @param	uts	多边形
		 * @return	true 为在多边形内
		 */
		public function inPolygon(uts:Vector.<units.UnitTransform>):Boolean
		{
			return allEqual.call(this, toLeft) || allEqual.call(this, toRight);
			
			function allEqual(func:Function):Boolean
			{
				var res:Boolean = func(uts[0], uts[1], this), i:int;
				for (i = 1; i < uts.length - 1; i++) 
				{
					if (func(uts[i], uts[i + 1], this) != res) return false;
				}
				return func(uts[i], uts[0], this) == res;
			}
		}
		
		public function toString():String
		{
			return '{' +
				_x.toString() + ' ' +
				_y.toString() + ' ' +
				_z.toString() + ' ' +
				speed.toString() + ' ' +
				vx.toString() + ' ' +
				vy.toString() + ' ' +
				vz.toString() + ' ' +
				radius.toString() + ' ' +
				altitude.toString() + ' ' +
				_orientation.toString() + '}';
		}
	}
}