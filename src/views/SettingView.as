package views 
{
	import assets.AssetManager;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class SettingView extends View 
	{
		static private const GROUP_SOUND_X:Number			= 100;
		static private const GROUP_SOUND_Y:Number			= 200;
		static private const SOUND_PADDING:Number			= 400;
		static private const GROUP_KEYPRESS_X:Number		= 240;
		static private const GROUP_KEYPRESS_Y:Number		= 420;
		static private const KEYPRESS_PADDING:Number		= 150;
		static private const GROUP_ROLE_X:Number			= 100;
		static private const GROUP_ROLE_Y:Number			= 500;
		static private const ROLE_PADDING:Number			= 100;
		static private const SETTING_X:Number				= 400;
		static private const SOUND_X:Number					= 100;
		static private const SOUND_Y:Number					= 160;
		static private const KEYPRESS_X:Number				= 100;
		static private const KEYPRESS_Y:Number				= 380;
		
		private var buttonGroupSound:Sprite;
		private var buttonGroupKeyPress:Sprite;
		private var buttonGroupRole:Sprite;
		
		private var setting:Bitmap;
		private var sound:Bitmap;
		private var music:Bitmap;
		private var soundEffect:Bitmap;
		private var keyPress:Bitmap;
		private var roleOne:Bitmap;
		private var roleTwo:Bitmap;
		private var raise:Bitmap;
		private var _throw:Bitmap;
		private var smallBall:Bitmap;
		private var middleBall:Bitmap;
		private var bigBall:Bitmap;	
		
		public function SettingView() 
		{
			 
		}
			
		override protected function init(ev:Event = null):void 
		{
			buttonGroupSound = new Sprite();
			buttonGroupSound.addEventListener(MouseEvent.CLICK, soundOnClick);
			
			buttonGroupKeyPress = new Sprite();
			buttonGroupKeyPress.addEventListener(MouseEvent.CLICK, keyPressOnClick);
			
			buttonGroupRole = new Sprite();
			buttonGroupRole.addEventListener(MouseEvent.CLICK, keyPressOnClick);
			
			setting = new AssetManager.SETTING_IMG();
			
			sound= new AssetManager.SOUND_IMG();
			
			music = new AssetManager.MUISC_IMG();
			
			soundEffect = new AssetManager.SOUNDEFFECT_IMG();
			
			keyPress = new AssetManager.KEY_PRESS_IMG();
			
			roleOne = new AssetManager.ROLE_ONE_IMG();
			
			roleTwo = new AssetManager.ROLE_TWO_IMG();
			
			raise = new AssetManager.RAISE_IMG();
			
			_throw = new AssetManager.THROW_IMG();
			
			smallBall = new AssetManager.SMALLBALL_IMG();
			
			middleBall = new AssetManager.MIDDLEBALL_IMG();
			
			bigBall = new AssetManager.BIGBALL_IMG();

			super.init();
		}
		
		override protected function placeElements():void 
		{
			setting.x = SETTING_X;
			
			addChild(setting);
			
			//=========
			sound.x = SOUND_X;
			sound.y = SOUND_Y;
			
			addChild(sound);
			
			buttonGroupSound.x = GROUP_SOUND_X;
			buttonGroupSound.y = GROUP_SOUND_Y;
			
			soundEffect.x = music.x + SOUND_PADDING; 
			
			addChild(buttonGroupSound);
            buttonGroupSound.addChild(music);
			buttonGroupSound.addChild(soundEffect);
			
			//=========
			keyPress.x = KEYPRESS_X;
			keyPress.y = KEYPRESS_Y;
			
			addChild(keyPress);
			
			buttonGroupKeyPress.x = GROUP_KEYPRESS_X;
			buttonGroupKeyPress.y = GROUP_KEYPRESS_Y;
			
			_throw.x     = raise.x      + KEYPRESS_PADDING;
			smallBall.x  = _throw.x     + KEYPRESS_PADDING;
			middleBall.x = smallBall.x  + KEYPRESS_PADDING;
			bigBall.x    = middleBall.x + KEYPRESS_PADDING;
			
			
			addChild(buttonGroupKeyPress);
            buttonGroupKeyPress.addChild(raise);
			buttonGroupKeyPress.addChild(_throw);
			buttonGroupKeyPress.addChild(smallBall);
			buttonGroupKeyPress.addChild(middleBall);
			buttonGroupKeyPress.addChild(bigBall);
			
			//=========
			buttonGroupRole.x = GROUP_ROLE_X;
			buttonGroupRole.y = GROUP_ROLE_Y;
			
			roleTwo.y = roleOne.y + ROLE_PADDING;
			
			addChild(buttonGroupRole);
			buttonGroupRole.addChild(roleOne);
			buttonGroupRole.addChild(roleTwo);
			
			//var shape:Shape = new Shape();
			//shape.graphics.beginFill(0x84E819);
			//shape.graphics.drawCircle(200, 200, 300);
			//shape.graphics.endFill();
			//addChild(shape);
		}
		
		private function soundOnClick(e:MouseEvent):void 
		{

		}
		
		private function keyPressOnClick(e:MouseEvent):void 
		{

		}
	}
}