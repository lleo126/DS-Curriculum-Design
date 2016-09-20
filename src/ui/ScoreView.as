package ui 
{
	import flash.display.Shape;
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class ScoreView extends View 
	{
		public function ScoreView() 
		{
			super(ViewType.SCORE_VIEW);
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