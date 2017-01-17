package units
{
	import assets.AssetManager;
	import events.UnitEvent;
	import flash.events.Event;
	import flash.utils.clearInterval;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	import models.Collision;
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
		public static var a:AddHP, b:AddSnow, c:Dizzy, d:MoveBackward, e:SpeedUp, f:Stop;
		
		public function Item()
		{
			_hp = _maxHP = 1.0;
			addEventListener(UnitEvent.COLLIDED, onCollided);
		}
		
		override protected function init(e:Event):void 
		{
			super.init(e);
			if (!(_body.pivotX == 0.0 && _body.pivotY == 0.0)) return;
			
			_body.pivotX = _body.width * 0.5;
			_body.pivotY = _body.height;
		}
		
		/**
		 * 道具的技能
		 */
		private var _skill:Skill;
		
		//==========
		// 属性
		//==========
		public function get skill():Skill{ return _skill; }
		
		//==========
		// 方法
		//==========
		
		override public function setByXML(xml:XML):void
		{
			name = xml.name.text().toString();
			
			var ImageClass:Class = AssetManager[xml.img[0].text().toString()];
			_body = new SpriteEx(new ImageClass());
			_body.pivotX = parseFloat(xml.pivotX.text().toString());
			_body.pivotY = parseFloat(xml.pivotY.text().toString());
			_bonus = parseFloat(xml.bonus.text().toString());
			
			var scale:Number = parseFloat(xml.width.text().toString()) / _body.width;
			_unitTransform.radius = parseFloat(xml.radius.text().toString()) * scale;
			_unitTransform.altitude = parseFloat(xml.unitTransform.altitude.text().toString()) * scale;
			
			addEventListener(Event.ADDED_TO_STAGE, function ():void 
			{
				removeEventListener(Event.ADDED_TO_STAGE, arguments.callee);
				
				scaleX = scaleY = scale;
				
				// 临时
							scaleX = scaleY = 0.0;
							visible = true;
							var ot:int = getTimer();
							var tid:int = setInterval(function ():void 
							{
								var t:int = getTimer() - ot;
								if (500.0 < t)
								{
									scaleX = scaleY = scale;
									clearInterval(tid);
									return;
								}
								scaleX = scaleY = scale * t / 500.0;
							}, 30);
			});
			
			var skillXML:XML = xml.skill[0];
			var SkillClass:Class = getDefinitionByName(skillXML.@klass.toString()) as Class;
			
			_skill = new SkillClass();
			
			var children:XMLList = skillXML.children();
			for each (var param:XML in children)
			{
				_skill[param.localName().toString()] = parseFloat(param.text().toString());
			}
		}
		
		override public function dispose():void 
		{
			super.dispose();
			_skill = null;
			(UnitGenerator.UNIT_FACTORIES['units.Item'] as Pool).returnInstance(this);
		}
		
		override internal function addToWorldUnits(world:World):void 
		{
			super.addToWorldUnits(world);
			world.items.push(this);
		}
		
		override internal function removeFromWorldUnits():void 
		{
			if (!world) return;
			
			world.items.splice(world.items.indexOf(this), 1);
			super.removeFromWorldUnits();
		}
		
		private function onCollided(e:UnitEvent):void 
		{
			var unit:Unit = (e.data as Collision).source as Unit;
			if (unit is Hero)
			{
				_skill.apply(unit);
				attacked(unit, 10.0);
			}
		}
	}
}