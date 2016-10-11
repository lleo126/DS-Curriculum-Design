package views 
{
	import assets.AssetManager;
	import controls.ConceptFrame;
	import flash.display.Bitmap;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.system.fscommand;
	import models.Player;

	/**
	 * @author Weng_X
	 */
	public class MainView extends View 
	{
		static private const GROUP_X:Number			= 100;
		static private const GROUP_Y:Number			= 240;
		static private const PADDING:Number			= 80;
		static private const ABOUT_X:Number			= 735;
		static private const ABOUT_Y:Number			= 660;
		static private const ABOUT_HEIGHT:Number	= 36;
		static private const ABOUT_WIDTH:Number		= 144;
		static public const BUTTON_WIDTH:Number     = 250;
		static public const BUTTON_HEIGHT:Number    = 60;
		static public const TITLE_X:Number			= 220;
		static public const TITLE_Y:Number			= -30;
		static public const TITLE_WIDTH:Number		= 600;
		static public const TITLE_HEIGHT:Number		= 300;
		
		private var buttonGroup:Sprite;
		private var background:Bitmap;
		private var title:Bitmap;
		
		private var buttonBattle:SimpleButton;
		private var buttonChallenge:SimpleButton;
		private var buttonSetting:SimpleButton;
		private var buttonExit:SimpleButton;
		private var buttonAbout:SimpleButton;
		private var conceptFrame:ConceptFrame;
		
		
		
		public function MainView() 
		{
			
		}
		
		override protected function init(ev:Event = null):void 
		{
			AssetManager.soundMusic = new Sound();
			AssetManager.soundMusic.load(new URLRequest("music/MySound.mp3"));
			AssetManager.songMusic = AssetManager.soundMusic.play(0, int.MAX_VALUE);
			
			AssetManager.songEffect = new SoundChannel();
			
			buttonGroup = new Sprite();
			
			background = new AssetManager.MAIN_BACKGROUND_IMG();
			title = new AssetManager.MAIN_TITLE_IMG();
			title.smoothing = true;
			
			
			var bmp:Bitmap = new AssetManager.BUTTON_CHALLENGE_IMG();
			buttonChallenge = new SimpleButton(bmp, bmp, bmp, bmp);
			
			bmp = new AssetManager.BUTTON_BATTLE_IMG();
			buttonBattle = new SimpleButton(bmp, bmp, bmp, bmp);
			
			bmp = new AssetManager.BUTTON_SETTING_IMG();
			buttonSetting = new SimpleButton(bmp, bmp, bmp, bmp);
			
			bmp = new AssetManager.BUTTON_EXIT_IMG();
			buttonExit = new SimpleButton(bmp, bmp, bmp, bmp);
			
			bmp = new AssetManager.BUTTON_ABOUT_IMG();
			bmp.smoothing = true;
			buttonAbout = new SimpleButton(bmp, bmp, bmp, bmp);
			
			conceptFrame = new ConceptFrame();
			
			buttonGroup.addEventListener(MouseEvent.CLICK, onClick);
			buttonAbout.addEventListener(MouseEvent.MOUSE_OVER, conceptFrame.displayAbout);
			buttonAbout.addEventListener(MouseEvent.MOUSE_OUT, conceptFrame.outButton);
			buttonBattle.addEventListener(MouseEvent.MOUSE_OVER, conceptFrame.displayBattle);
			buttonBattle.addEventListener(MouseEvent.MOUSE_OUT, conceptFrame.outVideo);
			buttonChallenge.addEventListener(MouseEvent.MOUSE_OVER, conceptFrame.displayChallenge);
			buttonChallenge.addEventListener(MouseEvent.MOUSE_OUT, conceptFrame.outVideo);
			
			super.init();
		}
		
		override protected function placeElements():void 
		{
			title.x = TITLE_X;
			title.y = TITLE_Y;
			title.height = TITLE_HEIGHT;
			title.width = TITLE_WIDTH;
			
			background.x = (stage.stageWidth - background.width) * 0.5;
			addChild(background);
			addChild(title);
			
			
			
			buttonGroup.x = GROUP_X;
			buttonGroup.y = GROUP_Y;
			
			
			buttonChallenge.width = BUTTON_WIDTH;
			buttonChallenge.height = BUTTON_HEIGHT;
			
			buttonBattle.y = buttonChallenge.y + PADDING;
			buttonBattle.width = BUTTON_WIDTH;
			buttonBattle.height = BUTTON_HEIGHT;
			
			buttonSetting.y = buttonBattle.y + PADDING;
			buttonSetting.width = BUTTON_WIDTH - 120;
			buttonSetting.height = BUTTON_HEIGHT - 5;
			
			buttonExit.y = buttonSetting.y + PADDING;
			buttonExit.width = BUTTON_WIDTH;
			buttonExit.height = BUTTON_HEIGHT;
			
			addChild(buttonGroup);
            buttonGroup.addChild(buttonChallenge);
			buttonGroup.addChild(buttonBattle);
			buttonGroup.addChild(buttonSetting);
			buttonGroup.addChild(buttonExit);
			
			//==========
			
			conceptFrame.x = 450; conceptFrame.y = 170;
			addChild(conceptFrame);
			conceptFrame.width = 480; conceptFrame.height = 590;
			
			buttonAbout.x = ABOUT_X; buttonAbout.y = ABOUT_Y;
			buttonAbout.width = ABOUT_WIDTH; buttonAbout.height = ABOUT_HEIGHT;
			addChild(buttonAbout);

		}
		
		private function onClick(e:MouseEvent):void 
		{
			switch (e.target) 
			{
				case buttonChallenge:
					Main.current.view = View.CHALLENGE_VIEW;
					break;
				case buttonBattle:
					Main.current.view = View.PLAY_VIEW;
					View.PLAY_VIEW.world.start(PlayView.BATTLE, new <Player>[new Player(), new Player()]);
					break;
				case buttonSetting:
					Main.current.view = View.SETTING_VIEW;
					break;
				case buttonExit:
					fscommand("quit");
					break;
				default:
			}
		}
	}
}