package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import ui.SettingView;
	import ui.State;
	import ui.View;
	import ui.MainView;
	import ui.ViewType;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class Main extends Sprite
	{
		static public var current:Main;
		
		public function Main() 
		{
			current = this;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//==========
		// 变量
		//==========
		
		public var view:View;
		
		//==========
		// 属性
		//==========
		
		/**
		 * 修改 state 属性为对应的 View 的 type 值
		 */
		public var _state:String;
		
		public function get state():String 
		{
			return _state;
		}
		
		public function set state(value:String):void 
		{
			_state = value;
			// 切换 UI
			view.restore();
			removeChild(view);
			view = State.current.view[value];
			addChild(view);
		}
		
		//==========
		// 方法
		//==========
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			view = State.current.view[ViewType.MAIN_VIEW];
			addChild(view);
			//var timer:Timer = new Timer(1000, 1);
			//timer.addEventListener(TimerEvent.TIMER_COMPLETE, function ():void 
			//{
				//state = ViewType.SETTING_VIEW;
			//})
			//timer.start();
		}
	}
}