package views 
{
	import assets.AssetManager;
	import controls.Slider;
	import flash.display.Bitmap;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import models.Setting;
	/**
	 * 设置界面
	 * @author leo126
	 */
	public class SettingView extends View 
	{
		static private const GROUP_SOUND_X:Number			= 120;
		static private const GROUP_SOUND_Y:Number			= 200;
		static private const SOUND_PADDING:Number			= 400;
		static private const GROUP_KEYPRESS_X:Number		= 240;
		static private const GROUP_KEYPRESS_Y:Number		= 360;
		static private const KEYPRESS_PADDING:Number		= 140;
		static private const GROUP_ROLE_X:Number			= 120;
		static private const GROUP_ROLE_Y:Number			= 440;
		static private const ROLE_PADDING:Number			= 100;
		static private const SETTING_X:Number				= 360;
		static private const SETTING_WIDTH:Number			= 300;
		static private const SETTING_HEIGHT:Number			= 170;
		static private const BUTTON_BACK_X:Number			= 60;
		static private const BUTTON_BACK_Y:Number			= 660;
		static public const BUTTON_WIDTH:Number    			= 150;
		static public const BUTTON_HEIGHT:Number    		= 60;
		static private const GROUP_LABLE_ONE_X:Number		= 240;
		static private const GROUP_LABLE_ONE_Y:Number		= 440;
		static private const GROUP_LABLE_TWO_X:Number		= 240;
		static private const GROUP_LABLE_TWO_Y:Number		= 540;
		static private const LABLE_WIDTH:Number 			= 20;
		static private const LABLE_HEIGHT:Number			= 28;
		static private const FORMAT_SIZE:Number				= 26;
		static private const KEYWANT_X:Number				= 400;
		static private const KEYWANT_Y:Number				= 600;
		
		private var setYet:Boolean = false;
		private var keyInfo:String;
		
		private var buttonGroupSound:Sprite;
		private var buttonGroupKeyPress:Sprite;
		private var buttonGroupRole:Sprite;
		private var buttonGroupLableOne:Sprite;
		private var buttonGroupLableTwo:Sprite;
		
		private var setting:Bitmap;
		private var soundPanel:Bitmap;
		private var music:Bitmap;
		private var soundEffect:Bitmap;
		private var hotKeyPanel:Bitmap;
		private var roleOne:Bitmap;
		private var roleTwo:Bitmap;
		private var raise:Bitmap;
		private var _throw:Bitmap;
		private var smallBall:Bitmap;
		private var middleBall:Bitmap;
		private var bigBall:Bitmap;	
		private var keyWant:Bitmap;
		
		private var buttonBack:SimpleButton;
		
		private var labelRaise1:TextField;
		private var labelThrow1:TextField;
		private var labelSmallBall1:TextField;
		private var labelMiddleBall1:TextField;
		private var labelBigBall1:TextField;
		private var labelRaise2:TextField;
		private var labelThrow2:TextField;
		private var labelSmallBall2:TextField;
		private var labelMiddleBall2:TextField;
		private var labelBigBall2:TextField;
		private var tempLable:TextField;
		private var slider1:Slider;
		private var slider2:Slider;
		
		private var background:Bitmap;
		
		public function SettingView() 
		{
			 
		}
			
		override protected function init(ev:Event = null):void 
		{
			
			background = new AssetManager.SETTING_BACKGROUND();
			
			buttonGroupSound 	= new Sprite();
			buttonGroupKeyPress = new Sprite();
			buttonGroupRole 	= new Sprite();
			
			buttonGroupLableOne = new Sprite();
			buttonGroupLableOne.addEventListener(MouseEvent.CLICK, labelOnClick);
			buttonGroupLableOne.addEventListener(KeyboardEvent.KEY_DOWN, function (ev:KeyboardEvent):void { keyDown(ev, 0); });
			buttonGroupLableTwo = new Sprite();
			buttonGroupLableTwo.addEventListener(MouseEvent.CLICK, labelOnClick);
			buttonGroupLableTwo.addEventListener(KeyboardEvent.KEY_DOWN, function (ev:KeyboardEvent):void { keyDown(ev, 1); });

			setting 	= new AssetManager.SETTING_IMG();
			setting.smoothing = true;
			
			soundPanel	= new AssetManager.SOUND_PANEL_IMG();
			music 		= new AssetManager.MUISC_IMG();
			soundEffect = new AssetManager.SOUNDEFFECT_IMG();
			slider1		= new Slider(Setting.current.soundValue, 100.0);
			slider1.addEventListener(Event.CHANGE, setSoundValue);
			slider2		= new Slider(Setting.current.soundEffectValue, 100.0);
			slider2.addEventListener(Event.CHANGE, setSoundEffectValue);
			
			hotKeyPanel	= new AssetManager.HOT_KEY_PANEL_IMG();
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
			
			labelRaise1 		= new TextField();
			labelThrow1 		= new TextField();
			labelSmallBall1 	= new TextField();
			labelMiddleBall1 	= new TextField();
			labelBigBall1		= new TextField();
			labelRaise2 		= new TextField();
			labelThrow2 		= new TextField();
			labelSmallBall2		= new TextField();
			labelMiddleBall2 	= new TextField();
			labelBigBall2		= new TextField();
			
			super.init();
		}
				
		private function setSoundValue(e:Event):void 
		{
			Setting.current.soundValue = slider1.value;
			AssetManager.transMusic.volume = slider1.value / 100;
			AssetManager.songMusic.soundTransform = AssetManager.transMusic;
		}
		
		private function setSoundEffectValue(e:Event):void 
		{
			Setting.current.soundEffectValue = slider2.value;
			AssetManager.transEffect.volume = slider2.value / 100;
			AssetManager.songEffect.soundTransform = AssetManager.transEffect;
		}
		
		override protected function placeElements():void 
		{
			background.x = (stage.stageWidth - background.width) * 0.5;
			addChild(background);
			
			setting.x = SETTING_X;
			setting.width = SETTING_WIDTH;
			setting.height = SETTING_HEIGHT;
			
			addChild(setting);
			
			//=========显示声音组图片
			buttonGroupSound.x = GROUP_SOUND_X;
			buttonGroupSound.y = GROUP_SOUND_Y;
			
			
			soundEffect.x	= music.x + SOUND_PADDING; 
			
			soundPanel.x = music.x - 20;
			soundPanel.y = music.y - 50;
			
			slider1.x = music.x + 140;
			slider1.y = music.y + 20;
			
			slider2.x = slider1.x + SOUND_PADDING;
			slider2.y = slider1.y;
			
			//muisc图片微调
			music.x = music.x + 10;
			music.y = music.y + 3;
			
			addChild(buttonGroupSound);
			buttonGroupSound.addChild(soundPanel);
            buttonGroupSound.addChild(music);
			buttonGroupSound.addChild(slider1);
			buttonGroupSound.addChild(soundEffect);
			buttonGroupSound.addChild(slider2);
			//=========显示按键组图片
			buttonGroupKeyPress.x = GROUP_KEYPRESS_X;
			buttonGroupKeyPress.y = GROUP_KEYPRESS_Y;
			
			hotKeyPanel.x= raise.x		- 140;
			hotKeyPanel.y = raise.y		- 60;
			
			_throw.x     = raise.x      + KEYPRESS_PADDING;
			smallBall.x  = _throw.x     + KEYPRESS_PADDING;
			middleBall.x = smallBall.x  + KEYPRESS_PADDING;
			bigBall.x    = middleBall.x + KEYPRESS_PADDING;

			addChild(buttonGroupKeyPress);
			buttonGroupKeyPress.addChild(hotKeyPanel);
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
			
			labelRaise1.defaultTextFormat		= format;
			labelThrow1.defaultTextFormat 		= format;
			labelSmallBall1.defaultTextFormat	= format;
			labelMiddleBall1.defaultTextFormat	= format;
			labelBigBall1.defaultTextFormat		= format;
			labelRaise1.text	 	= "J";			
			labelThrow1.text	 	= "K";
			labelSmallBall1.text	= "U";
			labelMiddleBall1.text	= "I";
			labelBigBall1.text 		= "O";

			buttonGroupLableOne.x = GROUP_LABLE_ONE_X;
			buttonGroupLableOne.y = GROUP_LABLE_ONE_Y;
			
			labelThrow1.x 		= labelRaise1.x 	+ KEYPRESS_PADDING;
			labelSmallBall1.x 	= labelThrow1.x		+ KEYPRESS_PADDING;
			labelMiddleBall1.x	= labelSmallBall1.x	+ KEYPRESS_PADDING;
			labelBigBall1.x		= labelMiddleBall1.x+ KEYPRESS_PADDING;
			
			addChild(buttonGroupLableOne);
			buttonGroupLableOne.addChild(labelRaise1);
			buttonGroupLableOne.addChild(labelThrow1);
			buttonGroupLableOne.addChild(labelSmallBall1);
			buttonGroupLableOne.addChild(labelMiddleBall1);
			buttonGroupLableOne.addChild(labelBigBall1);
			
			labelRaise2.defaultTextFormat		= format;
			labelThrow2.defaultTextFormat		= format;
			labelSmallBall2.defaultTextFormat	= format;
			labelMiddleBall2.defaultTextFormat	= format;
			labelBigBall2.defaultTextFormat 	= format;
			labelRaise2.text	 	= "小键盘1";
			labelThrow2.text	 	= "小键盘2";
			labelSmallBall2.text	= "小键盘4";
			labelMiddleBall2.text	= "小键盘5";
			labelBigBall2.text 		= "小键盘6";

			buttonGroupLableTwo.x = GROUP_LABLE_TWO_X;
			buttonGroupLableTwo.y = GROUP_LABLE_TWO_Y;
			
			labelThrow2.x 		= labelRaise2.x 		+ KEYPRESS_PADDING;
			labelSmallBall2.x 	= labelThrow2.x 		+ KEYPRESS_PADDING;
			labelMiddleBall2.x	= labelSmallBall2.x 	+ KEYPRESS_PADDING;
			labelBigBall2.x 	= labelMiddleBall2.x	+ KEYPRESS_PADDING;
			
			addChild(buttonGroupLableTwo);
			buttonGroupLableTwo.addChild(labelRaise2);
			buttonGroupLableTwo.addChild(labelThrow2);
			buttonGroupLableTwo.addChild(labelSmallBall2);
			buttonGroupLableTwo.addChild(labelMiddleBall2);
			buttonGroupLableTwo.addChild(labelBigBall2);
			
			//=========显示返回图片
			buttonBack.x = BUTTON_BACK_X;
			buttonBack.y = BUTTON_BACK_Y;
			buttonBack.width = BUTTON_WIDTH;
			buttonBack.height = BUTTON_HEIGHT;
			addChild(buttonBack);
			
			//=========显示请按下所选键图片
			keyWant.x = KEYWANT_X;
			keyWant.y = KEYWANT_Y;
		}

		/**
		 * 监听设置界面，显示请按下所选键图片
		 * 监听当前所选角色的快捷键
		 * @param
		 */
		private function labelOnClick(e:MouseEvent):void 
		{
			if (setYet == false)
			{
				addChild(keyWant);
				setYet = true;
			}
			switch(e.target)
			{	//玩家1
				case labelRaise1:
					keyInfo = 'Lift';
					tempLable = labelRaise1;
					break;
				case labelThrow1:
					keyInfo = 'Throw';
					tempLable = labelThrow1;
					break;
				case labelSmallBall1:
					keyInfo = 'SwitchSmall';
					tempLable = labelSmallBall1;
					break;
				case labelMiddleBall1:
					keyInfo = 'SwitchMedium';
					tempLable = labelMiddleBall1;
					break;
				case labelBigBall1:
					keyInfo = 'SwitchLarge';
					tempLable = labelBigBall1;
					break;
				//玩家2	
				case labelRaise2:
					keyInfo = 'Lift';
					tempLable = labelRaise2;
					break;
				case labelThrow2:
					keyInfo = 'Throw';
					tempLable = labelThrow2;
					break;
				case labelSmallBall2:
					keyInfo = 'SwitchSmall';
					tempLable = labelSmallBall2;
					break;
				case labelMiddleBall2:
					keyInfo = 'SwitchMedium';
					tempLable = labelMiddleBall2;
					break;
				case labelBigBall2:
					keyInfo = 'SwitchLarge';
					tempLable = labelBigBall2;
					break;
				default:
			}
		}
		
		/**
		 * 监听键盘事件，确定所选的快捷键
		 * @param
		 */
		private function keyDown(e:KeyboardEvent, ID:int):void 
		{
			if (setYet == true)
			{
				removeChild(keyWant);
				setYet = false;
				
				if (!(e.keyCode in Setting.current.hotkeys[0]) && !(e.keyCode in Setting.current.hotkeys[1])
				&& ((Keyboard.NUMBER_0 <= e.keyCode && e.keyCode <= Keyboard.NUMBER_9)
				|| (Keyboard.A <= e.keyCode && e.keyCode <= Keyboard.Z) 
				|| (Keyboard.NUMPAD_0 <= e.keyCode && e.keyCode <= Keyboard.NUMPAD_9)
				|| (Keyboard.NUMPAD_MULTIPLY <= e.keyCode && e.keyCode <= Keyboard.NUMPAD_DIVIDE)
				|| (e.keyCode == Keyboard.MINUS) || (e.keyCode == Keyboard.EQUAL) || (e.keyCode == Keyboard.COMMA)
				|| (e.keyCode == Keyboard.SEMICOLON) || (e.keyCode == Keyboard.QUOTE) || (e.keyCode == Keyboard.SPACE)
				|| (e.keyCode == Keyboard.LEFTBRACKET) || (e.keyCode == Keyboard.RIGHTBRACKET) || (e.keyCode == Keyboard.BACKSLASH)
				|| (e.keyCode == Keyboard.BACKQUOTE) || (e.keyCode == Keyboard.PERIOD) || (e.keyCode == Keyboard.SLASH)))
				{	
						for (var tmp:* in Setting.current.hotkeys[ID])
						{
							if (Setting.current.hotkeys[ID][tmp] == keyInfo)
								delete Setting.current.hotkeys[ID][tmp];
						}
						
						Setting.current.hotkeys[ID][e.keyCode] = keyInfo;
						
						var ch:String = String.fromCharCode(e.keyCode);
						if (Keyboard.NUMPAD_0 <= e.keyCode && e.keyCode <= Keyboard.NUMPAD_9)
						{	
							e.keyCode = e.keyCode - 48;
							ch = String.fromCharCode(e.keyCode);
							ch = '小键盘' + ch;
						}
						
						switch (e.keyCode)
						{
							case 106:
								ch = '小键盘*';
								break;
							case 107:
								ch = '小键盘+';
								break;
							case 108:
								ch = '小键盘Enter';
								break;
							case 109:
								ch = '小键盘-';
								break;
							case 110:
								ch = '小键盘.';
								break;
							case 111:
								ch = '小键盘/';
								break;
							case 189:
								ch = '-';
								break;
							case 187:
								ch = '=';
								break;
							case 186:
								ch = ';';
								break;
							case 222:
								ch = '\'';
								break;
							case 32:
								ch = 'SPACE';
								break;
							case 219:
								ch = '[';
								break;
							case 220:
								ch = '\\';
								break;
							case 221:
								ch = ']';
								break;
							case 192:
								ch = '`';
								break;
							case 188:
								ch = ',';
								break;
							case 190:
								ch = '.';
								break;
							case 191:
								ch = '/';
								break;
							default:
						}
						
						tempLable.text = ch;
						
						AssetManager.soundEffect = new Sound();
						AssetManager.soundEffect.load(new URLRequest("music/Setting_Success.mp3"));
						AssetManager.songEffect = AssetManager.soundEffect.play();
						AssetManager.songEffect.soundTransform = AssetManager.transEffect;
				}
				else
				{
					AssetManager.soundEffect = new Sound();
					AssetManager.soundEffect.load(new URLRequest("music/Setting_Fail.mp3"));
					AssetManager.songEffect = AssetManager.soundEffect.play();
					AssetManager.songEffect.soundTransform = AssetManager.transEffect;
				}
			}
		}
		
		private function buttonBackOnClick(e:MouseEvent):void
		{
			Main.current.view = View.MAIN_VIEW;
		}
	}
}