package units 
{
	import assets.AssetManager;
	import controls.HPBar;
	import controls.SPBar;
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
		private static const HP:Number = 100.0;
		private static const SP:Number = 20.0;
		private static const ATTCK_RANGE:Number = 200.0;
		private static const EXPLOSION_DISTANCE:Number = 100.0;
		private static const MAX_SPEED:Number = 0.5;
		private static const MAX_ACCUMULATION:Number = 80.0;
		private static const RADIUS:Number = 25.0;
		private static const ALTITUDE:Number = 2.0 * RADIUS;
		private static const PIVOT_X:Number = RADIUS;
		private static const PIVOT_Y:Number = 2.0 * RADIUS;
		
		public function Hero() 
		{
			_body = new SpriteEx(new AssetManager.HERO_IMG());
			
			_body.width = 2.0 * RADIUS;
			_body.height = 2.0 * RADIUS;
			_hp = HP;
			_sp = SP;
			attackRange = ATTCK_RANGE;
			_maxSpeed = MAX_SPEED;
			_unitTransform.radius = RADIUS;
			_unitTransform.altitude = ALTITUDE;
			
			_body.pivotX = PIVOT_X;
			_body.pivotY = PIVOT_Y;
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * 该角色的血条
		 */
		public var hpBar:HPBar;
		
		/**
		 * 该角色的雪条
		 */
		public var spBar:SPBar;
		
		/**
		 * 雪球大小，有三种预设
		 */
		public var snowball:Snowball = SNOWBALLS[1];
		
		/**
		 * 举起状态
		 */
		public var lifted:Boolean = false;
		
		/**
		 * 正在举起的雪球
		 */
		private var liftSnowball:Snowball;
		
		//==========
		// 属性
		//==========
		
		override public function set hp(value:Number):void 
		{
			super.hp = value;
			hpBar.value = value;
		}
		
		private var _sp:Number;
	   /**
		* 收集的雪量（Snow Point）
		*/
		public function get sp():Number 
		{
			return _sp;
		}
		public function set sp(value:Number):void 
		{
			_sp = value;
			spBar.value = value;
		}
		
		private var _accumulation:Number = 0.0;
	   /**
		* 蓄力值，不会超过 MAX_ACCUMUMATION
		*/
		public function get accumulation():Number 
		{
			return _accumulation;
		}
		public function set accumulation(value:Number):void 
		{
			_accumulation = value < MAX_ACCUMULATION ? value : MAX_ACCUMULATION;
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
			
			lifted = true;
			
			addChild(liftSnowball);
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
			lifted = false;
			
			// TODO: 玩家移动的话速度更快？
			removeChild(liftSnowball);
			
			liftSnowball.unitTransform.setByUnitTransform(_unitTransform);
			liftSnowball.unitTransform.z = unitTransform.top;
			liftSnowball.unitTransform.speed = liftSnowball.maxSpeed;
			liftSnowball.unitTransform.vz = _accumulation / Snowball.MASS;
			View.PLAY_VIEW.world.addUnit(liftSnowball);
			liftSnowball.scaleX = 1.0 / liftSnowball.parent.scaleX;
			liftSnowball.scaleY = 1.0 / liftSnowball.parent.scaleY;
			
			_accumulation = 0.0;
		}
	}
}