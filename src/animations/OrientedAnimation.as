package animations 
{
	import units.Unit;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class OrientedAnimation extends Animation 
	{
		public function OrientedAnimation(unit:Unit) 
		{
			super(unit);
		}
		
		internal function get orientation():Number
		{
			return unit.unitTransform.orientation;
		}
		
		protected var _row:int;
		public function get row():int 
		{
			return _row;
		}
		public function set row(value:int):void 
		{
			_row = value;
		}
		
		override public function update(deltaTime:int):void 
		{
			
		}
	}
}