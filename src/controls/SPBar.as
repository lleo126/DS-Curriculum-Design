package controls 
{
	import assets.AssetManager;
	import flash.display.Bitmap;
	import units.Hero;
	
	/**
	 * @author leo126
	 */
	public class SPBar extends Bar 
	{
		public function SPBar() 
		{
			super(Hero.SP, Hero.MAX_SP, new AssetManager.SP_GROOVE_IMG());
		}
	}
}