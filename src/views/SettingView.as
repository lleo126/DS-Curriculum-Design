package views 
{
	import assets.AssetManager;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import models.Setting;
	/**
	 * 设置界面
	 * @author leo126
	 */
	public class SettingView extends View 
	{
		static private const GROUP_SOUND_X:Number			= 100;
		static private const GROUP_SOUND_Y:Number			= 200;
		static private const SOUND_PADDING:Number			= 400;
		static private const GROUP_KEYPRESS_X:Number		= 240;
		static private const GROUP_KEYPRESS_Y:Number		= 360;
		static private const KEYPRESS_PADDING:Number		= 150;
		static private const GROUP_ROLE_X:Number			= 100;
		static private const GROUP_ROLE_Y:Number			= 440;
		static private const ROLE_PADDING:Number			= 100;
		static private const SETTING_X:Number				= 400;
		static private const SOUND_X:Number					= 100;
		static private const SOUND_Y:Number					= 160;
		static private const KEYPRESS_X:Number				= 100;
		static private const KEYPRESS_Y:Number				= 300;
		static private const BUTTON_BACK_X:Number			= 60;
		static private const BUTTON_BACK_Y:Number			= 660;
		static private const GROUP_LABLE_ONE_X:Number		= 240;
		static private const GROUP_LABLE_ONE_Y:Number		= 440;
		static private const GROUP_LABLE_TWO_X:Number		= 240;
		static private const GROUP_LABLE_TWO_Y:Number		= 540;
		static private const LABLE_WIDTH:Number 			= 20;
		static private const LABLE_HEIGHT:Number			= 28;
		static private const FORMAT_SIZE:Number				= 26;
		static private const KEYWANT_X:Number				= 400;
		static private const KEYWANT_Y:Number				= 600;
		
		private static var setYet:Boolean					= false;
		private static var keyInfo:String;
		
		private var buttonGroupSound:Sprite;
		private var buttonGroupKeyPress:Sprite;
		private var buttonGroupRole:Sprite;
		private var buttonGroupLableOne:Sprite;
		private var buttonGroupLableTwo:Sprite;
		
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
		private var keyWant:Bitmap;
		
		private var buttonBack:SimpleButton;
		
		private var lableOneRaise:TextField;
		private var lableOneThrow:TextField;
		private var lableOneSmallBall:TextField;
		private var lableOneMiddleBall:TextField;
		private var lableOneBigBall:TextField;
		private var lableTwoRaise:TextField;
		private var lableTwoThrow:TextField;
		private var lableTwoSmallBall:TextField;
		private var lableTwoMiddleBall:TextField;
		private var lableTwoBigBall:TextField;
		private var tempLable:TextField;
		
		public function SettingView() 
		{
			 
		}
			
		override protected function init(ev:Event = null):void 
		{
			buttonGroupSound 	= new Sprite();
			buttonGroupSound.addEventListener(MouseEvent.CLICK, soundOnClick);
			
			buttonGroupKeyPress = new Sprite();
			buttonGroupRole 	= new Sprite();
			
			buttonGroupLableOne = new Sprite();
			buttonGroupLableOne.addEventListener(MouseEvent.CLICK, lableOneOnClick);
			buttonGroupLableOne.addEventListener(KeyboardEvent.KEY_DOWN, oneKeyDown);
			buttonGroupLableTwo = new Sprite();
			buttonGroupLableTwo.addEventListener(MouseEvent.CLICK, lableTwoOnClick);
			buttonGroupLableTwo.addEventListener(KeyboardEvent.KEY_DOWN, twoKeyDown);
			
			setting 	= new AssetManager.SETTING_IMG();
			
			sound		= new AssetManager.SOUND_IMG();
			music 		= new AssetManager.MUISC_IMG();
			soundEffect = new AssetManager.SOUNDEFFECT_IMG();
			sliderBar 	= new AssetManager.SLIDER_BAR_IMG();
			sliderTick 	= new AssetManager.SLIDER_TICK_IMG();
			
			keyPress 	= new AssetManager.KEY_PRESS_IMG();
			roleOne 	= new AssetManager.ROLE_ONE_IMG();
			roleTwo 	= new AssetManager.ROLE_TWO_IMG();
			raise 		= new AssetManager.RAISE_IMG();
			_throw 		= new AssetManager.THROW_IMG();
			smallBall 	= new AssetManager.SMALLBALL_IMG();
			middleBall 	= new AssetManager.MIDDLEBALL_IMG();
			bigBall 	= new AssetManager.BIGBALL_IMG();
			keyWant		= new AssetManager.KEY_WANT_IMG();
			
			var bmp:Bitmap 	= new AssetManager.BUTTON_BACK_IMG();
			buttonBack 		= new SimpleButton(bmp, bmp, bmp, bmp);
			buttonBack.addEventListener(MouseEvent.CLICK, buttonBackOnClick);
			
			lableOneRaise 		= new TextField();
			lableOneThrow 		= new TextField();
			lableOneSmallBall 	= new TextField();
			lableOneMiddleBall 	= new TextField();
			lableOneBigBall 	= new TextField();
			lableTwoRaise 		= new TextField();
			lableTwoThrow 		= new TextField();
			lableTwoSmallBall	= new TextField();
			lableTwoMiddleBall 	= new TextField();
			lableTwoBigBall 	= new TextField();
			
			super.init();
		}
		
		override protected function placeElements():void 
		{
			setting.x = SETTING_X;
			
			addChild(setting);
			
			//=========显示声音组图片
			sound.x = SOUND_X;
			sound.y = SOUND_Y;
			
			addChild(sound);
			
			buttonGroupSound.x = GROUP_SOUND_X;
			buttonGroupSound.y = GROUP_SOUND_Y;
			
			soundEffect.x = music.x + SOUND_PADDING; 
			
			addChild(buttonGroupSound);
            buttonGroupSound.addChild(music);
			buttonGroupSound.addChild(soundEffect);
			
			//=========显示按键组图片
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
			
			//=========显示角色组图片
			buttonGroupRole.x = GROUP_ROLE_X;
			buttonGroupRole.y = GROUP_ROLE_Y;
			
			roleTwo.y = roleOne.y + ROLE_PADDING;
			
			addChild(buttonGroupRole);
			buttonGroupRole.addChild(roleOne);
			buttonGroupRole.addChild(roleTwo);
			
			//=========加载设置界面快捷键文本框
			var format:TextFormat = new TextFormat();
			format.size 				= FORMAT_SIZE;
			
			lableOneRaise.defaultTextFormat		= format;
			lableOneThrow.defaultTextFormat 	= format;
			lableOneSmallBall.defaultTextFormat = format;
			lableOneMiddleBall.defaultTextFormat= format;
			lableOneBigBall.defaultTextFormat	= format;
			lableOneRaise.text	 	= "J";			
			lableOneThrow.text	 	= "K";
			lableOneSmallBall.text	= "U";
			lableOneMiddleBall.text	= "I";
			lableOneBigBall.text 	= "O";

			buttonGroupLableOne.x = GROUP_LABLE_ONE_X;
			buttonGroupLableOne.y = GROUP_LABLE_ONE_Y;
			
			lableOneThrow.x 	= lableOneRaise.x 		+ KEYPRESS_PADDING;
			lableOneSmallBall.x = lableOneThrow.x		+ KEYPRESS_PADDING;
			lableOneMiddleBall.x= lableOneSmallBall.x	+ KEYPRESS_PADDING;
			lableOneBigBall.x 	= lableOneMiddleBall.x 	+ KEYPRESS_PADDING;
			
			addChild(buttonGroupLableOne);
			buttonGroupLableOne.addChild(lableOneRaise);
			buttonGroupLableOne.addChild(lableOneThrow);
			buttonGroupLableOne.addChild(lableOneSmallBall);
			buttonGroupLableOne.addChild(lableOneMiddleBall);
			buttonGroupLableOne.addChild(lableOneBigBall);
			
			lableTwoRaise.defaultTextFormat 	= format;
			lableTwoThrow.defaultTextFormat 	= format;
			lableTwoSmallBall.defaultTextFormat = format;
			lableTwoMiddleBall.defaultTextFormat= format;
			lableTwoBigBall.defaultTextFormat 	= format;
			lableTwoRaise.text	 	= "小键盘1";
			lableTwoThrow.text	 	= "小键盘2";
			lableTwoSmallBall.text	= "小键盘4";
			lableTwoMiddleBall.text	= "小键盘5";
			lableTwoBigBall.text 	= "小键盘6";

			buttonGroupLableTwo.x = GROUP_LABLE_TWO_X;
			buttonGroupLableTwo.y = GROUP_LABLE_TWO_Y;
			
			lableTwoThrow.x 	= lableTwoRaise.x 		+ KEYPRESS_PADDING;
			lableTwoSmallBall.x = lableTwoThrow.x 		+ KEYPRESS_PADDING;
			lableTwoMiddleBall.x= lableTwoSmallBall.x 	+ KEYPRESS_PADDING;
			lableTwoBigBall.x 	= lableTwoMiddleBall.x 	+ KEYPRESS_PADDING;
			
			addChild(buttonGroupLableTwo);
			buttonGroupLableTwo.addChild(lableTwoRaise);
			buttonGroupLableTwo.addChild(lableTwoThrow);
			buttonGroupLableTwo.addChild(lableTwoSmallBall);
			buttonGroupLableTwo.addChild(lableTwoMiddleBall);
			buttonGroupLableTwo.addChild(lableTwoBigBall);
			
			//=========显示返回图片
			buttonBack.x = BUTTON_BACK_X;
			buttonBack.y = BUTTON_BACK_Y;
			addChild(buttonBack);
			
			//=========显示请按下所选键图片
			keyWant.x = KEYWANT_X;
			keyWant.y = KEYWANT_Y;
		}
		
		private function soundOnClick(e:MouseEvent):void 
		{

		}
		/**
		 * 监听设置界面，显示请按下所选键图片
		 * 监听当前所选角色的快捷键
		 * @param
		 */
		private function lableOneOnClick(e:MouseEvent):void 
		{
			if (setYet == false)
			{
				addChild(keyWant);
				setYet = true;
			}
			switch(e.target)
			{
				case lableOneRaise:
					keyInfo = 'Lift';
					tempLable = lableOneRaise;
					break;
				case lableOneThrow:
					keyInfo = 'Throw';
					tempLable = lableOneThrow;
					break;
				case lableOneSmallBall:
					keyInfo = 'SwitchSnowballSmall';
					tempLable = lableOneSmallBall;
					break;
				case lableOneMiddleBall:
					keyInfo = 'SwitchSnowballMedium';
					tempLable = lableOneMiddleBall;
					break;
				case lableOneBigBall:
					keyInfo = 'SwitchSnowballLarge';
					tempLable = lableOneBigBall;
					break;
				default:
			}
		}
		
		private function lableTwoOnClick(e:MouseEvent):void 
		{
			if (setYet == false)
			{
				addChild(keyWant);
				setYet = true;
			}
			
			switch(e.target)
			{
				case lableTwoRaise:
					keyInfo = 'Lift';
					tempLable = lableTwoRaise;
					break;
				case lableTwoThrow:
					keyInfo = 'Throw';
					tempLable = lableTwoThrow;
					break;
				case lableTwoSmallBall:
					keyInfo = 'SwitchSnowballSmall';
					tempLable = lableTwoSmallBall;
					break;
				case lableTwoMiddleBall:
					keyInfo = 'SwitchSnowballMedium';
					tempLable = lableTwoMiddleBall;
					break;
				case lableTwoBigBall:
					keyInfo = 'SwitchSnowballLarge';
					tempLable = lableTwoBigBall;
					break;
				default:
			}
		}
		/**
		 * 监听键盘事件，确定所选的快捷键
		 * @param
		 */
		private function oneKeyDown(e:KeyboardEvent):void
		{
			if (setYet == true)
			{
				removeChild(keyWant);
				setYet = false;
				
				for ( var tmp:String in Setting.current.hotkeys[0])
				{
					if (tmp == keyInfo)
						delete Setting.current.hotkeys[0][tmp];
				}
				
				if ((Keyboard.NUMBER_0 <= e.keyCode && e.keyCode <= Keyboard.NUMBER_9)
					|| (Keyboard.A <= e.keyCode && e.keyCode <= Keyboard.Z) 
					|| (Keyboard.NUMPAD_0 <= e.keyCode && e.keyCode <= Keyboard.NUMPAD_9))
				{	
					Setting.current.hotkeys[0][e.keyCode] = keyInfo;
					
					var ch:String = String.fromCharCode(e.keyCode);
					if (Keyboard.NUMPAD_0 <= e.keyCode && e.keyCode <= Keyboard.NUMPAD_9)
					{	
						e.keyCode = e.keyCode - 48;
						ch = String.fromCharCode(e.keyCode);
						ch = '小键盘' + ch;
					}
					tempLable.text = ch;
				}
				else
				{
					// TODO: 播放警告音效
				}
			}
		}
		
		private function twoKeyDown(e:KeyboardEvent):void
		{
			if (setYet == true)
			{
				removeChild(keyWant);
				setYet = false;

				for ( var tmp:String in Setting.current.hotkeys[1])
				{
					if (tmp == keyInfo)
						delete Setting.current.hotkeys[1][tmp];
				}
				
				if ((Keyboard.NUMBER_0 <= e.keyCode && e.keyCode <= Keyboard.NUMBER_9)
					|| (Keyboard.A <= e.keyCode && e.keyCode <= Keyboard.Z) 
					|| (Keyboard.NUMPAD_0 <= e.keyCode && e.keyCode <= Keyboard.NUMPAD_9))
				{	
					Setting.current.hotkeys[0][e.keyCode] = keyInfo;
					
					var ch:String = String.fromCharCode(e.keyCode);
					if (Keyboard.NUMPAD_0 <= e.keyCode && e.keyCode <= Keyboard.NUMPAD_9)
					{	
						e.keyCode = e.keyCode - 48;
						ch = String.fromCharCode(e.keyCode);
						ch = '小键盘' + ch;
					}
					tempLable.text = ch;
				}
				else
				{
					// TODO: 播放警告音效
				}
			}
		}
		
		private function buttonBackOnClick(e:MouseEvent):void
		{
			Main.current.view = View.MAIN_VIEW;
		}
	}
}