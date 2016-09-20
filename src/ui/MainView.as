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
		[Embed(source="../../assets/55181724_p0.jpg")]
		public const CHALLENGE_IMG:Class;
		
		public function MainView() 
		{
			super(ViewType.MAIN_VIEW);
		}
		
		override public function placeElements():void 
		{
            var button:CustomSimpleButton = new CustomSimpleButton();
			button.downState = new CHALLENGE_IMG();
            addChild(button);
			//var shape:Shape = new Shape();
			//shape.graphics.beginFill(0xF28405);
			//shape.graphics.drawCircle(20, 20, 30);
			//shape.graphics.endFill();
			//addChild(shape);
		}
	}
}

import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.SimpleButton;

class CustomSimpleButton extends SimpleButton {
    private var upColor:uint   = 0xFFCC00;
    private var overColor:uint = 0xCCFF00;
    private var downColor:uint = 0x00CCFF;
    private var size:uint      = 80;

    public function CustomSimpleButton() {
        downState      = new ButtonDisplayState(downColor, size);
        overState      = new ButtonDisplayState(overColor, size);
        upState        = new ButtonDisplayState(upColor, size);
        hitTestState   = new ButtonDisplayState(upColor, size);
        //hitTestState.x = -(size / 4);
        //hitTestState.y = hitTestState.x;
        useHandCursor  = true;
    }
}

class ButtonDisplayState extends Shape {
    private var bgColor:uint;
    private var size:uint;

    public function ButtonDisplayState(bgColor:uint, size:uint) {
        this.bgColor = bgColor;
        this.size    = size;
        draw();
    }

    private function draw():void {
        graphics.beginFill(bgColor);
        graphics.drawRect(0, 0, size, size);
        graphics.endFill();
    }
}