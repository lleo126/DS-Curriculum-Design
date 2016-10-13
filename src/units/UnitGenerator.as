package units 
{
	import assets.AssetManager;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.utils.clearInterval;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	import models.GenerationOption;
	
	/**
	 * 单位随机生成器
	 * @author 彩月葵☆彡
	 */
	public class UnitGenerator extends EventDispatcher 
	{
		public static const CONSTRAIN_HERO_HERO:Number = 300.0;
		public static const CONSTRAIN_HERO_MONSTER:Number = 100.0;
		
		private static const MONSTER:String		= 'monster';
		private static const ITEM:String		= 'item';
		private static const OBSTACLE:String	= 'obstacle';
		
		public function UnitGenerator(world:World, options:Object) 
		{
			this.world = world;
			this.options = options;
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * 游戏世界的引用
		 */
		private var world:World;
		
		/**
		 * 各种单位的数据 xml, Object.<String, GenerationOption>
		 */
		private var options:Object;
		
		/**
		 * 计时用计时器 Object.<String, Timer>
		 */
		private var timers:Object = { };
		
		//==========
		// 方法
		//==========
		
		public function start():void 
		{
			generateUnits();
			setTimers();
		}
		
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
		 * 销毁计时器，不再生成单位
		 */
		public function dispose():void 
		{
			
		}
		
		/**
		 * 随机选取一个单位
		 * @return
		 */
		public function randomUnit(xml:XML):Unit 
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
		
		/**
		 * 生成世界里的单位
		 */
		private function generateUnits():void 
		{
			var i:int;
			for (i = 0; i < world.players.length; ++i) 
			{
				dropUnit(world.players[i].hero);
			}
			for (i = 0; i < 10; ++i)
			{
				dropUnit(randomUnit((options[ITEM] as GenerationOption).xml));
				dropUnit(randomUnit((options[OBSTACLE] as GenerationOption).xml));
			}
		}
		
		/**
		 * 设置各种计时器
		 */
		private function setTimers():void 
		{
			var option:GenerationOption;
			for (var type:String in options)
			{
				option = options[type] as GenerationOption;
				var timer:Timer = timers[type] = new Timer(option.delay);
				timer.addEventListener(TimerEvent.TIMER, getOnTimer(type));
				timer.start();
			}
			
			function getOnTimer(type:String):Function 
			{
				return function (e:TimerEvent):void 
				{
					option = options[type] as GenerationOption;
					if (world[type + 's'].length == option.maxUnit) return;
					
					var unit:Unit = randomUnit(option.xml);
					dropUnit(unit);
					
					// TODD: 单位生成效果
					var scale:Number = unit.scaleX;
					unit.scaleX = unit.scaleY = 0.0;
					var ot:int = getTimer();
					var tid:int = setInterval(function ():void 
					{
						var t:int = getTimer() - ot;
						if (1000.0 < t)
						{
							unit.scaleX = unit.scaleY = scale;
							clearInterval(tid);
							return;
						}
						unit.scaleX = unit.scaleY = scale * t / 1000.0;
					}, 30);
				}
			}
		}
		
		/**
		 * 检查单位的位置是否符合条件限制
		 * @param	unit
		 * @return	符合返回 true
		 */
		private function checkConstrains(unit:Unit):Boolean 
		{
			var i:int;
			for (i = 0; i < world.heroes.length; ++i)
			{
				if (unit is Monster)
				{
					if (world.collisionManager.getDistanceXoY(unit.unitTransform, world.heroes[i].unitTransform) <= CONSTRAIN_HERO_MONSTER) return false;
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
					if (world.collisionManager.getDistanceXoY(unit.unitTransform, world.monsters[i].unitTransform) <= CONSTRAIN_HERO_MONSTER) return false;
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
	}
}