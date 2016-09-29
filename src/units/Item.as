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
		
		//==========
		// 方法
		//==========
		
		override public function setByXML(xml:XML):void
		{
			_radius = parseInt(xml.radius.text());

			if (xml.skill.hasOwnProperty("addHP"))
			{
				_hp	+= parseInt(xml.skill.addHP);	
				trace("HP: " + parseInt(xml.skill.addHP));
			}
			
			if (xml.skill.hasOwnProperty("speedUP"))
			{
				_maxSpeed += parseInt(xml.skill.speedUP);
				trace("Speed: " + parseInt(xml.skill.speedUP));
			}
			
			if (xml.skill.hasOwnProperty("addSnow"))
			{
				trace ("addSnow: " + parseInt(xml.skill.addSnow));
			}
			
			if (xml.skill.hasOwnProperty("stop"))
			{
				trace ("stop: true");
			}
			
			if (xml.skill.hasOwnProperty("dizzy"))
			{
				trace ("dizzy: true");
			}
			
			if (xml.skill.hasOwnProperty("moveBackward"))
			{
				trace ("moveBackward: true");
			}
		}	
	}
}