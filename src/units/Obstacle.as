package units 
{
	import assets.AssetManager;
	
	/**
	 * 障碍物
	 * @author 彩月葵☆彡
	 */
	public class Obstacle extends Unit 
	{
		public function Obstacle() 
		{
			super();
			
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