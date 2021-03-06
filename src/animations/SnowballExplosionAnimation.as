package animations 
{
	import assets.AssetManager;
	import units.Unit;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class SnowballExplosionAnimation extends Animation 
	{
		public function SnowballExplosionAnimation(unit:Unit, attackRange:Number) 
		{
			_column = 9;
			_img = new AssetManager.BALL_EXPLOSION();
			_delay = 30;
			super(unit);
			width = height = attackRange * 1.8;
		}
	}
}