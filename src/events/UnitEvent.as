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
		public static const COLLIDED:String 			= 'collided';
		public static const DEATH:String				= 'death';
		public static const STRAIGHT_ATTACKED:String	= "straightAttacked";
		public static const ATTACKED:String				= "attacked";
		
		public function UnitEvent(type:String, data:* = null) 
		{
			super(type);
			_data = data;
		}
		
		private var _data:*;
		
		/**
		 * 数据，是什么由事件类型决定
		 */
		public function get data():* { return _data; }
	}
}