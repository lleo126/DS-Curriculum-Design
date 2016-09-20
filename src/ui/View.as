package ui 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class View extends Sprite 
	{		
		public function View(type:String) 
		{
			this.type = type;
			placeElements();
		}
		
		//==========
		// 属性
		//==========
		
		public var type:String;
		
		//==========
		// 方法
		//==========
		
		/**
		 * 放置元素
		 */
		public function placeElements():void 
		{
			
		}
		
		/**
		 * 还原这个视图内所有元素
		 */
		public function restore():void 
		{
			
		}
	}

}