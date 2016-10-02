package units
{
	import assets.AssetManager;
	import flash.display.Bitmap;
	import flash.utils.getDefinitionByName;
	import units.skills.AddHP;
	import units.skills.AddSnow;
	import units.skills.Dizzy;
	import units.skills.MoveBackward;
	import units.skills.Skill;
	import units.skills.SpeedUp;
	import units.skills.Stop;
	
	/**
	 * 道具
	 * @author 彩月葵☆彡
	 */
	public class Item extends Unit
	{
		//private static const radius:Number;
		public static var a:AddHP, b:AddSnow, c:Dizzy, d:MoveBackward, e:SpeedUp, f:Stop;
		
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
			name = xml.name.text().toString();
			_radius = parseInt(xml.radius.text().toString());
			
			var ImageClass:Class = AssetManager[xml.img[0].text().toString()];
			_body = new SpriteEx(new ImageClass());
			var skillXML:XML = xml.skill[0];
			var SkillClass:Class = getDefinitionByName(skillXML.@klass.toString()) as Class;
			_skill = new SkillClass();
			for each (var param:XML in skillXML.children())
			{
				_skill[param.localName().toString()] = parseFloat(param.text().toString());
				//trace("_skill[", param.localName().toString(), "] = ", param.text().toString());
			}
		}
	}
}