package units
{
	import animations.HeroMoveAnimation;
	import animations.SnowballExplosionAnimation;
	import assets.AssetManager;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	import managers.CollisionManager;
	import models.Player;
	import models.Setting;
	import views.View;
	
	/**
	 * 游戏世界
	 * @author 彩月葵☆彡
	 */
	public class World extends Sprite
	{
		public static const GRAVITY:Number = 0.2;
		public static const CHALLENGE_SCALE:Number = 3.0;
		public static const SNOW_COLOR:uint = 0x0055EEFF;
		public static const ALPHA_SNOW_RATIO:Number = 0.00005;
		
		public function World()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, update);
			
			heroGenerator		= new UnitGenerator(this);
			monsterGenerator	= new UnitGenerator(this, AssetManager.MONSTER_XML.data);
			obstacleGenerator	= new UnitGenerator(this, AssetManager.OBSTACLE_XML.data);
			itemGenerator		= new UnitGenerator(this, AssetManager.ITEM_XML.data);
		}
		
		private function init(ev:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,	onKeyUpDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,	onKeyUpDown);
			
			snowfallData = new BitmapData(stage.stageWidth, stage.stageHeight, true, SNOW_COLOR);
			snowfall = new Bitmap(snowfallData);
			
			addChild(snowfall);
			addChild(unitGroup);//排序测试 
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
		 * 雪量数据
		 */
		private var snowfallData:BitmapData;
		
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
		
		/**
		 * 第一层，雪量层
		 */
		private var snowfall:Bitmap;
		
		/**
		 * 第二层，单位层
		 */
		private var unitGroup:Sprite = new Sprite(); //排序测试
		
		// for test
		private var testUnit:Unit;
		private var testUnitBall:Effect;
		
		//==========
		// 属性
		//==========
		
		private var _collisionManager:CollisionManager;
		/**
		 * 碰撞管理器
		 */
		internal function get collisionManager():CollisionManager { return _collisionManager; }
		
		private var _players:Vector.<Player>;
		/**
		 * 玩家，根据长度可以判断是单人还是双人
		 */
		public function get players():Vector.<Player> { return _players; }
		
		private var _heroes:Vector.<Hero>;
		/**
		 * 玩家所控制的英雄
		 */
		internal function get heroes():Vector.<Hero> { return _heroes; }
		
		private var _snowballs:Vector.<Snowball> = new <Snowball>[];
		/**
		 * 雪球
		 */
		internal function get snowballs():Vector.<Snowball> { return _snowballs; }
		
		private var _monsters:Vector.<Monster> = new <Monster>[];
		/**
		 * 怪物
		 */
		internal function get monsters():Vector.<Monster> { return _monsters; }
		
		private var _obstacles:Vector.<Obstacle> = new <Obstacle>[];
		/**
		 * 障碍物
		 */
		internal function get obstacles():Vector.<Obstacle> { return _obstacles; }
		
		private var _items:Vector.<Item> = new <Item>[];
		/**
		 * 道具
		 */
		internal function get items():Vector.<Item> { return _items; }
		
		private var _effects:Vector.<Effect> = new <Effect>[];
		
		public function get effects():Vector.<Effect> 
		{
			return _effects;
		}
		
		private var _deltaTime:int;
		/**
		 * 自上一帧以来的经过时间，以毫秒为单位
		 */
		public function get deltaTime():int { return _deltaTime; }
		
		
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
			
			lastTime = getTimer();
			
			snowfallData.fillRect(new Rectangle(0, 0, snowfallData.width, snowfallData.height), SNOW_COLOR);
			
			this.type = type;
			_players = players;
			_heroes = new <Hero>[];
			
			players[0].hero = new Hero();
			players[0].hero.hpBar = View.PLAY_VIEW.statusBarHP1;
			players[0].hero.spBar = View.PLAY_VIEW.statusBarSP1;
			players[0].hero.apBar = View.PLAY_VIEW.statusBarAP1;
			
			if (1 < _players.length)
			{
				players[1].hero = new Hero();
				players[1].hero.hpBar = View.PLAY_VIEW.statusBarHP2;
				players[1].hero.spBar = View.PLAY_VIEW.statusBarSP2;
				players[1].hero.apBar = View.PLAY_VIEW.statusBarAP1;
			}
			
			_collisionManager = new CollisionManager(_heroes, _snowballs, _monsters, _obstacles, _items);
			_collisionManager.world = this;
			
			generateUnits();
		}
		
		/**
		 * 生成世界里的所有单位
		 */
		private function generateUnits():void 
		{
			var i:int;
			for (i = 0; i < _players.length; ++i)
			{
				heroGenerator.dropUnit(_players[i].hero);
			}
			
			for (i = 0; i < 10; i++) 
			{
				var item:Unit = itemGenerator.randomUnit();
				itemGenerator.dropUnit(item);
				
				var obstacle:Unit = obstacleGenerator.randomUnit();
				obstacleGenerator.dropUnit(obstacle);
			}
			
			testUnitBall = new Effect(new SnowballExplosionAnimation(testUnitBall, 200));
			addChild(testUnitBall);

			testUnit = new Unit();
			testUnit.body = new SpriteEx(new HeroMoveAnimation(testUnit));
			addUnit(testUnit);
			testUnit.x = 200;
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
			unit.addToWorldUnits(this);
			unitGroup.addChild(unit);
		}
		
		/**
		 * 向游戏世界里删除单位
		 * @param	unit
		 */
		public function removeUnit(unit:Unit):void
		{
			unit.removeFromWorldUnits();
			unitGroup.removeChild(unit);
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
			
			var i:int;
			for (i = 0; i < heroes.length; i++) 
			{
				var hero:Hero = heroes[i];
				hero.update(_deltaTime);
				hero.sp += -addSnow(-Hero.COLLECT_SPEED * _deltaTime, _players[i].hero.unitTransform, Hero.COLLECT_RADIUS);
			}
			
			for (i = 0; i < _snowballs.length; i++)
			{
				var snowball:Snowball = _snowballs[i];
				snowball.update(_deltaTime);
			}
			
			for (i = 0; i < _obstacles.length; ++i)
			{
				var obstacle:Obstacle = _obstacles[i];
				obstacle.update(_deltaTime);
			}
			
			for (i = 0; i < _items.length; ++i)
			{
				var item:Item= _items[i];
				item.update(_deltaTime);
			}
			
			for (i = 0; i < _effects.length; ++i)
			{
				var effect:Effect = _effects[i];
				effect.update(_deltaTime);
			}
			
			testUnit.update(_deltaTime);
			//testUnitBall.update(_deltaTime);
			zSort();
		}
		
		/**
		 * 在给出的位置的圆上增加/减少雪量，效果从中心点往外递减
		 * @param	unitTransform	位置
		 * @param	deltaSnow		改变的雪量
		 * @param	radius			半径范围
		 * @return	改变的总雪量
		 */
		public function addSnow(deltaSnow:Number, unitTransform:UnitTransform, radius:Number):Number 
		{
			var snowSum:Number = 0.0, diameter:int = 2.0 * radius,
				originX:int = radius, originY:int = radius,
				startX:int = unitTransform.x - radius, startY:int = unitTransform.y - radius,
				area:Rectangle = new Rectangle(startX, startY, diameter, diameter),
				offsetX:int = 0, offsetY:int = 0;
				
			// 修正边角情况
			if (area.left < 0) offsetX -= area.left;
			if (stage.stageWidth <= area.right) diameter += stage.stageWidth - area.right; 
			if (area.top < 0) offsetY -= area.top;
			
			snowfallData.lock();
			var vector:Vector.<uint> = snowfallData.getVector(area);
			for (var i:int = 0; i < vector.length; i++) 
			{
				var nextY:int = (i + offsetX * (nextY + 1)) / diameter + offsetY,
					nextX:int = (i + offsetX * (nextY + 1)) % diameter;
					
				var distance:Number = Math.sqrt((originX - nextX) * (originX - nextX) + (originY - nextY) * (originY - nextY));
				if (nextX < 0 || snowfallData.width		<= nextX
				||	nextY < 0 || snowfallData.height	<= nextY
				||	radius < distance) continue;
					
				var deltaAlpha:int = deltaSnow * (distance - radius) / radius,
					alpha:uint = vector[i] >>> 24,
					nextAlpha:uint = alpha + deltaAlpha;
				// 判断整数上下溢，计算改变的雪量值
				if (deltaAlpha < 0) // 下溢
				{
					if (alpha < nextAlpha) nextAlpha = 0x00;
				}
				else // 上溢
				{
					if (0xFF < nextAlpha) nextAlpha = 0xFF;
				}
				
				vector[i] = (nextAlpha << 24) | SNOW_COLOR;
				snowSum += (alpha - nextAlpha) * ALPHA_SNOW_RATIO;
			}
			snowfallData.setVector(area, vector);
			snowfallData.unlock();
			
			return snowSum;
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
			var i:int;
			var children:Vector.<Unit> = new Vector.<Unit>(unitGroup.numChildren, true);
			for( i= 0;i<unitGroup.numChildren;i++)
			{
				children[i] = unitGroup.getChildAt(i) as Unit; //存储显示实例对象
			}
			
			//插入排序
			for (i = 1; i < children.length; ++i ) {
				var j:int = i;
				var target:Unit = children[i];
				while (j > 0 && target.unitTransform.y <= children[j - 1].unitTransform.y) {
					if (target.unitTransform.y == children[j - 1].unitTransform.y && target.unitTransform.z > children[j - 1].unitTransform.z) break;
					children[j] = children[j - 1];
					j--;
				}
				children[j] = target;
			}
			
			for(i = 0;i<children.length;i++)
			{
				unitGroup.setChildIndex(children[i],i);//重新设置实例对象的显示顺序
			}
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