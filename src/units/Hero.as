package units 
{
	import assets.AssetManager;
	/**
	 * 玩家要控制的角色
	 * @author 彩月葵☆彡
	 */
	public class Hero extends Unit 
	{
		private static const DEFAULT_HP:Number = 100.0;
		private static const DEFAULT_SP:Number = 20.0;
		
		public function Hero() 
		{
			super(new AssetManager.HERO_IMG());
			hp = DEFAULT_HP;
			sp = DEFAULT_SP;
		}
		
		//==========
		// 属性
		//==========
		
		private var _sp:Number;
		public function get sp():Number 
		{
			return _sp;
		}
		public function set sp(value:Number):void 
		{
			_sp = value;
		}
		
	}

}