package
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	/**
	 * @author leo126
	 */
	public class Main extends Sprite 
	{	
		private var circle:Sprite;
		private var wight:uint = 230;
		
		public function Main():void
		{

			//addChild(circle);
			circle = new Sprite();
			circle.graphics.beginFill(0xff0000);
			circle.graphics.drawRect(100, 100, wight, 10);
			//circle.graphics.endFill();
			//circle.width=50;
			circle.graphics.endFill();
			stage.focus = circle;
			addChild(circle);
			circle.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		
		private function keyDown(e:KeyboardEvent):void
		{	circle.width = 100;
			if (e.keyCode == Keyboard.LEFT)
			{
				circle.graphics.drawRect(100, 100, x++, 10);
			}
			if (e.keyCode == Keyboard.RIGHT)
			{
				circle.graphics.drawRect(100, 100, x--, 10);
			}
		}
	}
	
}