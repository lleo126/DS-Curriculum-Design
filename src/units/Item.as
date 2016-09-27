package units 
{
	import flash.display.Bitmap;
	
	/**
	 * 道具
	 * @author 彩月葵☆彡
	 */
	public class Item extends Unit 
	{
		public function Item(img:Bitmap) 
		{
			super(img);
		}
		
		//==========
		// 属性
		//==========
		
		private var _skill:Skill;
		public function get skill():Skill 
		{
			return _skill;
		}
	}
}