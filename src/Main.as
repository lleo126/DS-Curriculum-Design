package
{
	import flash.events.Event;
	import views.View;
	import views.ViewStack;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class Main extends ViewStack
	{
		static public var current:Main;
		
		public function Main() 
		{
			View.initClass();
			super(View.MAIN_VIEW);
			
			current = this;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//==========
		// 变量
		//==========
		
		//==========
		// 方法
		//==========
		
		/**
		 * 初始化
		 * @param	e
		 */
		override protected function init(e:Event = null):void 
		{
			super.init();
		}
	}
}