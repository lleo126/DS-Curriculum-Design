package views 
{
	import assets.AssetManager;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class MainView extends View 
	{
		static private const BATTLE_Y:Number		= 180;
		static private const BATTLE_X:Number		= 100;		
		static private const CHALLENGE_X:Number		= 100;
		static private const CHALLENGE_Y:Number		= 260;
		static private const SETTING_X:Number		= 100;
		static private const SETTING_Y:Number		= 340;
		static private const EXIT_X:Number			= 100;
		static private const EXIT_Y:Number			= 420;
		static private const ABOUT_X:Number			= 700;
		static private const ABOUT_Y:Number			= 580;
		static private const ABOUT_HEIGHT:Number	= 36;
		static private const ABOUT_WIDTH:Number		= 144;
		
		private var buttonBattle:SimpleButton;
		private var buttonChallenge:SimpleButton;
		private var buttonSetting:SimpleButton;
		private var buttonExit:SimpleButton;
		private var buttonAbout:SimpleButton;
		
		public function MainView() 
		{
			super();
		}
		
		override protected function placeElements():void 
		{
			buttonBattle = new SimpleButton(new AssetManager.BUTTON_BATTLE_IMG());
			buttonBattle.x = BATTLE_X; buttonBattle.y = BATTLE_Y;
			
			buttonChallenge = new SimpleButton(new AssetManager.BUTTON_CHALLENGE_IMG());
			buttonChallenge.x = CHALLENGE_X; buttonChallenge.y = CHALLENGE_Y;
			
			buttonSetting = new SimpleButton(new AssetManager.BUTTON_SETTING_IMG());
			buttonSetting.x = SETTING_X; buttonSetting.y = SETTING_Y;
			
			buttonExit = new SimpleButton(new AssetManager.BUTTON_EXIT_IMG());
			buttonExit.x = EXIT_X; buttonExit.y = EXIT_Y;
			
			buttonAbout = new SimpleButton(new AssetManager.BUTTON_ABOUT_IMG());
			buttonAbout.x = ABOUT_X; buttonAbout.y = ABOUT_Y;
			buttonAbout.width = ABOUT_WIDTH; buttonAbout.height = ABOUT_HEIGHT;

            addChild(buttonChallenge);
			addChild(buttonBattle);
			addChild(buttonSetting);
			addChild(buttonExit);
			addChild(buttonAbout);
		}
	}
}