package controls 
{
	import assets.AssetManager;
	import flash.display.Bitmap;
	
	/**
	 * @author leo126
	 */
	public class SPBar extends Bar 
	{
		public function SPBar() 
		{
			super(100.0, 100.0, new AssetManager.SP_GROOVE_IMG());
		}
	}
}