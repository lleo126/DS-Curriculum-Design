package animations 
{
	import flash.display.Sprite;
	import units.Unit;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class Animation extends Sprite 
	{
		public function Animation(unit:Unit) 
		{
			this.unit = unit;
		}
		
		protected var _unit:Unit;
		public function get unit():Unit 
		{
			return _unit;
		}
		public function set unit(value:Unit):void 
		{
			_unit = value;
		}
		
		protected var _speed:int;
		public function get speed():int 
		{
			return _speed;
		}
		public function set speed(value:int):void 
		{
			_speed = value;
		}
		
		protected var _column:int;
		public function get column():int 
		{
			return _column;
		}
		public function set column(value:int):void 
		{
			_column = value;
		}
		
		public function update(deltaTime:int):void 
		{
			
		}
	}
}