package units.skills 
{
	import units.Hero;
	import units.Unit;
	/**
	 * ...
	 * @author leo126
	 */
	public class AddSnow extends Skill 
	{
		
		public function AddSnow() 
		{
			//super();
			//
		}
		public var addSnow:Number;
		
		override public function apply(unit:Unit):void 
		{
			(unit as Hero).sp += addSnow;
		}
	}
}