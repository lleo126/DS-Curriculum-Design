package animations 
{
	import assets.AssetManager;
	import flash.display.Bitmap;
	import interfaces.IUpdate;
	import units.Unit;
	import units.UnitStatus;
	
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
			trace( "HeroThrowAnimation.update > deltaTime : " + deltaTime );
			super.findRow();
			if(unit.status == UnitStatus.LIFTING)
			{
				timeNow = 0;
				deltaTime = 0;
			}
			trace( "timeNow : " + timeNow );
			super.update(deltaTime);
		}
	}

}