package controls 
{
	import assets.AssetManager;
	import flash.display.Bitmap;
	import units.Hero;
	
	/**
	 * ...
	 * @author leo126
	 */
	public class HPBar extends Bar 
	{
		public function HPBar() 
		{
			super(Hero.HP, Hero.MAX_HP, new AssetManager.HP_GROOVE_IMG());
		}		
	}
}