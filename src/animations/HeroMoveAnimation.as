package animations 
{
	import assets.AssetManager;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import interfaces.IUpdate;
	import units.StatusType;
	import units.Unit;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class HeroMoveAnimation extends OrientedAnimation implements IUpdate
	{
		private static const IMG:Vector.<Bitmap> = new <Bitmap>[new AssetManager.HERO_MOVE(), new AssetManager.HERO_MOVE_TWO()];
		
		public function HeroMoveAnimation(unit:Unit, index:int) 
		{
			rowNow = 0;
			_delay = 60;
			_img = IMG[index];
			_row = 8;
			_column = 9;
			dirNum = 8;
			super(unit);
		}
		override public function update(deltaTime:int):void 
		{		
			super.findRow();
			if (unit.status == StatusType.STANDING)
			{
				deltaTime = 0;
				timeNum = 0;
				timeNow = 0;
			}
			super.update(deltaTime);
		}
	}

}
