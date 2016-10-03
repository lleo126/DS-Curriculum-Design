package animations 
{
	import assets.AssetManager;
	import flash.display.Bitmap;
	import interfaces.IUpdate;
	import units.Unit;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class HeroMoveAnimation extends OrientedAnimation implements IUpdate
	{		
		public function HeroMoveAnimation(unit:Unit) 
		{
			rowNow = 0;
			_delay = 30;
			_img = new AssetManager.HERO_MOVE();
			_row = 8;
			_column = 13;
			dirNum = 8;
			super(unit);
		}
	}

}