package views
{
	import assets.AssetManager;
	import flash.display.Bitmap;
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * 成绩界面
	 * @author 彩月葵☆彡
	 */
	public class ScoreView extends View
	{
		static public const BUTTON_BACK_X:Number = 60;
		static public const BUTTON_BACK_Y:Number = 660;
		static public const BUTTON_RETURN_X:Number = 445;
		static public const BUTTON_RETURN_Y:Number = 560;
		static public const BLACKBOARD_WIDTH:Number = 900;
		static public const BLACKBOARD_HEIGHT:Number = 400;
		static public const BLACKBOARD_X:Number = 60;
		static public const BLACKBOARD_Y:Number = 120;
		static public const FORMAT_CHALLENGE_SIZE:Number = 80;
		static public const FORMAT_BATTLE_NUM_SIZE:Number = 30;
		static public const FORMAT_BATTLE_WORLD_SIZE:Number = 100;
		static public const SHOW_Y:Number = 250;
		static public const SHOW_WIDTH:Number = 400;
		static public const CHALLENGE_TWO_SHOW1_X:Number = 60;
		static public const CHALLENGE_TWO_SHOW2_X:Number = 500;
		static public const CHALLENGE_ONE_SHOW1_X:Number = 200;
		static public const FAIL_X:Number = 400;
		static public const WIN_X:Number = -40;
		static public const BATTLE_SCORE_X1:Number = 30;
		static public const BATTLE_SCORE_X2:Number = 470;
		static public const BATTLE_SCORE_Y:Number = 360;
		static public const LINE_Y:Number = 350;
		static public const LINE_ONE_X_B:Number = 250;
		static public const LINE_ONE_X_E:Number = 750;
		static public const LINE_TWO_LINE1_X_B:Number = 150;
		static public const LINE_TWO_LINE1_X_E:Number = 450;
		static public const LINE_TWO_LINE2_X_B:Number = 590;
		static public const LINE_TWO_LINE2_X_E:Number = 890;
		static public const LINE_TWO_LINE1_BATTLE_X_B:Number = 590;
		static public const LINE_TWO_LINE1_BATTLE_X_E:Number = 890;
		static public const LINE_Y_BATTLE:Number = 400;
		
		//按钮组定义
		private var buttonGroup:Sprite;
		private var buttonBack:SimpleButton;
		private var buttonReturn:SimpleButton;
		
		//分数组定义
		private var scoreGroup:Sprite;
		private var blackboard:Bitmap;
		private var scorePlayerShow1:TextField;
		private var scorePlayerShow2:TextField;
		private var win:TextField;
		private var fail:TextField;
		private var scorePlayer1:Number;
		private var scorePlayer2:Number;
		private var format:TextFormat = new TextFormat();
		private var line1:Shape;//双人挑战白线1
		private var line2:Shape;//双人挑战白线2
		private var line3:Shape;//单人白线
		private var line4:Shape;//双人对战白线1
		private var line5:Shape;//双人对战白线2
		
		//模式区分 单人双人区分
		public var playerType:Number;
		public var type:String;
		
		public function ScoreView()
		{
			//传入的分数(测试用)
			scorePlayer1 = 4326;//测试用 等传入数值1
			scorePlayer2 = 4957;//测试用 等传入数值2
			playerType = 1;
			//type = 'challenge';
			
			
			//分数组
			format.align = 'right';
			format.color = 0xFFFFFF;
			
			scoreGroup = new Sprite();
			//scoreGroup.addEventListener(MouseEvent.CLICK, inactivate);
			
			blackboard = new AssetManager.BLACKBOARD_IMG();
			
			scorePlayerShow1 = new TextField();
			scorePlayerShow2 = new TextField(); 
			scorePlayerShow1.width = SHOW_WIDTH;
			scorePlayerShow2.width = SHOW_WIDTH;
			
			format.size = FORMAT_BATTLE_WORLD_SIZE;
			win = new TextField();
			win.defaultTextFormat = format;
			win.text = '胜!';
			win.textColor = 0xFF0000;
			fail = new TextField();
			fail.defaultTextFormat = format;
			fail.text = '败!';
			fail.textColor = 0xADD8E6;
			win.width = SHOW_WIDTH;
			fail.width = SHOW_WIDTH;
			
			line1 = new Shape();
			line2 = new Shape();
			line3 = new Shape();
			line4 = new Shape();
			line5 = new Shape();		
			line1.graphics.lineStyle(0, 0xFFFFFF);
			line2.graphics.lineStyle(0, 0xFFFFFF);
			line3.graphics.lineStyle(0, 0xFFFFFF);
			line4.graphics.lineStyle(0, 0xFFFFFF);
			line5.graphics.lineStyle(0, 0xFFFFFF);
			line1.graphics.moveTo(LINE_TWO_LINE1_X_B, LINE_Y);
			line1.graphics.lineTo(LINE_TWO_LINE1_X_E, LINE_Y);
			line2.graphics.moveTo(LINE_TWO_LINE2_X_B, LINE_Y);
			line2.graphics.lineTo(LINE_TWO_LINE2_X_E, LINE_Y);
			line3.graphics.moveTo(LINE_ONE_X_B, LINE_Y );
			line3.graphics.lineTo(LINE_ONE_X_E, LINE_Y);
			line4.graphics.moveTo(LINE_TWO_LINE1_X_B, LINE_Y_BATTLE);
			line4.graphics.lineTo(LINE_TWO_LINE1_X_E, LINE_Y_BATTLE);
			line5.graphics.moveTo(LINE_TWO_LINE2_X_B, LINE_Y_BATTLE);
			line5.graphics.lineTo(LINE_TWO_LINE2_X_E, LINE_Y_BATTLE);
			
			//按钮组
			buttonGroup = new Sprite();
			buttonGroup.addEventListener(MouseEvent.CLICK, buttonClick);
			
			var bmp:Bitmap = new AssetManager.BUTTON_BACK_IMG();
			buttonBack = new SimpleButton(bmp, bmp, bmp, bmp);
			
			bmp = new AssetManager.RETURN_GAME_IMG();
			buttonReturn = new SimpleButton(bmp, bmp, bmp, bmp);
		}
		
		override protected function placeElements():void
		{
			//分数类显示
			blackboard.width = BLACKBOARD_WIDTH;
			blackboard.height = BLACKBOARD_HEIGHT;
			blackboard.x = BLACKBOARD_X;
			blackboard.y = BLACKBOARD_Y;
			
			addChild(scoreGroup);
			scoreGroup.addChild(blackboard);
			
			if (type == 'challenge')
			{
				format.size = FORMAT_CHALLENGE_SIZE;
				scorePlayerShow1.defaultTextFormat = format;
				scorePlayerShow2.defaultTextFormat = format;
				scorePlayerShow1.text = scorePlayer1.toString();
				scorePlayerShow2.text = scorePlayer2.toString();
				if (playerType == 1)
				{
					scorePlayerShow1.x = CHALLENGE_ONE_SHOW1_X;
					scorePlayerShow1.y = SHOW_Y;		
					scoreGroup.addChild(scorePlayerShow1);
					scoreGroup.addChild(line3);
				}
				else
				{
					scorePlayerShow1.x = CHALLENGE_TWO_SHOW1_X;
					scorePlayerShow1.y = SHOW_Y;
					scorePlayerShow2.x = CHALLENGE_TWO_SHOW2_X;
					scorePlayerShow2.y = SHOW_Y;
					scoreGroup.addChild(scorePlayerShow1);
					scoreGroup.addChild(scorePlayerShow2);
					scoreGroup.addChild(line1);
					scoreGroup.addChild(line2);
				}
			}else 
			{
				format.size = FORMAT_BATTLE_NUM_SIZE;
				scorePlayerShow1.defaultTextFormat = format;
				scorePlayerShow2.defaultTextFormat = format;
				scorePlayerShow1.text = scorePlayer1.toString();
				scorePlayerShow2.text = scorePlayer2.toString();
				fail.x = FAIL_X;
				fail.y = SHOW_Y;
				win.x = WIN_X;
				win.y = SHOW_Y;
				scorePlayerShow1.y = BATTLE_SCORE_Y;
				scorePlayerShow1.x = BATTLE_SCORE_X1;
				scorePlayerShow2.y = BATTLE_SCORE_Y;
				scorePlayerShow2.x = BATTLE_SCORE_X2;
				scoreGroup.addChild(win);
				scoreGroup.addChild(fail);
				scoreGroup.addChild(scorePlayerShow1);
				scoreGroup.addChild(scorePlayerShow2);
				scoreGroup.addChild(line4);
				scoreGroup.addChild(line5);
			}
			
			//=========返回按钮和继续游戏按钮
			buttonBack.x = BUTTON_BACK_X;
			buttonBack.y = BUTTON_BACK_Y;
			buttonReturn.x = BUTTON_RETURN_X;
			buttonReturn.y = BUTTON_RETURN_Y;
			
			addChild(buttonGroup);
			buttonGroup.addChild(buttonBack);
			buttonGroup.addChild(buttonReturn);
		}
		
		private function buttonClick(e:MouseEvent):void
		{
			switch(e.target) 
			{
				case buttonBack:
					Main.current.view = View.MAIN_VIEW;
					break;
				case buttonReturn:
					
					if (type == 'challenge') 
					{
						Main.current.view = View.CHALLENGE_VIEW;
					}
					else
					{
						Main.current.view = View.PLAY_VIEW;
					}
			}
		}
		
		override protected function inactivate(ev:Event):void
		{
			super.inactivate(ev);
			
			SCORE_VIEW.removeChild(scoreGroup);
		}
		
		override protected function activate(ev:Event):void
		{
			super.activate(ev);
			
			placeElements();
		}
	}

}