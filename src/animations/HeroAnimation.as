package animations 
{
	import flash.events.Event;
	import units.UnitStatus;
	import units.Unit;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class HeroAnimation extends MultiAnimation 
	{
		
		public function HeroAnimation(unit:Unit) 
		{
			super(unit);
			
			_animations[UnitStatus.MOVING] = new HeroMoveAnimation(unit);
			var throwAni:HeroThrowAnimation = new HeroThrowAnimation(unit);
			throwAni.addEventLitsener(new Event(Event.COMPLETE));
			_animations[UnitStatus.THROWING] = throwAni;
			// ...
		}
		
	}

}