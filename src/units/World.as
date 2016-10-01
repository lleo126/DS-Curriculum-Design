package units
{
	import assets.AssetManager;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	import managers.CollisionManager;
	import models.Player;
	import models.Setting;
	import views.View;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class World extends Sprite
	{
		public static const GRAVITY:Number = 0.2;
		public static const CHALLENGE_SCALE:Number = 3.0;
		
		public function World()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, update);
			
			heroGenerator = new UnitGenerator(this);
			//monsterGenerator = new UnitGenerator(this, AssetManager.MONSTER_XML.data);
			//obstacleGenerator = new UnitGenerator(this, AssetManager.OBSTACLE_XML.data);
			itemGenerator = new UnitGenerator(this, AssetManager.ITEM_XML.data);
		}
		
		private function init(ev:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// TODO: 设大小貌似会缩放里面的内容
			//width	= stage.stageWidth;
			//height	= stage.stageHeight;
			//if (CHALLENGE_SCALE)
			//{
			//width	*= CHALLENGE_SCALE;
			//height	*= CHALLENGE_SCALE;
			//}
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,	onKeyUpDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,	onKeyUpDown);
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * 游戏模式，可以是 CHALLENGE 或 BATTLE
		 */
		private var type:String;
		
		/**
		 * 上一帧的时间，以毫秒为单位
		 */
		private var lastTime:Number;
		
		/**
		 * 雪量
		 */
		private var snowfall:Bitmap;
		
		/**
		 * 玩家生成器
		 */
		private var heroGenerator:UnitGenerator;
		
		/**
		 * 怪物生成器
		 */
		private var monsterGenerator:UnitGenerator;
		
		/**
		 * 障碍物生成器
		 */
		private var obstacleGenerator:UnitGenerator;
		
		/**
		 * 道具生成器
		 */
		private var itemGenerator:UnitGenerator;
		
		/**
		 * 表示是否暂停游戏，true 为不暂停，false 为暂停
		 */
		private var resumed:Boolean = true;
		
		//==========
		// 属性
		//==========
		
		/**
		 * 碰撞管理器
		 */
		private var _collisionManager:CollisionManager;
		public function get collisionManager():CollisionManager
		{
			return _collisionManager;
		}
		
		/**
		 * 玩家，根据长度可以判断是单人还是双人
		 */
		private var _players:Vector.<Player>;
		public function get players():Vector.<Player>
		{
			return _players;
		}
		
		/**
		 * 雪球
		 */
		private var _snowballs:Vector.<Snowball> = new <Snowball>[];
		public function get snowballs():Vector.<Snowball>
		{
			return _snowballs;
		}
		
		/**
		 * 怪物
		 */
		private var _monsters:Vector.<Monster> = new <Monster>[];
		public function get monsters():Vector.<Monster>
		{
			return _monsters;
		}
		
		/**
		 * 障碍物
		 */
		private var _obstacles:Vector.<Obstacle> = new <Obstacle>[];
		public function get obstacles():Vector.<Obstacle>
		{
			return _obstacles;
		}
		
		/**
		 * 道具
		 */
		private var _items:Vector.<Item> = new <Item>[];
		public function get items():Vector.<Item>
		{
			return _items;
		}
		
		/**
		 * 自上一帧以来的经过时间，以毫秒为单位
		 */
		private var _deltaTime:Number;
		public function get deltaTime():Number
		{
			return _deltaTime;
		}
		
		//==========
		// 方法
		//==========
		
		/**
		 * 开始游戏
		 * @param	type	游戏模式
		 * @param	players	玩家数组
		 */
		public function start(type:String, players:Vector.<Player>):void
		{
			resumed = true;
			
			this.type = type;
			_players = players;
			lastTime = getTimer();
			_collisionManager = new CollisionManager(_players, _snowballs, _monsters, _obstacles, _items);
			
			generateUnits();
		}
		
		/**
		 * 生成世界里的所有单位
		 */
		private function generateUnits():void 
		{
			heroGenerator.dropUnit(_players[0].hero);
			heroGenerator.dropUnit(_players[1].hero);
			
			var item:Unit = itemGenerator.randomUnit();
			itemGenerator.dropUnit(item);
		}
		
		/**
		 * 继续或暂停游戏
		 * @param	b true 表示继续，false 表示暂停
		 */
		public function resume(b:Boolean):void
		{
			resumed = b;
			if (resumed) lastTime = getTimer();
			else
			{
				for (var i:int = 0; i < _players.length; ++i)
				{
					_players[i].releaseAll();
				}
			}
		}
		
		/**
		 * 清除数据
		 */
		public function dispose():void
		{
			var i:int = 0;
			for (i = 0; i < _players.length; i++)
			{
				_players[i].hero.dispose();
			}
			for (i = 0; i < _snowballs.length; i++)
			{
				_snowballs[i].dispose();
			}
			for (i = 0; i < _monsters.length; i++)
			{
				_monsters[i].dispose();
			}
			for (i = 0; i < _obstacles.length; i++)
			{
				_obstacles[i].dispose();
			}
			for (i = 0; i < _items.length; i++)
			{
				_items[i].dispose();
			}
		}
		
		/**
		 * 向游戏世界里添加单位
		 * @param	unit
		 */
		public function addUnit(unit:Unit):void
		{
			if (unit is Snowball)
			{
				_snowballs.push(unit);
			}
			else if (unit is Item)
			{
				_items.push(unit);
			}
			else if (unit is Obstacle)
			{
				_obstacles.push(unit);
			}
			else if (unit is Monster)
			{
				_monsters.push(unit)
			}
			addChild(unit);
		}
		
		/**
		 * 向游戏世界里删除单位
		 * @param	unit
		 */
		public function removeUnit(unit:Unit):void
		{
			if (unit is Snowball)
			{
				_snowballs.splice(_snowballs.indexOf(unit), 1);
			}
			else if (unit is Item)
			{
				_items.splice(_items.indexOf(unit), 1);
			}
			else if (unit is Obstacle)
			{
				_obstacles.splice(_obstacles.indexOf(unit), 1);
			}
			else if (unit is Monster)
			{
				_monsters.splice(_monsters.indexOf(unit), 1);
			}
			removeChild(unit);
		}
		
		/**
		 * （每帧）更新所有单位
		 * @param	e
		 */
		private function update(e:Event = null):void
		{
			if (Main.current.view != View.PLAY_VIEW || !resumed) return;
			
			updateTime();
			applyGravity();
			collisionManager.detectAll(_deltaTime);
			collisionManager.update(_deltaTime);
			zSort();
		}
		
		/**
		 * 更新每帧的 deltaTime
		 */
		private function updateTime():void
		{
			var newTime:int = getTimer();
			_deltaTime = newTime - lastTime;
			lastTime = newTime;
		}
		
		/**
		 * 给雪球们减 vz 速度
		 */
		private function applyGravity():void
		{
			for (var i:int = 0; i < _snowballs.length; i++)
			{
				_snowballs[i].unitTransform.vz -= GRAVITY;
			}
		}
		
		/**
		 * 深度排序，使用插入排序即可
		 */
		private function zSort():void
		{
		
		}
		
		/**
		 * 按键按下时找 PlayerController 代理处理玩家操作
		 * @param	e
		 */
		private function onKeyUpDown(e:KeyboardEvent):void
		{
			//trace( "World.onKeyUpDown > e : " + e );
			if (Main.current.view != View.PLAY_VIEW || !resumed) return;
			
			for (var i:int = 0; i < 2; ++i)
			{
				if (!(e.keyCode in Setting.current.hotkeys[i])) continue;
				
				players[i]['on' + Setting.current.hotkeys[i][e.keyCode]](e.keyCode, e.type == KeyboardEvent.KEY_DOWN);
			}
		}
	}
}