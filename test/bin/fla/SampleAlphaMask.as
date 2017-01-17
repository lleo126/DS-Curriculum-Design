package 
{
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.filters.BlurFilter;
	import flash.filters.BitmapFilterQuality;

	public class SampleAlphaMask extends Sprite
	{
		private var _bitmap:Bitmap;
		private var _circleMask:Sprite;
		public function SampleAlphaMask() {
			initMask();
			startLoadImg();		
		}
		
		private function loaded(evt:Event):void {
			_bitmap = evt.target.content as Bitmap;
			addChild(_bitmap);
			_bitmap.cacheAsBitmap = true;
			_bitmap.mask = _circleMask;
		}
		
		private function initMask():void {
			_circleMask = new Sprite();			
			_circleMask.graphics.beginFill(0xff0000);
			_circleMask.graphics.drawCircle(60,60,60);
			_circleMask.graphics.endFill();
			
			_circleMask.filters = [new BlurFilter(20,20, BitmapFilterQuality.HIGH)];
			_circleMask.cacheAsBitmap = true;
			addChild(_circleMask);
			_circleMask.startDrag(true);
		}
		
		private function startLoadImg():void {
			var loader:Loader = new Loader();
			var request:URLRequest = new URLRequest("fla/desktop_madebykingda_1024.jpg");
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
			loader.load(request);	
		}
	}
}