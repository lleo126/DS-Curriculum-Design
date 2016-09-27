package views 
{
	import assets.AssetManager;
	import controls.ConceptFrame;
	import flash.display.Bitmap;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.fscommand;
	import flash.utils.Dictionary;
	/**                  
	 * @author Weng_X
	 */
	public class MainView extends View 
	{
		static private const GROUP_X:Number			= 100;
		static private const GROUP_Y:Number			= 200;
		static private const PADDING:Number			= 80;
		static private const ABOUT_X:Number			= 735;
		static private const ABOUT_Y:Number			= 620;
		static private const ABOUT_HEIGHT:Number	= 36;
		static private const ABOUT_WIDTH:Number		= 144;
		
		private var buttonGroup:Sprite;
		
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
			buttonGroup = new Sprite();
			
			var bmp:Bitmap = new AssetManager.BUTTON_CHALLENGE_IMG();
			buttonChallenge = new SimpleButton(bmp, bmp, bmp, bmp);
			
			bmp = new AssetManager.BUTTON_BATTLE_IMG();
			buttonBattle = new SimpleButton(bmp, bmp, bmp, bmp);
			
			bmp = new AssetManager.BUTTON_SETTING_IMG();
			buttonSetting = new SimpleButton(bmp, bmp, bmp, bmp);
			
			bmp = new AssetManager.BUTTON_EXIT_IMG();
			buttonExit = new SimpleButton(bmp, bmp, bmp, bmp);
			
			bmp = new AssetManager.BUTTON_ABOUT_IMG();
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
			buttonGroup.x = GROUP_X;
			buttonGroup.y = GROUP_Y;
			
			buttonBattle.y = buttonChallenge.y + PADDING;
			
			buttonSetting.y = buttonBattle.y + PADDING;
			
			buttonExit.y = buttonSetting.y + PADDING;
			
			addChild(buttonGroup);
            buttonGroup.addChild(buttonChallenge);
			buttonGroup.addChild(buttonBattle);
			buttonGroup.addChild(buttonSetting);
			buttonGroup.addChild(buttonExit);
			
			//==========
			
			conceptFrame.x = 450; conceptFrame.y = 120;
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
				case buttonSetting:
					Main.current.view = View.SETTING_VIEW;
					break;
				case buttonBattle:
					Main.current.view = View.PLAY_VIEW;
					break;
				case buttonExit:
					fscommand("quit");
					break;
				default:
			}
		}
	}
}