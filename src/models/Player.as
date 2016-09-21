package models 
{
	import units.Hero;
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class Player 
	{
		public static const DEFAULT_HP:int = 100;
		public static const DEFAULT_SP:int = 20;
		
		public function Player() 
		{
			
		}
		
		public var hp:int = DEFAULT_HP;
		public var sp:int = DEFAULT_SP;
		public var score:int = 0;
		public var endTime:int;
		public var hero:Hero;
		
	}
}