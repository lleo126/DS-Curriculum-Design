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
			_body.height = parseFloat(xml.height.text().toString());
		}
	}
}