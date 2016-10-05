package units 
{
	import flash.display.Bitmap;
	
	/**
	 * 怪物
	 * @author 彩月葵☆彡
	 */
	public class Monster extends Unit 
	{
		
		public function Monster() 
		{
			super();
			
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * 感应范围，怪物会感应到在范围内的玩家，并追击
		 */
		private var senseRange:Number;
		
		//==========
		// 方法
		//==========
		
		override public function setByXML(xml:XML):void
		{
			_unitTransform.radius = parseInt(xml.radius.text());
		}
		
		override internal function addToWorldUnits(world:World):void 
		{
			super.addToWorldUnits(world);
			world.monsters.push(this);
		}
		
		override internal function removeFromWorldUnits():void 
		{
			world.monsters.splice(world.monsters.indexOf(this), 1);
			super.removeFromWorldUnits();
		}
	}
}