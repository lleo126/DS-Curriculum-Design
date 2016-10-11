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
			unit.maxSpeed += speedUp;
		}
	}

}