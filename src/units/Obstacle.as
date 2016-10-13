package units 
{
	import assets.AssetManager;
	import events.UnitEvent;
	import flash.events.Event;
	import models.Collision;
	
	/**
	 * 障碍物
	 * @author 彩月葵☆彡
	 */
	public class Obstacle extends Unit 
	{
		public function Obstacle() 
		{
			
		}
		
		override protected function init(e:Event):void 
		{
			super.init(e);
			if (!(_body.pivotX == 0.0 && _body.pivotY == 0.0)) return;
			
			_body.pivotX = _body.width * 0.5;
			_body.pivotY = _body.height;
		}
		
		override public function setByXML(xml:XML):void
		{
			name = xml.name.text().toString();
			
			var ImageClass:Class = AssetManager[xml.img[0].text().toString()];
			_body = new SpriteEx(new ImageClass());
			_body.pivotX = parseFloat(xml.pivotX.text().toString());
			_body.pivotY = parseFloat(xml.pivotY.text().toString());
			_hp = _maxHP = parseFloat(xml.hp.text().toString());
			_bonus = parseFloat(xml.bonus.text().toString());
			
			var scale:Number = parseFloat(xml.width.text().toString()) / _body.width;
			_unitTransform.radius = parseFloat(xml.radius.text().toString()) * scale;
			_unitTransform.altitude = parseFloat(xml.unitTransform.altitude.text().toString()) * scale;
			
			addEventListener(Event.ADDED_TO_STAGE, function ():void 
			{
				removeEventListener(Event.ADDED_TO_STAGE, arguments.callee);
				
				scaleY = scaleX = scale;
			});
		}
		
		override internal function addToWorldUnits(world:World):void 
		{
			super.addToWorldUnits(world);
			world.obstacles.push(this);
		}
		
		override internal function removeFromWorldUnits():void 
		{
			world.obstacles.splice(world.obstacles.indexOf(this), 1);
			super.removeFromWorldUnits();
		}
	}
}