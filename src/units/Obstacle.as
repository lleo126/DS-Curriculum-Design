package units 
{
	import flash.display.Bitmap;
	
	/**
	 * 障碍物
	 * @author 彩月葵☆彡
	 */
	public class Obstacle extends Unit 
	{
		public function Obstacle(img:Bitmap) 
		{
			super(img);
			
		}
		
		override public function setByXML(xml:XML):void
		{
			
		}	
	}
}