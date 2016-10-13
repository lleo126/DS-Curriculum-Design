package units.skills 
{
	import units.Unit;
	/**
	 * ...
	 * @author leo126
	 */
	public class SpeedUp extends Skill 
	{
		
		public function SpeedUp() 
		{
			//super();
			
		}
		public var speedUp:Number;
		
		override public function apply(unit:Unit):void 
		{
			if (0.1 < unit.maxSpeed + speedUp && unit.maxSpeed + speedUp < 0.5)
			{				
				unit.maxSpeed =  unit.maxSpeed + speedUp;
			}
		}
	}

}