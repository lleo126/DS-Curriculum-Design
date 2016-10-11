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
		public function HeroMoveAnimation(unit:Unit,heroImg:Bitmap) 
		{
			rowNow = 0;
			_delay = 60;
			_img = heroImg;
			_row = 8;
			_column = 9;
			dirNum = 8;
			super(unit);
		}
	}

}
