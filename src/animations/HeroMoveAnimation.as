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
		private var arr:Array = new Array(22.5, 67.5, 112.5, 157.5, 202.5, 247.5, 292.5);
		
		public function HeroMoveAnimation(unit:Unit) 
		{
			rowNow = 0;
			_speed = 80;
			_img = new AssetManager.HERO_MOVE();
			_row = 8;
			_column = 13;
			super(unit);
			
		}
		
		override public function update(deltaTime:int):void 
		{
			while (rowNow< _row && arr[rowNow] < super.orientation) rowNow++;
			rowNow = rowNow == _row?0:rowNow;
			clipRect.y = rowNow * HEIGHT;
			super.update(deltaTime);	
		}
		
	}

}