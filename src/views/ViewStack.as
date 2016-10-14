package views
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import views.View;
	
	/**
	 * 堆叠视图，一个可以容纳并可以方便切换视图的容器
	 * @author 彩月葵☆彡
	 */
	public class ViewStack extends Sprite
	{
		public function ViewStack(defaultView:DisplayObject) 
		{
			this.defaultView = defaultView;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * 默认显示的视图
		 */
		protected var defaultView:DisplayObject;
		
		//==========
		// 属性
		//==========
		
		protected var _view:DisplayObject;
	   /**
		* 当前所处的视图
		* @see View
		* @example 切换视图至设置视图：view = View.SETTING_VIEW;
		*/
		public function get view():DisplayObject { return _view; }
		public function set view(value:DisplayObject):void 
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