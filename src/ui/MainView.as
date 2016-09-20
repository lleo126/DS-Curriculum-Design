package ui 
{
	import flash.display.Shape;
	import flash.display.SimpleButton;
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class MainView extends View 
	{
		
		[Embed(source="../../assets/Button_Challenge_Up.png")]
		public const BUTTON_Challenge_IMG:Class;
		
		[Embed(source="../../assets/Button_Battle_Up.png")]
		public const BUTTON_Battle_IMG:Class;
		
		[Embed(source="../../assets/Button_Setting_Up.png")]
		public const BUTTON_Setting_IMG:Class;
		
		[Embed(source="../../assets/Button_Exit_Up.png")]
		public const BUTTON_Exit_IMG:Class;
		
		[Embed(source="../../assets/Button_About_Up.png")]
		public const BUTTON_About_IMG:Class;
		
		[Embed(source="../../assets/Button_Challenge_Down.png")]
		public const BUTTON_Challenge_Down_IMG:Class;
		
		[Embed(source="../../assets/Button_Battle_Down.png")]
		public const BUTTON_Battle_Down_IMG:Class;
		
		[Embed(source="../../assets/Button_Setting_Down.png")]
		public const BUTTON_Setting_Down_IMG:Class;
		
		[Embed(source="../../assets/Button_Exit_Down.png")]
		public const BUTTON_Exit_Down_IMG:Class;
		
		[Embed(source="../../assets/Button_About_Down.png")]
		public const BUTTON_About_Down_IMG:Class;
		
		static private const BATTLE_Y:int = 180;
		static private const BATTLE_X:int = 100;		
		static private const CHALLENGE_X:int = 100;
		static private const CHALLENGE_Y:int = 260;
		static private const SETTING_X:int = 100;
		static private const SETTING_Y:int = 340;
		static private const EXIT_X:int = 100;
		static private const EXIT_Y:int = 420;
		static private const ABOUT_X:int = 700;
		static private const ABOUT_Y:int = 580;
		static private const ABOUT_HEIGHT:int = 36;
		static private const ABOUT_WIDTH:int = 144;
		
		public function MainView() 
		{
			super(ViewType.MAIN_VIEW);
		}
		
		override public function placeElements():void 
		{
		
			var buttonBattle:SimpleButton = new SimpleButton(new BUTTON_Battle_IMG());
			buttonBattle.x = BATTLE_X; buttonBattle.y = BATTLE_Y
			
			var buttonChallenge:SimpleButton = new SimpleButton(new BUTTON_Challenge_IMG());
			buttonChallenge.x = CHALLENGE_X; buttonChallenge.y = CHALLENGE_Y;
			
			var buttonSetting:SimpleButton = new SimpleButton(new BUTTON_Setting_IMG());
			buttonSetting.x = SETTING_X; buttonSetting.y = SETTING_Y;
			
			var buttonExit:SimpleButton = new SimpleButton(new BUTTON_Exit_IMG());
			buttonExit.x = EXIT_X; buttonExit.y = EXIT_Y;
			
			var buttonAbout:SimpleButton = new SimpleButton(new BUTTON_About_IMG());
			buttonAbout.x = ABOUT_X; buttonAbout.y = ABOUT_Y;
			buttonAbout.width = ABOUT_WIDTH; buttonAbout.height = ABOUT_HEIGHT;

            addChild(buttonChallenge);
			addChild(buttonBattle);
			addChild(buttonSetting);
			addChild(buttonExit);
			addChild(buttonAbout);
			
			//var shape:Shape = new Shape();
			//shape.graphics.beginFill(0xF28405);
			//shape.graphics.drawCircle(20, 20, 30);
			//shape.graphics.endFill();
			//addChild(shape);
		}
	}
}