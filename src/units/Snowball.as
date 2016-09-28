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
		public static const MASS:Number = 2.5;
		
		/**
		 * 
		 * @param	attackRange	爆炸范围
		 * @param	bonus		消耗的雪量
		 */
		public function Snowball(attackRange:Number, bonus:int) 
		{
			super(new AssetManager.SNOWBALL_IMG());
			this.attackRange = attackRange;
			_bonus = bonus;
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