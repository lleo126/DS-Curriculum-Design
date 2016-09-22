package views 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * 基本视图的基类
	 * @author 彩月葵☆彡
	 */
	public class View extends Sprite 
	{
		static public var MAIN_VIEW:MainView;
		static public var SETTING_VIEW:SettingView;
		static public var PLAY_VIEW:PlayView;
		static public var SCORE_VIEW:ScoreView;
		static public var CHALLENGE_VIEW:ChallengeView;
		
		/**
		 * 初始化所有视图
		 */
		static public function initClass():void 
		{
			MAIN_VIEW		= new MainView();
			SETTING_VIEW	= new SettingView();
			PLAY_VIEW		= new PlayView();
			SCORE_VIEW		= new ScoreView();
			CHALLENGE_VIEW	= new ChallengeView();
		}
		
		public function View() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ADDED_TO_STAGE, activate);
			addEventListener(Event.REMOVED_FROM_STAGE, inactivate);
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * true 表示此视图是激活状态
		 */
		protected var active:Boolean = false;
		
		//==========
		// 方法
		//==========
		
		/**
		 * 放置响应视图的元素
		 */
		protected function placeElements():void 
		{
			
		}
		
		/**
		 * 激活时调用
		 */
		protected function activate(ev:Event):void 
		{
			active = true;
		}
		
		/**
		 * 取消激活时调用，通常还原这个视图内所有元素
		 */
		protected function inactivate(ev:Event):void 
		{
			active = false;
		}
		
		/**
		 * 视图被添加到舞台第一次初始化的时候调用，自动调用放置元素的函数 `placeElements()`
		 * @param	Event
		 */
		protected function init(ev:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			placeElements();
		}
	}

}