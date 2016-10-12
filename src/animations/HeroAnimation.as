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
		
		public function HeroAnimation(unit:Unit, index:int) 
		{
			super(unit);
			
			currentAnimation = _animations[UnitStatus.MOVING] = _animations[UnitStatus.STANDING] = new HeroMoveAnimation(unit, index);
			var attackAnimation:HeroThrowAnimation = new HeroThrowAnimation(unit, index);
			_animations[UnitStatus.THROWING] = _animations[UnitStatus.LIFTING] = attackAnimation;
			attackAnimation.addEventListener(Event.COMPLETE, onAttackComplete);
			
			addChild(currentAnimation);
		}
		
		private function onAttackComplete(e:Event):void 
		{
			unit.status = UnitStatus.MOVING;
			unit.status = UnitStatus.STANDING;
		}
	}
}