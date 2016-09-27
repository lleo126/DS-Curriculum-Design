package managers 
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import models.Player;
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
			players:Vector.<Player>,
			snowballs:Vector.<Snowball>,
			monsters:Vector.<Monster>,
			obstacles:Vector.<Obstacle>,
			items:Vector.<Item>
		) 
		{
			this.players = players;
			this.snowballs = snowballs;
			this.monsters = monsters;
			this.obstacles = obstacles;
			this.items = items;
		}
		
		//==========
		// 变量
		//==========
		
		private var players:Vector.<Player>;
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
		private var bounce:Dictionary;
		
		//==========
		// 方法
		//==========
		
		/**
		 * 检测两个单位的碰撞
		 * @param	deltaTime
		 * @return	若碰撞到物体，则返回碰撞的位置，否则返回 null
		 */
		public function detect(unit:Unit, unit2:Unit, deltaTime:Number = 0.0):UnitTransform
		{
			return null;
		}
		
		/**
		 * 检测所有单位的碰撞
		 */
		public function detectAll(deltaTime:Number):void 
		{
			var i:int = 0, j:int = 0;
			for (i = 0; i < players.length; ++i)
			{
				for (j = 0; j < monsters.length; ++j) 
				{
					
				}
				
				for (j = 0; j < obstacles.length; ++j)
				{
					
				}
				
				for (j = 0; j < items.length; ++j)
				{
					
				}
			}
			
			for (i = 0; i < snowballs.length; ++i)
			{
				for (j = 0; j < players.length; ++j)
				{
					
				}
				
				for (j = 0; j < snowballs.length; ++j)
				{
					
				}
			}
			
			// 如果寻路正确，怪物将不会撞到障碍物上，不需要检测怪物与障碍物的碰撞
		}
		
		/**
		 * 获取两个单位的 XoY 平面投影之间的距离
		 * @param	unit
		 * @param	unit2
		 */
		public function getDistance(unit:Unit, unit2:Unit):Number
		{
			return Point.distance(new Point(unit.unitTransform.x,	unit.unitTransform.y),
								  new Point(unit2.unitTransform.x,	unit2.unitTransform.y));
		}
		
		/**
		 * 更新所有单位的位置和速度
		 */
		public function update(deltaTime:Number):void 
		{
			players[0].hero.unitTransform.advance(deltaTime);
			
			
			for each (var key:* in next)
			{
				var unit:Unit = key as Unit;
				unit.unitTransform = next[unit];
			}
			next = new Dictionary();
		}
	}
}