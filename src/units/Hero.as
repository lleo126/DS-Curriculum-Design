package units 
{
	import assets.AssetManager;
	import views.View;
	
	/**
	 * 玩家要控制的角色
	 * @author 彩月葵☆彡
	 */
	public class Hero extends Unit 
	{
		public static const SNOWBALLS:Vector.<Snowball> = new <Snowball>
		[
			new Snowball(20, 5),
			new Snowball(50, 10),
			new Snowball(100, 20)
		];
		private static const HP:Number = 100.0;
		private static const SP:Number = 20.0;
		private static const ATTCK_RANGE:Number = 200.0;
		private static const EXPLOSION_DISTANCE:Number = 100.0;
		private static const MAX_SPEED:Number = 0.5;
		private static const MAX_ACCUMULATION:Number = 100.0;
		private static const WIDTH:Number = 50.0;
		private static const HEIGHT:Number = 50.0;
		private static const RADIUS:Number = 50.0;
		private static const ALTITUDE:Number = 2.0 * RADIUS;
		
		public function Hero() 
		{
			super(new AssetManager.HERO_IMG());
			
			//width = WIDTH;
			//height = HEIGHT;
			hp = HP;
			sp = SP;
			attackRange = ATTCK_RANGE;
			_maxSpeed = MAX_SPEED;
			_radius = RADIUS;
			_unitTransform.altitude = ALTITUDE;
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * 雪球大小，有三种预设
		 */
		public var snowball:Snowball = SNOWBALLS[1];
		
		/**
		 * 举起状态
		 */
		public var lifted:Boolean = false;
		
		//==========
		// 属性
		//==========
		
		/**
		 * 收集的雪量
		 */
		private var _sp:Number;
		public function get sp():Number 
		{
			return _sp;
		}
		public function set sp(value:Number):void 
		{
			_sp = value;
		}
		
		/**
		 * 蓄力值，不会超过 MAX_ACCUMUMATION
		 */
		private var _accumulation:Number = 0.0;
		private var liftSnowball:Snowball;
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
			addChild(liftSnowball);
			liftSnowball.scaleX = 1.0 / liftSnowball.parent.scaleX;
			liftSnowball.scaleY = 1.0 / liftSnowball.parent.scaleY;
			liftSnowball.unitTransform.bottom = unitTransform.top;
			lifted = true;
		}
		
		/**
		 * 扔雪球
		 */
		public function throw2():void 
		{
			trace( "Hero.throw2" );
			if (!lifted) return;
			// TODO: 玩家移动的话速度更快
			removeChild(liftSnowball);
			
			liftSnowball.unitTransform.setByUnitTransform(_unitTransform);
			liftSnowball.unitTransform.bottom = unitTransform.top;
			liftSnowball.unitTransform.speed = liftSnowball.maxSpeed;
			liftSnowball.unitTransform.vz = _accumulation / Snowball.MASS;
			View.PLAY_VIEW.world.addUnit(liftSnowball);
			liftSnowball.scaleX = 1.0 / liftSnowball.parent.scaleX;
			liftSnowball.scaleY = 1.0 / liftSnowball.parent.scaleY;
			
			_accumulation = 0.0;
			lifted = false;
		}
	}
}