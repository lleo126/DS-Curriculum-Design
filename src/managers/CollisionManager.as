package managers 
{
	import animations.SnowballExplosionAnimation;
	import assets.AssetManager;
	import events.UnitEvent;
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	import units.Effect;
	import units.Hero;
	import units.Item;
	import units.Monster;
	import units.Obstacle;
	import units.Snowball;
	import units.Unit;
	import units.UnitTransform;
	import units.World;
	
	/**
	 * 碰撞管理器
	 * 碰撞检测分为两个阶段：
	 * 	1. 检测阶段：检测所有需检测的可能的碰撞，记录每个单位的候选碰撞对象（因为碰撞对象可能有多个候选，取最近的那个）
	 * 	2. 修正阶段：根据确定的碰撞对象，修正单位的位置和速度
	 * @author 彩月葵☆彡
	 */
	public class CollisionManager 
	{
		public function CollisionManager
		(
			heros:Vector.<Hero>,
			snowballs:Vector.<Snowball>,
			monsters:Vector.<Monster>,
			obstacles:Vector.<Obstacle>,
			items:Vector.<Item>
		) 
		{
			this.heroes = heros;
			this.snowballs = snowballs;
			this.monsters = monsters;
			this.obstacles = obstacles;
			this.items = items;
		}
		
		//==========
		// 变量
		//==========
		
		public var world:World;
		private var heroes:Vector.<Hero>;
		private var snowballs:Vector.<Snowball>;
		private var monsters:Vector.<Monster>;
		private var obstacles:Vector.<Obstacle>;
		private var items:Vector.<Item>;
		
		/**
		 * Dictionary.<Unit, UnitTransform> 保存着每个 Unit 下一帧会到的位置
		 */
		private var next:Dictionary;
		
		/**
		 * Dictionary.<Unit, UnitTransform> 保存着每个 Unit 碰撞的位置
		 */
		private var bounce:Dictionary = new Dictionary();
		
		//==========
		// 方法
		//==========
		
		/**
		 * 检测两个单位的碰撞，刚好相碰也算碰撞
		 * @param	deltaTime
		 * @return	若碰撞到物体，则返回碰撞的位置，否则返回 null
		 */
		public function detect(ut1:UnitTransform, ut2:UnitTransform, deltaTime:int = 0):UnitTransform
		{
			if (!deltaTime) return detectStill(ut1, ut2) ? ut1 : null;
			
			var rm:Number = Math.max(ut1.radius, ut1.radiusZ, ut2.radius, ut2.radiusZ),
				vx:Number	= ut1.vx - ut2.vx,
				vy:Number	= ut1.vy - ut2.vy,
				vz:Number	= ut1.vz - ut2.vz,
				// TODO: 雪球 Z 轴加速度
				v0:Number	= Math.sqrt(vx * vx + vy * vy + vz * vz),
				s0:Number	= v0 * deltaTime,
				count:int	= Math.floor(s0 / rm) + 1,
				time:Number	= deltaTime / count,
				ut1p:UnitTransform = ut1.clone(),
				ut2p:UnitTransform = ut2.clone();
			while (count--) 
			{
				var out1p:UnitTransform = ut1p.clone();
				ut1p.advance(time);
				ut2p.advance(time);
				if (detectStill(ut1p, ut2p))
				{
					//trace('detected');
					var lo:UnitTransform = out1p,
						hi:UnitTransform = ut1p,
						mi:UnitTransform = lo.clone();
					do
					{
						mi.x = (lo.x + hi.x) * 0.5;
						mi.y = (lo.y + hi.y) * 0.5;
						mi.z = (lo.z + hi.z) * 0.5;
						if (detectStill(mi, ut2p))
						{
							hi = mi;
						}
						else 
						{
							lo = mi;
						}
					} while (1.0 < UnitTransform.getDistance(lo, hi))
					return lo;
				}
			}
			return null;
		}
		
		/**
		 * 检测两个静止单位之间有无碰撞
		 * @param	ut1
		 * @param	ut2
		 * @return	true 为碰撞
		 */
		public function detectStill(ut1:UnitTransform, ut2:UnitTransform):Boolean 
		{
			// 计算两椭球心到面距离
			var s1:UnitTransform = ut1.getUnitTransformOnSurface(ut2.x, ut2.y, ut2.centerZ),
				s2:UnitTransform = ut2.getUnitTransformOnSurface(ut1.x, ut1.y, ut1.centerZ),
				r1:Number = UnitTransform.getDistance(ut1, s1),
				r2:Number = UnitTransform.getDistance(ut2, s2),
				distance:Number = UnitTransform.getDistance(ut1, ut2);
			if (distance <= r1 + r2)
			{
				//trace( "ut1 : " + ut1.unit.name );
				//trace( "ut2 : " + ut2.unit.name );	
				//trace( "distance <= r1 + r2 : ", distance <= r1 + r2 );
			}
			return distance <= r1 + r2;
		}
		
		/**
		 * 检测所有单位的碰撞
		 */
		public function detectAll(deltaTime:int):void 
		{
			var i:int = 0, j:int = 0,
				res:UnitTransform;
			for (i = 0; i < heroes.length; ++i)
			{
				for (j = 0; j < monsters.length; ++j) 
				{
					res = detect(heroes[i].unitTransform, monsters[j].unitTransform, deltaTime);
					if (res) updateBounce(heroes[i], res);
				}
				
				for (j = 0; j < obstacles.length; ++j)
				{
					res = detect(heroes[i].unitTransform, obstacles[j].unitTransform, deltaTime);
					if (res) updateBounce(heroes[i], res);
				}
				
				for (j = 0; j < items.length; ++j)
				{
					res = detect(heroes[i].unitTransform, items[j].unitTransform, deltaTime);
					if (res)
					{
						heroes[i].dispatchEvent(new UnitEvent(UnitEvent.COLLIDED, items[j]));
						items[j].dispatchEvent(new UnitEvent(UnitEvent.COLLIDED, heroes[i]));
						items[j].removeFromWorld();
					}
				}
			}
			
			for (i = 0; i < snowballs.length; ++i)
			{
				for (j = 0; j < heroes.length; ++j)
				{
					res = detect(snowballs[i].unitTransform, heroes[j].unitTransform, deltaTime);
					if (res) updateBounce(snowballs[i], res);
				}
				
				for (j = i + 1; j < snowballs.length; ++j)
				{
					res = detect(snowballs[i].unitTransform, snowballs[j].unitTransform, deltaTime);
					if (res) updateBounce(snowballs[i], res);
				}
				
				for (j = 0; j < obstacles.length; ++j)
				{
					res = detect(snowballs[i].unitTransform, obstacles[j].unitTransform, deltaTime);
					if (res) updateBounce(snowballs[i], res);
				}
				
				// 临时：如果雪球撞到地面，就消失
				if (snowballs[i].unitTransform.z < 0.0) 
				{
					snowballExplode(snowballs[i]);
					snowballs[i].removeFromWorld();
				}
			}
			
			// 如果寻路正确，怪物将不会撞到障碍物上，不需要检测怪物与障碍物的碰撞
		}
		
		/**
		 * 如果单位新候选碰撞位置比原来的近，那么更新 bounce 数组为新的位置
		 * @param	unit
		 * @param	ut
		 */
		private function updateBounce(unit:Unit, ut:UnitTransform):void 
		{
			//trace( "CollisionManager.updateBounce > unit : " + unit + ", ut : " + ut );
			if (!(unit in bounce) || UnitTransform.getDistance(unit.unitTransform, ut) < UnitTransform.getDistance(unit.unitTransform, bounce[unit])) bounce[unit] = ut;
		}
		
		/**
		 * 获取两个单位的 XoY 平面投影之间的距离
		 * @param	unit
		 * @param	unit2
		 */
		public function getDistance(unitTransform:UnitTransform, unitTransform2:UnitTransform):Number
		{
			return Point.distance(new Point(unitTransform.x,	unitTransform.y),
								  new Point(unitTransform2.x,	unitTransform2.y));
		}
		
		/**
		 * 更新所有单位的位置和速度
		 */
		public function update(deltaTime:int):void 
		{
			var i:int;
			for (i = 0; i < heroes.length; ++i) 
			{
				if (heroes[i] in bounce) heroes[i].unitTransform = bounce[heroes[i]];
				else heroes[i].unitTransform.advance(deltaTime);
			}
			
			for (i = 0; i < snowballs.length; ++i) 
			{
				if (snowballs[i] in bounce)
				{
					snowballs[i].unitTransform = bounce[snowballs[i]];
					snowballExplode(snowballs[i]);
					snowballs[i].removeFromWorld();
				}
				else snowballs[i].unitTransform.advance(deltaTime);
			}
			
			//for (var key:* in bounce)
			//{
				//var unit:Unit = key as Unit;
				//if (unit in bounce) unit.unitTransform = bounce[unit];
				//else unit.unitTransform.advance(deltaTime);
			//}
			bounce = new Dictionary();
		}
		
		private function snowballExplode(snowball:Snowball):void 
		{
			AssetManager.soundEffect = new Sound();
			AssetManager.soundEffect.load(new URLRequest("music/Explode.mp3"));
			AssetManager.songEffect = AssetManager.soundEffect.play();
			AssetManager.songEffect.soundTransform = AssetManager.transEffect;
			var explosion:Effect = new Effect(new SnowballExplosionAnimation(explosion, snowball.attackRange));
			explosion.unitTransform.setByUnitTransform(snowball.unitTransform);
			world.addUnit(explosion);
			// TODO: 在 Animation 里提供接口
			setTimeout(function ():void 
			{
				explosion.removeFromWorld();
			}, 250);
			
			var shadows:Shape = new Shape();
			shadows.y -= explosion.unitTransform.z;
			shadows.blendMode = BlendMode.ERASE;
			explosion.blendMode = BlendMode.LAYER;
			explosion.addChild(shadows);
			
			var res:Vector.<UnitTransform>;
			for (var i:int = 0; i < obstacles.length; ++i) 
			{
				if (getDistance(snowball.unitTransform, obstacles[i].unitTransform) <= snowball.attackRange + obstacles[i].unitTransform.radius)
				{
					res = UnitTransform.getSupportUnitTransforms(snowball.unitTransform, obstacles[i].unitTransform);
					if (!res) continue;
					
					for (var j:int = 0; j < res.length; ++j)
					{
						res[j] = UnitTransform.globalToLocal(res[j], explosion.unitTransform);
					}
					
					// 遮蔽障碍物
					shadows.graphics.beginFill(0x2EEAAF);
					var localObstacleUnitTransform:UnitTransform = UnitTransform.globalToLocal(obstacles[i].unitTransform, explosion.unitTransform);
					shadows.graphics.drawCircle(localObstacleUnitTransform.x, localObstacleUnitTransform.y, obstacles[i].unitTransform.radius);
					shadows.graphics.endFill();
					
					// 遮蔽梯形
					shadows.graphics.beginFill(0xFFFF6F);
					shadows.graphics.moveTo(res[0].x, res[0].y);
					shadows.graphics.lineTo(res[1].x, res[1].y);
					shadows.graphics.lineTo(res[2].x, res[2].y);
					shadows.graphics.lineTo(res[3].x, res[3].y);
					shadows.graphics.endFill();
			
					if (Main.DEBUG)
					{
						// 爆炸点
						shadows.graphics.beginFill(0xFFA330);
						shadows.graphics.drawCircle(0.0, 0.0, 10.0);
						shadows.graphics.endFill();
						
						// 爆炸范围
						shadows.graphics.lineStyle(4.0, 0x31FEA3);
						shadows.graphics.drawCircle(0.0, 0.0, snowball.attackRange);
						shadows.graphics.lineStyle();
					}
				}
			}
		}
	}
}