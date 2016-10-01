package units 
{
	import flash.display.Bitmap;
	import units.skills.Skill;
	
	/**
	 * 道具
	 * @author 彩月葵☆彡
	 */
	public class Item extends Unit 
	{
		//private static const radius:Number;
		
		public function Item()
		{
			super();
		}
		
		//==========
		// 属性
		//==========
		private var _skill:Skill;
		public function get skill():Skill 
		{
			return _skill;
		}
		
		//==========
		// 方法
		//==========
		
		override public function setByXML(xml:XML):void
		{
			_radius = parseInt(xml.item.radius.text());
			_bonus = parseInt(xml.item.bonus.text());
			//_skill = 
		}	
	}
}