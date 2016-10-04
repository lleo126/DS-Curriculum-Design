package units
{
	import assets.AssetManager;
	import flash.events.Event;
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
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		// for test
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_body.pivotX = _body.width * 0.5;
			_body.pivotY = _body.height;
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
			_unitTransform.radius = parseInt(xml.radius.text().toString());
			
			var ImageClass:Class = AssetManager[xml.img[0].text().toString()];
			_body = new SpriteEx(new ImageClass());
			_body.width = parseFloat(xml.width.text().toString());
			_body.height = parseFloat(xml.height.text().toString());
			var skillXML:XML = xml.skill[0];
			var SkillClass:Class = getDefinitionByName(skillXML.@klass.toString()) as Class;
			
			_skill = new SkillClass();
			
			var children:XMLList = skillXML.children();
			for each (var param:XML in children)
			{
				_skill[param.localName().toString()] = parseFloat(param.text().toString());
				//trace("_skill[", param.localName().toString(), "] = ", param.text().toString());
			}
		}
	}
}