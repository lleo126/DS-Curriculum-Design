package animations 
{
	import flash.events.Event;
	import units.StatusType;
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
			
			currentAnimation = _animations[StatusType.MOVING] = new HeroMoveAnimation(unit, index);
			var attackAnimation:HeroThrowAnimation = new HeroThrowAnimation(unit, index);
			_animations[StatusType.THROWING] = _animations[StatusType.LIFTING] = attackAnimation;
			attackAnimation.addEventListener(Event.COMPLETE, onAttackComplete);
			
			addChild(currentAnimation);
		}
		
		private function onAttackComplete(e:Event):void 
		{
			unit.status = StatusType.MOVING;
		}
	}
}