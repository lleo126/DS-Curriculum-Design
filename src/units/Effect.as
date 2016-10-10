package units 
{
	import animations.Animation;
	import flash.events.Event;
	/**
	 * ...
	 * @author Weng-x
	 */
	public class Effect extends Unit 
	{
		public function Effect(animation:Animation)
		{
			this.animation = animation;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_body.center();
		}
		
		private var _animation:Animation;
		public function get animation():Animation 
		{
			return _animation;
		}
		
		public function set animation(value:Animation):void 
		{
			_animation = value;
			_body = new SpriteEx(value);
		}
		
		override internal function addToWorldUnits(world:World):void 
		{
			super.addToWorldUnits(world);
			world.effects.push(this);
		}
		
		override internal function removeFromWorldUnits():void 
		{
			world.effects.splice(world.effects.indexOf(this), 1);
			super.removeFromWorldUnits();
		}
	}
}