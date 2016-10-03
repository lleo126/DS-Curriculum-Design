package animations 
{
	import units.StatusType;
	import units.Unit;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class HeroAnimation extends StatedAnimation 
	{
		
		public function HeroAnimation(unit:Unit) 
		{
			super(unit);
			
			animations[StatusType.MOVING] = new HeroWalkAnimation(unit);
			// ...
		}
		
	}

}