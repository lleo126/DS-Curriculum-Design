package units 
{
	import assets.AssetManager;
	import flash.events.Event;
	
	/**
	 * 障碍物
	 * @author 彩月葵☆彡
	 */
	public class Obstacle extends Unit 
	{
		public function Obstacle() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		// for test
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			if (!(_body.pivotX == 0.0 && _body.pivotY == 0.0)) return;
			
			_body.pivotX = _body.width * 0.5;
			_body.pivotY = _body.height;
			
		}
		
		override public function setByXML(xml:XML):void
		{
			
			name = xml.name.text().toString();
			_unitTransform.radius = parseInt(xml.radius.text().toString());
			
			var ImageClass:Class = AssetManager[xml.img[0].text().toString()];
			_body = new SpriteEx(new ImageClass());
			_body.width = parseFloat(xml.width.text().toString());
			_body.scaleY = _body.scaleX;
			//_body.height = parseFloat(xml.height.text().toString());
			_body.pivotX = parseFloat(xml.pivotX.text().toString());
			_body.pivotY = parseFloat(xml.pivotY.text().toString());
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