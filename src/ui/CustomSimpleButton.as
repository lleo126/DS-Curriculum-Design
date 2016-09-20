package ui 
{
	/**
	 * ...
	 * @author Weng-x
	 */
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	public class CustomSimpleButton extends SimpleButton {
		private var upColor:uint   = 0xFFCC00;
		private var overColor:uint = 0xCCFF00;
		private var downColor:uint = 0x00CCFF;
		private var X_Size:uint    = 180;
		private var Y_Size:uint    = 45;

		public function CustomSimpleButton(X_Point:uint, Y_Point:uint) {
			this.x = X_Point;
			this.y = Y_Point;
			downState      = new ButtonDisplayState(downColor, X_Size, Y_Size);
			overState      = new ButtonDisplayState(overColor, X_Size, Y_Size);
			upState        = new ButtonDisplayState(upColor, X_Size, Y_Size);
			hitTestState   = new ButtonDisplayState(upColor, X_Size, Y_Size);
			//hitTestState.x = -(size / 4);
			//hitTestState.y = hitTestState.x;
			useHandCursor  = true;
		}
	}

}

import flash.display.Shape;
class ButtonDisplayState extends Shape {
    private var bgColor:uint;
    private var X_Size:uint;
	private var Y_Size:uint;

    public function ButtonDisplayState(bgColor:uint, X_Size:uint, Y_Size:uint) {
        this.bgColor = bgColor;
        this.X_Size  = X_Size;
		this.Y_Size  = Y_Size;
        draw();
    }

    private function draw():void {
        graphics.beginFill(bgColor);
        graphics.drawRect(0, 0, X_Size, Y_Size);
        graphics.endFill();
    }
}