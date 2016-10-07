package events 
{
	import flash.events.Event;
	import units.Unit;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class UnitEvent extends Event 
	{
		public static const COLLIDED:String = 'collided';
		
		public function UnitEvent(type:String, unit:Unit) 
		{
			super(type);
			_unit = unit;
		}
		
		private var _unit:Unit;
		
		/**
		 * 触发此事件的另一个单位
		 */
		public function get unit():Unit { return _unit; }
	}
}