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
		/** 质量，控制蓄力后雪球的投掷距离 */
		public static const MASS:Number = 10.0;
		private static const MAX_SPEED:Number = 1.0;
		private static const ATTACK_RANGE_RATIO:Number = 2.0;
		
		/**
		 * 
		 * @param	attackRange	爆炸范围
		 * @param	bonus		消耗的雪量
		 */
		public function Snowball(radius:Number, bonus:int) 
		{
			_body = new SpriteEx(new AssetManager.SNOWBALL_IMG());
			
			_body.width = _body.height = _radius = radius;
			_unitTransform.altitude = 2 * radius;
			attackRange = radius * ATTACK_RANGE_RATIO;
			_bonus = bonus;
			_maxSpeed = MAX_SPEED;
			
			_body.center();
		}
		
		//==========
		// 方法
		//==========
		
		public function clone():Snowball
		{
			return new Snowball(attackRange, bonus);
		}
	}
}