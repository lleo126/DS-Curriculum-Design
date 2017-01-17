package 
{
	/**
	 * ...
	 * @author leo126
	 */
    import flash.display.Sprite;
	import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	
    public class SimpleButtonExample extends Sprite {
        public function SimpleButtonExample() {
            var button:CustomSimpleButton = new CustomSimpleButton();
            addChild(button);
			
			const IMAGE_URL:String = "";
 
			var ldr:Loader = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, ldr_complete);
			ldr.load(new URLRequest(IMAGE_URL));
			var bitmap1:Bitmap;
			var bitmap2:Bitmap;
			var bitmap3:Bitmap;
			var bitmap4:Bitmap;
			 
			function ldr_complete(evt:Event):void {
				var bmp:Bitmap = ldr.content as Bitmap;
			 
				bitmap1 = new Bitmap(bmp.bitmapData);
				bitmap1.x = 100;
				bitmap1.y = 100;
				bitmap1.rotation = 0;
				addChild(bitmap1);
			 
				bitmap2 = new Bitmap(bmp.bitmapData);
				bitmap2.x = 200;
				bitmap2.y = 100;
				bitmap2.rotation = 90;
				addChild(bitmap2);
			 
				bitmap3 = new Bitmap(bmp.bitmapData);
				bitmap3.x = 300;
				bitmap3.y = 100;
				bitmap3.rotation = 180;
				addChild(bitmap3);
			 
				bitmap4 = new Bitmap(bmp.bitmapData);
				bitmap4.x = 400;
				bitmap4.y = 100;
				bitmap4.rotation = 270;
				addChild(bitmap4);
			}
			public function Main() {
				trace(new _xml())
				
				var format:TextFormat = new TextFormat();
				format.size = 14;
				format.font = "myfont";
				
				var txt:TextField = new TextField();
				txt.text = "方正粗活意简体";
				txt.embedFonts = true;
				txt.setTextFormat(format);
				this.addChild(txt);
			}
		}
		}

    }

		 
		
}

import flash.automation.KeyboardAutomationAction;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.SimpleButton;

class CustomSimpleButton extends SimpleButton {
    private var upColor:uint   = 0xFFCC00;
    private var overColor:uint = 0xCCFF00;
    private var downColor:uint = 0x00CCFF;
    private var wigthsize:uint = 150;
	private var heightsize:uint = 36;
	
    public function CustomSimpleButton() {
        downState      = new ButtonDisplayState(downColor, wigthsize, heightsize);
        overState      = new ButtonDisplayState(overColor, wigthsize, heightsize);
        upState        = new ButtonDisplayState(upColor, wigthsize, heightsize);
        hitTestState   = new ButtonDisplayState(upColor, wigthsize * 1.20, heightsize * 1.20);
        hitTestState.x = -(wigthsize / 4, heightsize / 4);
        hitTestState.y = hitTestState.x;
        useHandCursor  = true;
    }
}

class ButtonDisplayState extends Shape {
    private var bgColor:uint;
    private var wigthsize:uint;
	private var heightsize:uint;
	
    public function ButtonDisplayState(bgColor:uint, wigthsize:uint, heightsize:uint) {
        this.bgColor = bgColor;
        this.wigthsize = wigthsize;
		this.heightsize = heightsize;
        draw();
    }

    private function draw():void {
        graphics.beginFill(bgColor);
        graphics.drawRect(0, 0, wigthsize, heightsize);
        graphics.endFill();
    }
}