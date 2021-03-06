package units
{
	import adobe.utils.CustomActions;
	import animations.HeroMoveAnimation;
	import animations.SnowballExplosionAnimation;
	import assets.AssetManager;
	import avmplus.getQualifiedClassName;
	import events.UnitEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	import managers.CollisionManager;
	import managers.LoggerManager;
	import models.GenerationOption;
	import models.Player;
	import models.PlayerStatus;
	import models.Setting;
	import views.PlayView;
	import controls.Clock;
	import views.View;
	
	[event(Event.COMPLETE)]
	/**
	 * 游戏世界
	 * @author 彩月葵☆彡
	 */
	public class World extends Sprite
	{
		public static const GRAVITY:Number = 0.2;
		public static const CHALLENGE_SCALE:Number = 3.0;
		public static const SNOW_COLOR:uint = 0x00E6FFFF;
		public static const ALPHA_SNOW_RATIO:Number = 0.00005;
		
		public static const MAX_MONSTER:int			= 10;
		public static const MAX_ITEM:int			= 30;
		public static const MAX_OBSTACLE:int		= 20;
		public static const DELAY_MONSTER:Number	= 10000.0;
		public static const DELAY_ITEM:Number		= 7000.0;
		public static const DELAY_OBSTACLE:Number	= 12000.0;
		public static const DELAY_SNOWFLAKE:Number	= 200.0;
		
		public function World()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, update);
			if (Main.DEBUG) addEventListener(MouseEvent.CLICK, onClick); // for test;
		}
		
		private function init(ev:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,	onKeyUpDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,	onKeyUpDown);
			
			snowfallData = new BitmapData(stage.stageWidth, stage.stageHeight, true, SNOW_COLOR);
			snowfall = new Bitmap(snowfallData);
			snowfall.alpha = 0.8;
			
			backgroundGroup.addChild(new AssetManager.GRASS_IMG());
			backgroundGroup.addChild(snowfall);
			addChild(backgroundGroup);
			addChild(unitGroup);
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
		 * 单位生成器，各种单位都是它生成
		 */
		private var unitGenerator:UnitGenerator;
		
		/**
		 * 表示是否暂停游戏，true 为不暂停，false 为暂停
		 */
		private var resumed:Boolean = false;
		
		/**
		 * 雪量遮罩
		 */
		private var snowfall:Bitmap;
		
		/**
		 * 第一层，背景层
		 */
		private var backgroundGroup:Sprite = new Sprite();
		
		/**
		 * 第二层，单位层
		 */
		private var unitGroup:Sprite = new Sprite();
		
		
		private var _collisionManager:CollisionManager;
		private var _players:Vector.<Player>;
		private var _heroes:Vector.<Hero>			= new <Hero>[];
		private var _snowballs:Vector.<Snowball>	= new <Snowball>[];
		private var _monsters:Vector.<Monster>		= new <Monster>[];
		private var _obstacles:Vector.<Obstacle>	= new <Obstacle>[];
		private var _items:Vector.<Item>			= new <Item>[];
		private var _effects:Vector.<Effect>		= new <Effect>[];
		private var _snowflakes:Vector.<Snowflake>	= new <Snowflake>[];
		private var _deltaTime:int;
		
		//==========
		// 属性
		//==========
		
		/**
		 * 碰撞管理器
		 */
		internal function get collisionManager():CollisionManager { return _collisionManager; }
		
		/**
		 * 玩家，根据长度可以判断是单人还是双人
		 */
		public function get players():Vector.<Player> { return _players; }
		
		/**
		 * 玩家所控制的英雄
		 */
		internal function get heroes():Vector.<Hero> { return _heroes; }
		
		/**
		 * 雪球
		 */
		internal function get snowballs():Vector.<Snowball> { return _snowballs; }
		
		/**
		 * 怪物
		 */
		internal function get monsters():Vector.<Monster> { return _monsters; }
		
		/**
		 * 障碍物
		 */
		internal function get obstacles():Vector.<Obstacle> { return _obstacles; }
		
		/**
		 * 道具
		 */
		internal function get items():Vector.<Item> { return _items; }
		
		/**
		 * 特效
		 */
		public function get effects():Vector.<Effect> { return _effects; }
		
		/**
		 * 雪花
		 */
		public function get snowflakes():Vector.<Snowflake> { return _snowflakes; }
		
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
			unitGenerator = new UnitGenerator(this, 
			{
				//'monster':	new GenerationOption(AssetManager.MONSTER_XML.data, MAX_MONSTER, DELAY_MONSTER),
				'item':			new GenerationOption(AssetManager.ITEM_XML.data, MAX_ITEM, DELAY_ITEM),
				'obstacle':		new GenerationOption(AssetManager.OBSTACLE_XML.data, MAX_OBSTACLE, DELAY_OBSTACLE),
				'snowflake':	new GenerationOption(AssetManager.SNOWFLAKE_XML.data, -1, DELAY_SNOWFLAKE, true)
			});
			
			
			lastTime = getTimer();
			
			snowfallData.fillRect(new Rectangle(0, 0, snowfallData.width, snowfallData.height), SNOW_COLOR);
			
			this.type = type;
			_players = players;
			
			players[0].hero = new Hero(0);
			players[0].hpBar = View.PLAY_VIEW.statusBarHP1;
			players[0].spBar = View.PLAY_VIEW.statusBarSP1;
			players[0].apBar = View.PLAY_VIEW.statusBarAP1;
			players[0].scoreBoard = View.PLAY_VIEW.role1_score;
			
			if (1 < _players.length)
			{
				players[1].hero = new Hero(1);
				players[1].hpBar = View.PLAY_VIEW.statusBarHP2;
				players[1].spBar = View.PLAY_VIEW.statusBarSP2;
				players[1].apBar = View.PLAY_VIEW.statusBarAP2;
				players[1].scoreBoard = View.PLAY_VIEW.role2_score;
			}
			
			for (var i:int = 0; i < _players.length; i++) 
			{
				_players[i].hero.addEventListener(UnitEvent.DEATH, onHeroDeath);
			}
			
			_collisionManager = new CollisionManager(_heroes, _snowballs, _monsters, _obstacles, _items);
			_collisionManager.world = this;
			
			unitGenerator.start();
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
			var i:int;
			for (i = _heroes.length - 1; 0 <= i; --i)
			{
				_heroes[i].dispose();
			}
			for (i = _snowballs.length - 1; 0 <= i; --i)
			{
				_snowballs[i].dispose();
			}
			for (i = _monsters.length - 1; 0 <= i; --i)
			{
				_monsters[i].dispose();
			}
			for (i = _obstacles.length - 1; 0 <= i; --i)
			{
				_obstacles[i].dispose();
			}
			for (i = _items.length - 1; 0 <= i; --i)
			{
				_items[i].dispose();
			}
			
			unitGenerator.dispose();
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
			collisionManager.detectAll(_deltaTime);
			collisionManager.update(_deltaTime);
			
			var i:int;
			for (i = 0; i < _heroes.length; i++) 
			{
				var hero:Hero = _heroes[i];
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
			
			for (i = 0; i < _snowflakes.length; ++i) 
			{
				_snowflakes[i].update(_deltaTime);
			}
			
			//testUnit.update(_deltaTime);
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
			LoggerManager.MATRIX.input(deltaSnow, unitTransform.x, unitTransform.y, unitTransform.z, radius);
			
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
				
				var deltaAlpha:int = deltaSnow * (radius - distance) / radius,
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
				snowSum += (nextAlpha - alpha) * ALPHA_SNOW_RATIO;
			}
			snowfallData.setVector(area, vector);
			snowfallData.unlock();
			
			LoggerManager.MATRIX.output(snowSum);
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
		 * 深度排序，使用插入排序即可
		 */
		private function zSort():void
		{
			var i:int;
			var childrenID:Vector.<int> = new Vector.<int>(unitGroup.numChildren, true);
			for( i= 0;i<childrenID.length;i++)
			{
				childrenID[i] = i;
			}
			
			var children:Vector.<Unit> = new Vector.<Unit>(unitGroup.numChildren, true);
			for( i= 0;i<unitGroup.numChildren;i++)
			{
				children[i] = unitGroup.getChildAt(i) as Unit; //存储显示实例对象
			}
			
			LoggerManager.INSERTION_SORT.input(unitGroup.numChildren);
			for( i= 0;i<unitGroup.numChildren;i++)
			{
				LoggerManager.INSERTION_SORT.input(children[i].unitTransform.x, children[i].unitTransform.y, children[i].unitTransform.z);
			}
			
			//插入排序
			for (i = 1; i < children.length; ++i ) {
				var j:int = i;
				var target:Unit = children[i];
				var targetID:int = childrenID[i];
				while (j > 0 && target.unitTransform.y <= children[j - 1].unitTransform.y) {
					if (target.unitTransform.y == children[j - 1].unitTransform.y &&
						target.unitTransform.z > children[j - 1].unitTransform.z) break;
					children[j] = children[j - 1];
					childrenID[j] = childrenID[j - 1];
					j--;
				}
				children[j] = target;
				childrenID[j] = targetID;
			}
			
			for( i= 0;i<childrenID.length;i++)
			{
				LoggerManager.INSERTION_SORT.output(childrenID[i]);
			}
			LoggerManager.INSERTION_SORT.output('');
			
			for(i = 0;i<children.length;i++)
			{
				unitGroup.setChildIndex(children[i],i);//重新设置实例对象的显示顺序
			}
		}
		
		/**
		 * 英雄死亡时，游戏结束
		 * @param	e
		 */
		private function onHeroDeath(e:UnitEvent):void 
		{
			resume(false);
			var player:Player = (e.currentTarget as Unit).owner;
			if (type == PlayView.BATTLE)
			{
				_players[0].status = _players[0].hero.status == UnitStatus.DEAD ? PlayerStatus.LOST : PlayerStatus.WON;
				_players[1].status = _players[1].hero.status == UnitStatus.DEAD ? PlayerStatus.LOST : PlayerStatus.WON;
				_players[0].endTime = _players[1].endTime = View.PLAY_VIEW.dateTime.time;
			}
			dispatchEvent(new Event(Event.COMPLETE));
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
		
		// for test
		/**
		 * 检测点击小区域内的障碍物跟玩家 1 的碰撞
		 * @param	e
		 */
		private function onClick(e:MouseEvent):void 
		{
			var mouseUt:UnitTransform = new UnitTransform();
			mouseUt.x = e.stageX;
			mouseUt.y = e.stageY;
			mouseUt.z = 0;
			for (var i:int = 0; i < _obstacles.length; i++) 
			{
				var distance:Number = UnitTransform.getDistance(mouseUt, _obstacles[i].unitTransform);
				if (100.0 < distance) continue;
				trace( "distance : " + distance );
				trace( "i : " + i );
				
				var pos:UnitTransform = _collisionManager.detect(_heroes[0].unitTransform, _obstacles[i].unitTransform, _deltaTime);
				if (pos)
				{
					trace(pos);
				}
				else 
				{
					trace(null);
				}
			}
		}
	}
}