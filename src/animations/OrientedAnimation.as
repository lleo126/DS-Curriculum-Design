package animations 
{
	import units.Unit;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	internal class OrientedAnimation extends Animation 
	{
		protected var HEIGHT:Number;
		protected var rowNow:Number;
		
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
		
		override public function init():void
		{
			super.update(0);
			HEIGHT = _img.height / _row;
		}
		
		//override public function update(deltaTime:int):void 
		//{
			//clipRect.y = rowNow * HEIGHT;
			//super.update(deltaTime);
		//}
	}
}