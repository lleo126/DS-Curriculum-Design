package managers 
{
	import animations.SnowballExplosionAnimation;
	import assets.AssetManager;
	import events.UnitEvent;
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	import models.Collision;
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
			
			// 把当前帧切分为每一次移动都不会穿过物体的小帧
			var rm:Number = Math.min(ut1.radius, ut1.radiusZ, ut2.radius, ut2.radiusZ),
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
			while (count--) // 模拟移动 count 个小帧
			{
				var out1p:UnitTransform = ut1p.clone();
				ut1p.advance(time);
				ut2p.advance(time);
				if (detectStill(ut1p, ut2p)) // 当检测到两物体发生碰撞
				{
					var lo:UnitTransform = out1p, // 不变性：lo 未碰撞
						hi:UnitTransform = ut1p, // hi 必碰撞
						mi:UnitTransform = lo.clone();
					do // 二分查找碰撞点
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
			return distance <= r1 + r2;
		}
		
		/**
		 * 检测所有单位的碰撞
		 */
		public function detectAll(deltaTime:int):void 
		{
			var i:int = 0, j:int = 0,
				pos:UnitTransform;
			for (i = 0; i < heroes.length; ++i)
			{
				for (j = 0; j < monsters.length; ++j) 
				{
					pos = detect(heroes[i].unitTransform, monsters[j].unitTransform, deltaTime);
					if (pos) updateBounce(heroes[i], monsters[j], pos);
				}
				
				for (j = 0; j < obstacles.length; ++j)
				{
					pos = detect(heroes[i].unitTransform, obstacles[j].unitTransform, deltaTime);
					if (pos) updateBounce(heroes[i], obstacles[j], pos);
				}
				
				for (j = 0; j < items.length; ++j)
				{
					pos = detect(heroes[i].unitTransform, items[j].unitTransform, deltaTime);
					if (pos) updateBounce(heroes[i], items[j], pos);
					//if (pos)
					//{
						//heroes[i].dispatchEvent(new UnitEvent(UnitEvent.COLLIDED, items[j]));
						//items[j].dispatchEvent(new UnitEvent(UnitEvent.COLLIDED, heroes[i]));
						//items[j].removeFromWorld();
					//}
				}
			}
			
			for (i = 0; i < snowballs.length; ++i)
			{
				for (j = 0; j < heroes.length; ++j)
				{
					pos = detect(snowballs[i].unitTransform, heroes[j].unitTransform, deltaTime);
					if (pos) updateBounce(snowballs[i], heroes[j], pos);
				}
				
				for (j = i + 1; j < snowballs.length; ++j)
				{
					pos = detect(snowballs[i].unitTransform, snowballs[j].unitTransform, deltaTime);
					if (pos) updateBounce(snowballs[i], snowballs[j], pos);
				}
				
				for (j = 0; j < obstacles.length; ++j)
				{
					pos = detect(snowballs[i].unitTransform, obstacles[j].unitTransform, deltaTime);
					if (pos) updateBounce(snowballs[i], obstacles[j], pos);
				}
				
				// 临时：如果雪球撞到地面，就消失
				if (snowballs[i].unitTransform.z < 0.0) 
				{
					snowballExplode(snowballs[i]);
				}
			}
			
			// 如果寻路正确，怪物将不会撞到障碍物上，不需要检测怪物与障碍物的碰撞
		}
		
		/**
		 * 如果单位新候选碰撞位置比原来的近，那么更新 bounce 数组为新的位置
		 * @param	unit
		 * @param	ut
		 */
		private function updateBounce(source:Unit, target:Unit, next:UnitTransform):void 
		{
			var newCollision:Collision = new Collision(source, target, next);
			if (!(source in bounce) || newCollision.nextDistance < (bounce[source] as Collision).nextDistance) bounce[source] = newCollision;
		}
		
		/**
		 * 获取两个单位的 XoY 平面投影之间的距离
		 * @param	unit
		 * @param	unit2
		 */
		public function getDistanceXoY(unitTransform:UnitTransform, unitTransform2:UnitTransform):Number
		{
			return Point.distance(new Point(unitTransform.x,	unitTransform.y),
								  new Point(unitTransform2.x,	unitTransform2.y));
		}
		
		/**
		 * 更新所有单位的位置和速度
		 */
		public function update(deltaTime:int):void 
		{
			// 修正 Hero 和 Snowball 的位置
			var i:int;
			for (i = 0; i < heroes.length; ++i) 
			{
				if (heroes[i] in bounce) heroes[i].unitTransform = (bounce[heroes[i]] as Collision).next;
				else heroes[i].unitTransform.advance(deltaTime);
			}
			
			for (i = 0; i < snowballs.length; ++i) 
			{
				if (snowballs[i] in bounce)
				{
					snowballs[i].unitTransform = (bounce[snowballs[i]] as Collision).next;
					snowballExplode(snowballs[i]);
				}
				else snowballs[i].unitTransform.advance(deltaTime);
			}
			
			// 为所有发生碰撞的单位发送事件
			for each (var elem:* in bounce)
			{
				var collision:Collision = elem as Collision;
				collision.source.dispatchEvent(new UnitEvent(UnitEvent.COLLIDED, collision));
				collision.target.dispatchEvent(new UnitEvent(UnitEvent.COLLIDED, collision));
			}
			
			bounce = new Dictionary();
		}
		
		// TODO: 重构到 Snowball 里去
		/**
		 * 雪球爆炸，产生遮罩特效，伤害，炸掉物品，连锁引爆旁边的雪球
		 * @param	snowball
		 */
		private function snowballExplode(snowball:Snowball):void 
		{
			// TODO(翁熙): 封装播放音效
			AssetManager.soundEffect = new Sound();
			AssetManager.soundEffect.load(new URLRequest("music/Explode.mp3"));
			AssetManager.songEffect = AssetManager.soundEffect.play();
			AssetManager.songEffect.soundTransform = AssetManager.transEffect;
			
			// 产生特效
			// TODO: 封装成类
			var explosion:Effect = new Effect(new SnowballExplosionAnimation(explosion, snowball.attackRange));
			explosion.unitTransform.setByUnitTransform(snowball.unitTransform);
			explosion.unitTransform.radius = snowball.attackRange;
			explosion.addEventListener(Event.COMPLETE, function ():void 
			{
				explosion.removeFromWorld();
			})
			world.addUnit(explosion);
			
			// 爆炸范围遮挡
			var shadowShape:Shape = new Shape();
			shadowShape.y -= explosion.unitTransform.z;
			shadowShape.blendMode = BlendMode.ERASE;
			explosion.blendMode = BlendMode.LAYER;
			
			var shadows:Vector.<Vector.<UnitTransform>> = setShadowShape(shadowShape, snowball, explosion);
			explosion.addChild(shadowShape);
			
			var i:int;
			// 如果英雄注册点在爆炸范围内，且不在遮蔽区域内，则造成与爆炸点距离成反比的伤害
			for (i = heroes.length - 1; 0 <= i; --i)
			{
				if (!inExplosion(heroes[i].unitTransform, explosion.unitTransform, shadows)) continue;
				
				heroes[i].attacked(snowball, snowball.damage * (snowball.attackRange - getDistanceXoY(explosion.unitTransform, heroes[i].unitTransform)) / snowball.attackRange);
			}
			
			// 如果道具在……，则炸掉
			for (i = items.length - 1; 0 <= i; --i)
			{
				if (!inExplosion(items[i].unitTransform, explosion.unitTransform, shadows)) continue;
				
				items[i].attacked(snowball, snowball.damage * (snowball.attackRange - getDistanceXoY(explosion.unitTransform, items[i].unitTransform)) / snowball.attackRange);
			}
			
			// 如果障碍物在……，则损坏
			for (i = obstacles.length - 1; 0 <= i; --i)
			{
				if (!inExplosion(obstacles[i].unitTransform, explosion.unitTransform, shadows)) continue;
				
				obstacles[i].attacked(snowball, snowball.damage * (snowball.attackRange - getDistanceXoY(explosion.unitTransform, obstacles[i].unitTransform)) / snowball.attackRange);
			}
			
			snowball.removeFromWorld();
			
			// 如果雪球在……，则引爆
			for (i = snowballs.length - 1; 0 <= i; --i)
			{
				if (!inExplosion(snowballs[i].unitTransform, explosion.unitTransform, shadows)) continue;
				
				snowballExplode(snowballs[i]);
			}
		}
		
		/**
		 * 判断所给 unitUt 在不在由 explosionUt 和 shadows 所定义的爆炸范围内
		 * @param	unitUt
		 * @param	explosionUt
		 * @param	shadows
		 * @return	true 表示在
		 */
		private function inExplosion(unitUt:UnitTransform, explosionUt:UnitTransform, shadows:Vector.<Vector.<UnitTransform>>):Boolean 
		{
			var unitRadiusOnExplosion:Number = unitUt.getRadiusOn(explosionUt.centerZ);
			if (isNaN(unitRadiusOnExplosion)) unitRadiusOnExplosion = 0.0;
			return explosionUt.determineCross(unitUt)
				&& getDistanceXoY(unitUt, explosionUt) <= explosionUt.radius + unitRadiusOnExplosion
				&& !inShadows(unitUt, shadows);
		}
		
		private function inShadows(unitUt:UnitTransform, shadows:Vector.<Vector.<UnitTransform>>):Boolean 
		{
			for (var i:int = 0; i < shadows.length; i++) 
			{
				if (unitUt.inPolygon(shadows[i])) return true;
			}
			return false;
		}
		
		/**
		 * 设置阴影 Shape
		 * @param	shadowShape
		 * @param	snowball
		 * @return	定义阴影的 UnitTransform 数组
		 */
		private function setShadowShape(shadowShape:Shape, snowball:Snowball, explosion:Effect):Vector.<Vector.<UnitTransform>> 
		{
			var shadows:Vector.<Vector.<UnitTransform>> = new <Vector.<UnitTransform>>[];
			for (var i:int = 0; i < obstacles.length; ++i) 
			{
				if (snowball.attackRange + obstacles[i].unitTransform.radius < getDistanceXoY(snowball.unitTransform, obstacles[i].unitTransform)) continue; // 排除掉不会炸到的障碍物
				
				var supportUnitTransforms:Vector.<UnitTransform> = UnitTransform.getSupportUnitTransforms(snowball.unitTransform, obstacles[i].unitTransform);
				if (!supportUnitTransforms) continue;
				
				shadows.push(supportUnitTransforms);
				
				// 转换到局部坐标系
				var localUnitTransforms:Vector.<UnitTransform> = supportUnitTransforms.map(function (ut:UnitTransform, i:int, thisObj:Object):UnitTransform 
				{
					return UnitTransform.globalToLocal(ut, explosion.unitTransform);
				});
				
				// 遮蔽障碍物
				shadowShape.graphics.beginFill(0x2EEAAF);
				var localObstacleUnitTransform:UnitTransform = UnitTransform.globalToLocal(obstacles[i].unitTransform, explosion.unitTransform);
				shadowShape.graphics.drawCircle(localObstacleUnitTransform.x, localObstacleUnitTransform.y, obstacles[i].unitTransform.radius);
				shadowShape.graphics.endFill();
				
				// 遮蔽梯形
				shadowShape.graphics.beginFill(0xFFFF6F);
				shadowShape.graphics.moveTo(localUnitTransforms[0].x, localUnitTransforms[0].y);
				shadowShape.graphics.lineTo(localUnitTransforms[1].x, localUnitTransforms[1].y);
				shadowShape.graphics.lineTo(localUnitTransforms[2].x, localUnitTransforms[2].y);
				shadowShape.graphics.lineTo(localUnitTransforms[3].x, localUnitTransforms[3].y);
				shadowShape.graphics.endFill();
		
				if (Main.DEBUG)
				{
					// 爆炸点
					shadowShape.graphics.beginFill(0xFFA330);
					shadowShape.graphics.drawCircle(0.0, 0.0, 10.0);
					shadowShape.graphics.endFill();
					
					// 爆炸范围
					shadowShape.graphics.lineStyle(4.0, 0x31FEA3);
					shadowShape.graphics.drawCircle(0.0, 0.0, snowball.attackRange);
					shadowShape.graphics.lineStyle();
				}
			}
			return shadows;
		}
	}
}