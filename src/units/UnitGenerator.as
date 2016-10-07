package units 
{
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	
	/**
	 * 单位随机生成器
	 * @author 彩月葵☆彡
	 */
	public class UnitGenerator extends EventDispatcher 
	{
		public static const CONSTRAIN_HERO_HERO:Number = 300.0;
		public static const CONSTRAIN_HERO_MONSTER:Number = 100.0;
		
		public function UnitGenerator(world:World, xml:XML = null) 
		{
			this.world = world;
			this.xml = xml;
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * 游戏世界的引用
		 */
		private var world:World;
		
		/**
		 * 单位的数据 xml
		 */
		private var xml:XML;
		
		//==========
		// 方法
		//==========
		
		/**
		 * 向世界投掷单位，确保满足限制条件
		 */
		public function dropUnit(unit:Unit):void 
		{
			var p:Point;
			do
			{
				p = randomPoint();
				unit.unitTransform.setByPoint(p);
			} while (!checkConstrains(unit));
			world.addUnit(unit);
		}
		
		/**
		 * 检查单位的位置是否符合条件限制
		 * @param	unit
		 * @return	符合返回 true
		 */
		private function checkConstrains(unit:Unit):Boolean 
		{
			var i:int;
			for (i = 0; i < world.players.length; ++i)
			{
				if (unit is Monster)
				{
					if (world.collisionManager.getDistance(unit.unitTransform, world.heroes[i].unitTransform) <= CONSTRAIN_HERO_MONSTER) return false;
				}
				else
				{
					if (world.collisionManager.detectStill(unit.unitTransform, world.heroes[i].unitTransform)) return false;
				}
			}
			
			for (i = 0; i < world.monsters.length; ++i)
			{
				if (unit is Hero)
				{
					if (world.collisionManager.getDistance(unit.unitTransform, world.monsters[i].unitTransform) <= CONSTRAIN_HERO_MONSTER) return false;
				}
				else 
				{
					if (world.collisionManager.detectStill(unit.unitTransform, world.monsters[i].unitTransform)) return false;
				}
			}
			
			for (i = 0; i < world.obstacles.length; ++i)
			{
				if (world.collisionManager.detectStill(unit.unitTransform, world.obstacles[i].unitTransform)) return false;
			}
			
			for (i = 0; i < world.items.length; ++i)
			{
				if (world.collisionManager.detectStill(unit.unitTransform, world.items[i].unitTransform)) return false;
			}
			
			return true;
		}
		
		/**
		 * 随机选取一个单位
		 * @return
		 */
		public function randomUnit():Unit 
		{
			var UnitClass:Class = getDefinitionByName(xml.@klass.toString()) as Class;
			var children:XMLList = xml.children();
			var unitXML:XML = children[Math.floor(Math.random() * children.length())];
			var unit:Unit = new UnitClass();
			unit.setByXML(unitXML);
			return unit;
		}
		
		/**
		 * 随机生成一个点
		 * @return
		 */
		public function randomPoint():Point
		{
			//TODO: 根据 world 的大小生成 Point
			return new Point(Main.current.stage.stageWidth * Math.random(), Main.current.stage.stageHeight * Math.random());
		}
	}
}