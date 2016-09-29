package units.skills 
{
	import units.Unit;
	/**
	 * ...
	 * @author leo126
	 */
	public class AddHP extends Skill 
	{
		
		public function AddHP() 
		{
			//super();
			//
		}
		
		public var addHP:Number;
		
		override public function apply(unit:Unit):void 
		{
			unit.hp += addHP;
		}
	}
}