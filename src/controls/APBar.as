package controls 
{
	import assets.AssetManager;
	import flash.display.Bitmap;
	import units.Hero;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class APBar extends Bar 
	{
		public function APBar() 
		{
			super(Hero.AP, Hero.MAX_AP, new AssetManager.AP_GROOVE_IMG());
		}
	}
}