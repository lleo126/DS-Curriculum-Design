package animations 
{
	import assets.AssetManager;
	import flash.display.Bitmap;
	import units.Unit;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class HeroMoveAnimation extends OrientedAnimation 
	{
		private var arr:Array = new Array(22.5, 67.5, 112.5, 157.5, 202.5, 247.5, 292.5);
		
		public function HeroMoveAnimation(unit:Unit) 
		{
			rowNow = 0;
			_img = new AssetManager.HERO_MOVE();
			_row = 8;
			_column = 13;
			super(unit);
		}
		
		override public function update(deltaTime:int):void 
		{
			var i:int = 0;
			while (rowNow< _row && arr[rowNow] < super.orientation) i++;
			rowNow = rowNow == _row?0:rowNow;
			clipRect.y = rowNow * HEIGHT;
			super.update(deltaTime);
		}
		
	}

}