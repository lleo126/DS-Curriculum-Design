package units 
{
	import assets.AssetManager;
	import flash.display.Bitmap;
	
	/**
	 * 玩家投掷的雪球
	 * @author 彩月葵☆彡
	 */
	public class Snowball extends Unit 
	{
		/** 质量，与蓄力后雪球的投掷距离成反比 */
		public static const MASS:Number = 50.0;
		private static const MAX_SPEED:Number = 1.0;
		private static const ATTACK_RANGE_RATIO:Number = 5.0;
		private static const DAMAGE_SNOW_RATIO:Number = 0.2;
		
		/**
		 * 
		 * @param	radius		大小，正比影响爆炸范围
		 * @param	bonus		消耗的雪量
		 */
		public function Snowball(radius:Number, bonus:int) 
		{
			_body = new SpriteEx(new AssetManager.SNOWBALL_IMG());
			
			damage = _radius = radius;
			_unitTransform.altitude = _body.width = _body.height = 2.0 * _radius;
			attackRange = radius * ATTACK_RANGE_RATIO;
			_bonus = bonus;
			_maxSpeed = MAX_SPEED;
			
			_body.pivotX = radius;
			_body.pivotY = 2.0 * radius;
			//_body.center();
		}
		
		//==========
		// 方法
		//==========
		
		public function clone():Snowball
		{
			return new Snowball(_radius, bonus);
		}
		
		override public function removeFromWorld():void 
		{
			// TODO: 遮罩爆炸范围
			// TODO: 伤害
			var deltaSnow:Number = 1.5 * bonus / (Math.PI * attackRange) / World.ALPHA_SNOW_RATIO;
			(parent as World).addSnow(deltaSnow, unitTransform, attackRange);
			super.removeFromWorld();
		}
	}
}