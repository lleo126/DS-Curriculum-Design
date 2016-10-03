package animations 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import units.Unit;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	internal class MultiAnimation extends Sprite 
	{
		public function MultiAnimation(unit:Unit) 
		{
			this.unit = unit;
			unit.addEventListener(Event.CHANGE, onStateChange);
		}
		
		protected var currentAnimation:Animation;
		protected var animations:Object = { };
		
		protected var _unit:Unit;
		public function get unit():Unit 
		{
			return _unit;
		}
		public function set unit(value:Unit):void 
		{
			_unit = value;
		}
		
		public function get speed():int
		{
			for each (var animation:* in animations) 
			{
				return (animation as Animation).delay;
			}
			return -1;
		}
		public function set speed(value:int):void 
		{
			for each (var animation:* in animations) 
			{
				(animation as Animation).delay = value;
			}
		}
		
		public function update(deltaTime:int):void 
		{
			currentAnimation.update();
		}
		
		private function onStateChange(e:Event):void 
		{
			currentAnimation = animations[unit.status];
		}
	}
}