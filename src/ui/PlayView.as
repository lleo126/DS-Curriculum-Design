package ui 
{
	import flash.display.Shape;
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class PlayView extends View 
	{
		public function PlayView() 
		{
			super(ViewType.PLAY_VIEW);
		}
		
		override public function placeElements():void 
		{
			//var shape:Shape = new Shape();
			//shape.graphics.beginFill(0xF28405);
			//shape.graphics.drawCircle(20, 20, 30);
			//shape.graphics.endFill();
			//addChild(shape);
		}
		
		override public function restore():void 
		{
			
		}
	}

}