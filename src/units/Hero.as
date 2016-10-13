package units 
{
	import animations.HeroAnimation;
	import animations.HeroMoveAnimation;
	import assets.AssetManager;
	import controls.APBar;
	import controls.HPBar;
	import controls.SPBar;
	import events.UnitEvent;
	import flash.events.Event;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	import views.View;
	
	/**
	 * 玩家要控制的角色
	 * @author 彩月葵☆彡
	 */
	public class Hero extends Unit 
	{
		public static const COLLECT_SPEED:Number = 0.2;
		public static const COLLECT_RADIUS:Number = 50.0;
		public static const SNOWBALLS:Vector.<Snowball> = new <Snowball>
		[
			new Snowball(10, 5),
			new Snowball(20, 10),
			new Snowball(40, 20)
		];
		public static const HP:Number = 100.0;
		public static const SP:Number = 20.0;
		public static const AP:Number = 0.0;
		public static const MAX_HP:Number = 100.0;
		public static const MAX_SP:Number = 100.0;
		public static const MAX_AP:Number = 80.0;
		public static const SCALE:Number = 1.0;
		
		private static const AP_TIME_RATIO:Number = 0.5;
		private static const ATTCK_RANGE:Number = 200.0;
		private static const EXPLOSION_DISTANCE:Number = 100.0;
		private static const MAX_SPEED:Number = 0.35;
		private static const RADIUS:Number = 21.0;
		private static const ALTITUDE:Number = 62.0;
		private static const PIVOT_X:Number = 29.0;
		private static const PIVOT_Y:Number = 83.0;
		private static const BONUS:Number = 1000.0;
		
		public function Hero(index:int) 
		{
			name = 'hero';
			
			_body = new SpriteEx(new HeroAnimation(this, index));
			
			_body.scaleX = _body.scaleY = SCALE;
			_hp = HP;
			_sp = SP;
			_ap = AP;
			_maxHP = MAX_HP;
			_maxSP = MAX_SP;
			_maxAP = MAX_AP;
			_attackRange = ATTCK_RANGE;
			_maxSpeed = MAX_SPEED;
			_bonus = BONUS;
			_unitTransform.radius = RADIUS;
			_unitTransform.altitude = ALTITUDE;
			
			_body.pivotX = PIVOT_X;
			_body.pivotY = PIVOT_Y;
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * 雪球大小，有三种预设
		 */
		public var snowball:Snowball = SNOWBALLS[1];
		public var accerelating:Boolean = false;
		
		/**
		 * 表示有没有正在举起雪球
		 */
		private var lifted:Boolean = false;
		
		/**
		 * 正在举起的雪球
		 */
		private var liftSnowball:Snowball;
		
		private var _sp:Number;
		private var _ap:Number;
		private var _maxSP:Number;
		private var _maxAP:Number;
		
		//==========
		// 属性
		//==========
		
		override public function set hp(value:Number):void 
		{
			super.hp = value;
			owner.hpBar.value = _hp;
		}
		
		override public function set maxHP(value:Number):void 
		{
			super.maxHP = value;
			owner.hpBar.maxValue = value;
		}
		
		override public function get maxSpeed():Number
		{
			return _maxSpeed * (accerelating ? 1.5 : 1.0);
		}
		
	   /**
		* 收集的雪量（Snow Point）
		*/
		public function get sp():Number { return _sp; }
		public function set sp(value:Number):void 
		{
			_sp = Math.min(value, MAX_SP);
			owner.spBar.value = _sp;
		}
		
		/**
		 * 最大 SP
		 */
		public function set maxSP(value:Number):void 
		{
			_maxSP = value;
			owner.spBar.maxValue = value;
		}
		
	   /**
		* 蓄力值，不会超过 MAX_ACCUMUMATION
		*/
		public function get ap():Number { return _ap; }
		public function set ap(value:Number):void 
		{
			_ap = Math.min(value, MAX_AP);
			owner.apBar.value = _ap;
		}
		
		/**
		 * 最大 AP
		 */
		public function set maxAP(value:Number):void 
		{
			_maxAP = value;
			owner.apBar.maxValue = value;
		}
		
		//==========
		// 方法
		//==========
		
		/**
		 * 举雪球
		 */
		public function lift():void 
		{
			liftSnowball = snowball.clone();
			if (liftSnowball.bonus <= sp)
			{
				sp -= liftSnowball.bonus;
			}
			else // TODO: 举起符合剩余雪量大小的雪球
			{
				return;
			}
			
			status = UnitStatus.LIFTING;
			lifted = true;
			addChild(liftSnowball);
			liftSnowball.owner = owner;
			liftSnowball.scaleX = 1.0 / liftSnowball.parent.scaleX;
			liftSnowball.scaleY = 1.0 / liftSnowball.parent.scaleY;
			liftSnowball.unitTransform.z = unitTransform.top;
		}
		
		/**
		 * 扔雪球
		 */
		public function throw2():void 
		{
			if (!lifted) return;
			status = UnitStatus.THROWING;
			lifted = false;
			
			// TODO: 玩家移动的话速度更快？
			removeChild(liftSnowball);
			
			liftSnowball.unitTransform.setByUnitTransform(_unitTransform);
			liftSnowball.unitTransform.z = unitTransform.top;
			liftSnowball.unitTransform.speed = liftSnowball.maxSpeed;
			liftSnowball.unitTransform.vz = ap / Snowball.MASS;
			world.addUnit(liftSnowball);
			liftSnowball.scaleX = 1.0 / liftSnowball.parent.scaleX;
			liftSnowball.scaleY = 1.0 / liftSnowball.parent.scaleY;
			
			ap = 0.0;
		}
		
		override public function update(deltaTime:int):void 
		{
			super.update(deltaTime);
			if (_status == UnitStatus.LIFTING) ap += deltaTime * AP_TIME_RATIO;
		}
		
		override internal function addToWorldUnits(world:World):void 
		{
			super.addToWorldUnits(world);
			world.heroes.push(this);
			hp = _hp;
			sp = _sp;
			ap = _ap;
		}
		
		override internal function removeFromWorldUnits():void 
		{
			world.heroes.splice(world.heroes.indexOf(this), 1);
			super.removeFromWorldUnits();
		}
	}
}