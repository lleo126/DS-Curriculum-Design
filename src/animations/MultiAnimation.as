package animations 
{
	import avmplus.getQualifiedClassName;
	import flash.display.Sprite;
	import flash.events.Event;
	import interfaces.IUpdate;
	import units.Unit;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	internal class MultiAnimation extends Sprite implements IUpdate
	{
		public function MultiAnimation(unit:Unit) 
		{
			this.unit = unit;
			unit.addEventListener(Event.CHANGE, onStateChange);
		}
		
		protected var currentAnimation:Animation;
		protected var _animations:Object = { };
		
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
			for each (var animation:* in _animations) 
			{
				return (animation as Animation).delay;
			}
			return -1;
		}
		public function set speed(value:int):void 
		{
			for each (var animation:* in _animations) 
			{
				(animation as Animation).delay = value;
			}
		}
		
		public function update(deltaTime:int):void 
		{
			currentAnimation.update(deltaTime);
		}
		
		private function onStateChange(e:Event):void 
		{
			if (currentAnimation == _animations[unit.status]) return;
			
			removeChild(currentAnimation);
			currentAnimation = _animations[unit.status];
			addChild(currentAnimation);
		}
	}
}