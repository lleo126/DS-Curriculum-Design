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
		
		
		public function MainView() 
		{
			super(ViewType.MAIN_VIEW);
		}
		
		override public function placeElements():void 
		{
			var Button_Battle:CustomSimpleButton = new CustomSimpleButton(100, 180);
			var Button_Challenge:CustomSimpleButton = new CustomSimpleButton(100, 260);
			var Button_Setting:CustomSimpleButton = new CustomSimpleButton(100, 340);
			var Button_Exit:CustomSimpleButton = new CustomSimpleButton(100, 420);
			var Button_About:CustomSimpleButton = new CustomSimpleButton(700, 580);
			//button.downState = new CHALLENGE_IMG();
			Button_Challenge.upState = new BUTTON_Challenge_IMG();
			Button_Battle.upState = new BUTTON_Battle_IMG();
			Button_Setting.upState = new BUTTON_Setting_IMG();
			Button_Exit.upState = new BUTTON_Exit_IMG();
			Button_About.upState = new BUTTON_About_IMG();
			
			Button_Challenge.overState = new BUTTON_Challenge_Down_IMG();
			Button_Battle.overState = new BUTTON_Battle_Down_IMG();
			Button_Setting.overState = new BUTTON_Setting_Down_IMG();
			Button_Exit.overState = new BUTTON_Exit_Down_IMG();
			Button_About.overState = new BUTTON_About_Down_IMG();
			
			Button_About.width = 144;
			Button_About.height = 36;

            addChild(Button_Challenge);
			addChild(Button_Battle);
			addChild(Button_Setting);
			addChild(Button_Exit);
			addChild(Button_About);
			
			//var shape:Shape = new Shape();
			//shape.graphics.beginFill(0xF28405);
			//shape.graphics.drawCircle(20, 20, 30);
			//shape.graphics.endFill();
			//addChild(shape);
		}
	}
}