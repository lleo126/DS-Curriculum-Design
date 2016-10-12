package animations 
{
	import assets.AssetManager;
	import flash.display.Bitmap;
	import interfaces.IUpdate;
	import units.StatusType;
	import units.Unit;
	
	/**
	 * ...
	 * @author Weng-x
	 */
	public class HeroThrowAnimation extends OrientedAnimation implements IUpdate 
	{
		private static const IMG:Vector.<Bitmap> = new <Bitmap>[new AssetManager.HERO_ATTACK(), new AssetManager.HERO_ATTACK_TWO()];
		
		public function HeroThrowAnimation(unit:Unit, index:int) 
		{
			rowNow = 0;
			_delay = 60;
			_img = IMG[index];
			_row = 8;
			_column = 5;
			dirNum = 8;
			super(unit);
		}
		override public function update(deltaTime:int):void 
		{		
			super.findRow();
			if(unit.status == StatusType.LIFTING)
			{
				timeNow = 0;
				timeNum = 0;
				deltaTime = 0;
			}
			super.update(deltaTime);
		}
	}

}