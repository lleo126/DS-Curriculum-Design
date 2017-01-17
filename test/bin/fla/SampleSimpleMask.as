package
{
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.display.BitmapData;
	import flash.display.Bitmap;

	public class SampleSimpleMask extends Sprite
	{
		private var _bitmap:Bitmap;
		private var _circleMask:Sprite;
		public function SampleSimpleMask() {
			//initMask();
			startLoadImg();		
		}
		
		private function loaded(evt:Event):void {
			_bitmap = evt.target.content as Bitmap;
			addChild(_bitmap);
			//_bitmap.mask = _circleMask;
		}
		
		//private function initMask():void {
			//_circleMask = new Sprite();			
			//_circleMask.graphics.beginFill(0xff0000);
			//_circleMask.graphics.drawRoundRect(0,0,200,10, 10, 10);
			//_circleMask.graphics.endFill();
			//addChild(_circleMask);
			//_circleMask.startDrag(true);
		//}
		
		private function startLoadImg():void {
			var loader:Loader = new Loader();
			var request:URLRequest = new URLRequest("fla/desktop_madebykingda_1024.jpg");
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
			loader.load(request);	
		}
	}
}