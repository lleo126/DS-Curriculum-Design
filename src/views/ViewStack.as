package views
{
	import flash.display.Sprite;
	import flash.events.Event;
	import views.View;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class ViewStack extends Sprite
	{
		public function ViewStack(defaultView:View) 
		{
			this.defaultView = defaultView;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//==========
		// 变量
		//==========
		
		protected var defaultView:View;
		
		//==========
		// 属性
		//==========
		
		/**
		 * 当前所处的视图
		 * @see View
		 * @example 切换视图至设置视图：view = View.SETTING_VIEW;
		 */
		public var _view:View;
		
		public function get view():View
		{
			return _view;
		}
		
		public function set view(value:View):void 
		{
			removeChild(_view);
			_view = value;
			addChild(_view);
		}
		
		//==========
		// 方法
		//==========
		
		/**
		 * 初始化
		 * @param	e
		 */
		protected function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			_view = defaultView;
			addChild(_view);
		}
	}
}