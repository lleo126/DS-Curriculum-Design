package ui 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class State 
	{
		static public var current:State = new State();
		
		public function State() 
		{
			view[ViewType.MAIN_VIEW]		= new MainView();
			view[ViewType.SETTING_VIEW]		= new SettingView();
			view[ViewType.PLAY_VIEW]		= new PlayView();
			view[ViewType.SCORE_VIEW]		= new ScoreView();
			view[ViewType.CHALLENGE_VIEW]	= new ChallengeView();
		}
		
		public var view:Dictionary = new Dictionary();
	}

}