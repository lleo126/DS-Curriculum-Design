package views 
{
	import assets.AssetManager;
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
	import flash.utils.setInterval;
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
		private static const STATUSBAR_Y_PADDING:Number	= 50;
		private static const FORMAT_SIZE:Number			= 30;
		private static const SCORE_X:Number				= 220;
		private static const SCORE_Y:Number				= 10;
		
		private var ui:Sprite;
		
		private var statusHP1:Bitmap;
		private var statusSP1:Bitmap;
		private var statusHP2:Bitmap;
		private var statusSP2:Bitmap;
		private var statusBar1:Sprite;		
		private var statusBar2:Sprite;
		
		private var statusBarHP1:HPBar;
		private var statusBarSP1:SPBar;
		private var statusBarHP2:HPBar;
		private var statusBarSP2:SPBar;
		
		private var groupScore:Sprite;
		private var score:TextField;
		private var role1_score:TextField;
		private var colon:TextField;
		private var role2_score:TextField;
		
		private var pressESCYet:Boolean = false;
		private var _stop:Sprite;
		private var menuImg:Bitmap;
		private var stopBackground:Bitmap;
		private var returnGame:SimpleButton;
		private var buttonBack:SimpleButton;
		
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
		public function get world():World 
		{
			return _world;
		}
		
		//==========
		// 方法
		//==========
		override protected function init(ev:Event = null):void 
		{	ui = new Sprite();
		
			_stop = new Sprite();
			menuImg	= new AssetManager.MENU_IMG();
			stopBackground = new AssetManager.STOPBACKGROUND_IMG();
			var bmp:Bitmap = new AssetManager.RETURN_GAME_IMG();
			returnGame	= new SimpleButton(bmp, bmp, bmp, bmp);
			bmp			= new AssetManager.BUTTON_BACK_IMG();
			buttonBack	= new SimpleButton(bmp, bmp, bmp, bmp)
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			
			groupScore	= new Sprite();
			score		= new TextField();
			role1_score = new TextField();
			colon		= new TextField();
			role2_score = new TextField();
			
			statusHP1	= new AssetManager.HP_IMG();
			statusSP1	= new AssetManager.SP_IMG();
			statusHP2	= new AssetManager.HP_IMG();
			statusSP2	= new AssetManager.SP_IMG();
			
			statusBar1	= new Sprite();
			statusBarHP1= new HPBar();
			statusBarSP1= new SPBar();
			
			statusBar2	= new Sprite();
			statusBarHP2= new HPBar();
			statusBarSP2= new SPBar();
			super.init();
		}
		
		override protected function placeElements():void 
		{
			addChild(ui);
			//=========暂停界面=======
			_stop.graphics.beginFill(0x000000, 0.26);
			_stop.graphics.drawRect(0,0,this.stage.stageWidth, this.stage.stageHeight);
			_stop.graphics.endFill();
			_stop.addEventListener(MouseEvent.CLICK, onClick);
			
			_stop.addChild(menuImg);
			_stop.addChild(stopBackground);
			_stop.addChild(returnGame);
			_stop.addChild(buttonBack);
			
			menuImg.x = 440;
			menuImg.y = 100;
			
			stopBackground.x= menuImg.x - 22;
			stopBackground.y= menuImg.y + 80;
			
			returnGame.x	= menuImg.x + 20;
			returnGame.y	= stopBackground.y + 60;
			buttonBack.x	= menuImg.x + 20;
			buttonBack.y	= returnGame.y + 60;
			//=========状态栏=========
			statusBar1.x = STATUSBAR_X;
			statusBar1.y = STATUSBAR_Y;
			
			statusBarSP1.y = statusBarHP1.y + STATUSBAR_Y_PADDING;
			statusHP1.x = statusBar1.x - 200;
			statusHP1.y = statusBarHP1.y - 8;
			statusSP1.x = statusBar1.x - 200;
			statusSP1.y = statusBarSP1.y - 8;
			
			ui.addChild(statusBar1);
			statusBar1.addChild(statusHP1);
			statusBar1.addChild(statusBarHP1);
			statusBar1.addChild(statusSP1);
			statusBar1.addChild(statusBarSP1);
			
			statusBar2.x = STATUSBAR_X + STATUSBAR_X_PADDING;
			statusBar2.y = STATUSBAR_Y;
			
			statusBarSP2.y = statusBarHP2.y + STATUSBAR_Y_PADDING;
			statusHP2.x = -60;
			statusHP2.y = -8;
			statusSP2.x = -60;
			statusSP2.y = statusBarSP2.y - 8;
			
			ui.addChild(statusBar2);
			statusBar2.addChild(statusHP2);
			statusBar2.addChild(statusBarHP2);
			statusBar2.addChild(statusSP2);
			statusBar2.addChild(statusBarSP2);
			
			//=========分数=========
			var format:TextFormat = new TextFormat();
			format.size 				= FORMAT_SIZE;
			
			groupScore.y = SCORE_Y;
			
			score.autoSize = "left";
			score.defaultTextFormat			= format;
			role1_score.autoSize = "right";
			role1_score.defaultTextFormat	= format;
			role2_score.autoSize = "left";
			role2_score.defaultTextFormat	= format;
			colon.defaultTextFormat			= format;
			
			score.text		= 'SCORE';
			role1_score.text= '0';
			colon.text		= ':';
			role2_score.text= '0';
			
			colon.x = stage.stageWidth * 0.5;
			score.x = colon.x - 360;
			role1_score.x = colon.x - 60 - role1_score.width;
			role2_score.x = colon.x + 60;

			ui.addChild(groupScore);
			groupScore.addChild(score);
			groupScore.addChild(role1_score);
			groupScore.addChild(colon);
			groupScore.addChild(role2_score);
			
			//=============================
			
			addChild(_world);
		}
		
		private function keyDown(e:KeyboardEvent):void
		{
			//super.inactivate(ev);
			if (!active) return;
			
			if (!pressESCYet && e.keyCode == Keyboard.ESCAPE)
			{
				pressESCYet = true;
				ui.addChild(_stop);
			}
			else if (pressESCYet && e.keyCode == Keyboard.ESCAPE)
			{
				pressESCYet = false;
				ui.removeChild(_stop);
			}
		}

		private function onClick(e:MouseEvent):void 
		{
			if (e.target == returnGame)
			{	
				pressESCYet = false;
				ui.removeChild(_stop);
				stage.focus = null;
			}
			else if (e.target == buttonBack)
			{
				pressESCYet = false;
				ui.removeChild(_stop);
				Main.current.view = View.MAIN_VIEW;
			}
			
		}

		override protected function inactivate(ev:Event):void 
		{
			super.inactivate(ev);
			world.dispose();
		}
	}
}