package units 
{
	import animations.Animation;
	import flash.events.Event;
	
	[event(Event.COMPLETE)]
	
	/**
	 * ...
	 * @author Weng-x
	 */
	public class Effect extends Unit 
	{
		public function Effect(animation:Animation)
		{
			this.animation = animation;
			animation.addEventListener(Event.COMPLETE, onAnimationComplete);
		}
		
		override protected function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(_body);
			_body.center();
			update(0);
		}
		
		private var _animation:Animation;
		public function get animation():Animation { return _animation; }
		
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
		
		private function onAnimationComplete(e:Event):void 
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}