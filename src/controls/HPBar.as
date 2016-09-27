package controls 
{
	import assets.AssetManager;
	import flash.display.Bitmap;
	
	/**
	 * ...
	 * @author leo126
	 */
	public class HPBar extends Bar 
	{
		public function HPBar() 
		{
			super(100.0, 100.0, new AssetManager.HP_GROOVE_IMG());
		}		
	}
}