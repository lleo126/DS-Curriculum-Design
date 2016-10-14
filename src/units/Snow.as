package units 
{
	import assets.AssetManager;
	/**
	 * 雪花，落下来增加雪量
	 * @author 彩月葵☆彡
	 */
	public class Snow extends Unit 
	{
		/**
		 * 风的速度，雪花会被风吹飞
		 */
		private static var _DX:Number;
		private static var _DY:Number;
		private static var MAX_SPEED:Number = 0.1;
		
		public static function get DX():Number { return _DX; }
		public static function get DY():Number { return _DY; }
		
		public static function update():void 
		{
			_DX = MAX_SPEED * Math.random();
			_DY = MAX_SPEED * Math.random();
		}
		
		public function Snow() 
		{
			_body = new SpriteEx(new AssetManager.SNOWBALL_IMG()); // TODO: 替换成雪花图片
		}
		
		
	}
}