package views 
{
	import assets.AssetManager;
	import controls.APBar;
	import controls.HPBar;
	import controls.SPBar;
	import flash.display.Bitmap;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import models.Clock;
	import models.Player;
	import units.World;
	/**
	 * 游戏界面
	 * @author 彩月葵☆彡
	 */
	public class PlayView extends View 
	{
		public static const CHALLENGE:String	= 'challenge';
		public static const BATTLE:String		= 'battle';
		
		private static const STATUSBAR_X:Number			= 140;
		private static const STATUSBAR_Y:Number			= 600;
		private static const STATUSBAR_X_PADDING:Number	= 600;
		private static const STATUSBAR_Y_PADDING:Number	= 30;
		private static const FORMAT_SIZE:Number			= 30;
		private static const SCORE_X:Number				= 220;
		private static const SCORE_Y:Number				= 10;
		
		public var statusBarHP1:HPBar;
		public var statusBarSP1:SPBar;
		public var statusBarAP1:APBar;
		public var statusBarHP2:HPBar;
		public var statusBarSP2:SPBar;
		public var statusBarAP2:APBar;
		public var role1_score:TextField;
		public var role2_score:TextField;
		
		private var ui:Sprite;
		
		private var baffle1:Bitmap;
		private var baffle2:Bitmap;
		
		private var _dateTime:Clock;
		
		public function get dateTime():Clock { return _dateTime; }
		
		private var statusHP1:Bitmap;
		private var statusSP1:Bitmap;
		private var statusHP2:Bitmap;
		private var statusSP2:Bitmap;
		private var statusAP1:Bitmap;
		private var statusAP2:Bitmap;
		private var statusBar1:Sprite;		
		private var statusBar2:Sprite;
		
		private var groupScore:Sprite;
		private var scoreBaffle:Bitmap;
		private var score:TextField;
		private var colon:TextField;
		
		private var pressESCYet:Boolean = false;
		private var _stop:Sprite;
		private var menuImg:Bitmap;
		private var stopBackground:Bitmap;
		private var returnGame:SimpleButton;
		private var buttonBack:SimpleButton;
		
		private var timeTxt:TextField;
		
		public function PlayView() 
		{
			
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * 玩家，根据长度可以判断是单人还是双人
		 */
		public var players:Vector.<Player>;
		
		/**
		 * 游戏模式，可以是 CHALLENGE 或 BATTLE
		 */
		public var type:String;
		
		//==========
		// 属性
		//==========
		
		private var _world:World = new World();
		public function get world():World { return _world; }
		
		//==========
		// 方法
		//==========
		override protected function init(ev:Event = null):void 
		{	
			_dateTime = new Clock();
			
			ui = new Sprite();

			_stop = new Sprite();
			menuImg	= new AssetManager.MENU_IMG();
			stopBackground = new AssetManager.STOPBACKGROUND_IMG();
			var bmp:Bitmap = new AssetManager.RETURN_GAME_IMG();
			returnGame	= new SimpleButton(bmp, bmp, bmp, bmp);
			bmp			= new AssetManager.BUTTON_BACK_IMG();
			buttonBack	= new SimpleButton(bmp, bmp, bmp, bmp)
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			
			groupScore	= new Sprite();
			scoreBaffle = new AssetManager.BAFFLE();
			score		= new TextField();
			role1_score = new TextField();
			colon		= new TextField();
			role2_score = new TextField();
			
			statusHP1	= new AssetManager.HP_IMG();
			statusSP1	= new AssetManager.SP_IMG();
			statusHP2	= new AssetManager.HP_IMG();
			statusSP2	= new AssetManager.SP_IMG();
			statusAP1   = new AssetManager.AP_IMG();
			statusAP2   = new AssetManager.AP_IMG();
			baffle1     = new AssetManager.BAFFLE();
			baffle2     = new AssetManager.BAFFLE();
			
			statusBar1	= new Sprite();
			statusBarHP1= new HPBar();
			statusBarSP1 = new SPBar();
			statusBarAP1 = new APBar();
			
			statusBar2	= new Sprite();
			statusBarHP2= new HPBar();
			statusBarSP2 = new SPBar();
			statusBarAP2 = new APBar();
			
			world.addEventListener(Event.COMPLETE, onWorldComplete);
			
			super.init();
		}
		
		override protected function placeElements():void 
		{
			addChild(_world);
			addChild(ui);
			//=========暂停界面=======
			_stop.graphics.beginFill(0x000000, 0.26);
			_stop.graphics.drawRect(0,0,this.stage.stageWidth, this.stage.stageHeight);
			_stop.graphics.endFill();
			_stop.addEventListener(MouseEvent.CLICK, onClick);
			
			_stop.addChild(stopBackground);
			_stop.addChild(returnGame);
			_stop.addChild(buttonBack);
			_stop.addChild(menuImg);
			
			menuImg.smoothing = true;
			menuImg.width = 300;
			menuImg.height = 160;
			menuImg.x = 365;
			menuImg.y = 60;
			
			stopBackground.smoothing = true;
			stopBackground.x= 240;
			stopBackground.y = menuImg.y + 110;
			stopBackground.width = 550;
			stopBackground.height = 400;
			
			returnGame.x	= menuImg.x + 95;
			returnGame.y	= stopBackground.y + 100;
			buttonBack.x	= menuImg.x + 80;
			buttonBack.y	= returnGame.y + 100;
			buttonBack.width = 135;
			buttonBack.height = 60;
			//=========状态栏=========
			statusBar1.x = STATUSBAR_X;
			statusBar1.y = STATUSBAR_Y;
			
			statusBarSP1.y = statusBarHP1.y + STATUSBAR_Y_PADDING;
			statusBarAP1.y = statusBarSP1.y + STATUSBAR_Y_PADDING;
			statusHP1.x = statusBar1.x - 200;
			statusHP1.y = statusBarHP1.y;
			statusSP1.x = statusBar1.x - 200;
			statusSP1.y = statusBarSP1.y + 1;
			statusAP1.x = statusBar1.x - 200;
			statusAP1.y = statusBarAP1.y;
			
			baffle1.width = 300;
			baffle1.height = 150;
			baffle1.x = -80;
			baffle1.y = -30;
			
			ui.addChild(statusBar1);
			statusBar1.addChild(baffle1);
			statusBar1.addChild(statusHP1);
			statusBar1.addChild(statusBarHP1);
			statusBar1.addChild(statusSP1);
			statusBar1.addChild(statusBarSP1);
			statusBar1.addChild(statusAP1);
			statusBar1.addChild(statusBarAP1);
			
			
			statusBar2.x = STATUSBAR_X + STATUSBAR_X_PADDING;
			statusBar2.y = STATUSBAR_Y;
			
			statusBarSP2.y = statusBarHP2.y + STATUSBAR_Y_PADDING;
			statusBarAP2.y = statusBarSP2.y + STATUSBAR_Y_PADDING;
			statusHP2.x = -60;
			statusHP2.y = statusBarHP2.y;
			statusSP2.x = -60;
			statusSP2.y = statusBarSP2.y + 1;
			statusAP2.x = -60;
			statusAP2.y = statusBarAP2.y;
			
			baffle2.width = baffle1.width;
			baffle2.height = baffle1.height;
			baffle2.x = baffle1.x;
			baffle2.y = baffle1.y;
			
			ui.addChild(statusBar2);
			statusBar2.addChild(baffle2);
			statusBar2.addChild(statusHP2);
			statusBar2.addChild(statusBarHP2);
			statusBar2.addChild(statusSP2);
			statusBar2.addChild(statusBarSP2);
			statusBar2.addChild(statusAP2);
			statusBar2.addChild(statusBarAP2);
			
			//=========分数=========
			var format:TextFormat = new TextFormat();
			format.size 				= FORMAT_SIZE;
			
			_dateTime.defaultTextFormat = format;
			
			groupScore.y = SCORE_Y;
			
			score.autoSize = "left";
			score.defaultTextFormat			= format;
			role1_score.autoSize = "right";
			role1_score.defaultTextFormat	= format;
			role2_score.autoSize = "left";
			role2_score.defaultTextFormat	= format;
			colon.defaultTextFormat			= format;
			
			colon.x = stage.stageWidth * 0.5;
			
			score.x = colon.x - 260;
			_dateTime.x = score.x - 120;
			scoreBaffle.x = score.x - 140;// score.x / 1.5;
			scoreBaffle.y = -10;
			scoreBaffle.width  =  (role2_score.x - score.x) * 1.5;
			scoreBaffle.height = (score.height) * 1.5;
			
			role1_score.x = colon.x - 54 - role1_score.width;
			role2_score.x = colon.x + 60;
			
			ui.addChild(groupScore);
			groupScore.addChild(_dateTime);
			groupScore.addChild(scoreBaffle);
			groupScore.addChild(score);
			groupScore.addChild(role1_score);
			groupScore.addChild(colon);
			groupScore.addChild(role2_score);
			
			//=============================
		}
		
		private function keyDown(e:KeyboardEvent):void
		{
			if (!active) return;
			
			if (!pressESCYet && e.keyCode == Keyboard.ESCAPE)
			{
				pressESCYet = true;
				_dateTime.stop();
				ui.addChild(_stop);
				_world.resume(false);
			}
			else if (pressESCYet && e.keyCode == Keyboard.ESCAPE)
			{
				pressESCYet = false;
				_dateTime.start();
				ui.removeChild(_stop);
				_world.resume(true);
			}
		}

		private function onClick(e:MouseEvent):void 
		{
			if (e.target == returnGame)
			{	
				pressESCYet = false;
				_dateTime.start();
				ui.removeChild(_stop);
				stage.focus = null;
				_world.resume(true);
			}
			else if (e.target == buttonBack)
			{
				pressESCYet = false;
				ui.removeChild(_stop);
				Main.current.view = View.MAIN_VIEW;
			}
		}
		
		override protected function activate(ev:Event):void 
		{
			super.activate(ev);
			
			score.text			= 'SCORE';
			role1_score.text	= '0';
			colon.text			= ':';
			role2_score.text	= '0';
			
			world.start(type, players);
			_dateTime.reset();
			_dateTime.start();
		}
		
		override protected function inactivate(ev:Event):void 
		{
			super.inactivate(ev);
			world.dispose();
		}
		
		/**
		 * 当游戏结束，跳转到成绩界面
		 * @param	e
		 */
		private function onWorldComplete(e:Event):void 
		{
			View.SCORE_VIEW.players = players;
			Main.current.view = View.SCORE_VIEW;
		}
	}
}