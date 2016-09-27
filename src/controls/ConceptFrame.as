package controls 
{
	import assets.AssetManager;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import views.View;
	import views.ViewStack;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class ConceptFrame extends ViewStack 
	{
		public function ConceptFrame() 
		{
			conceptImage = new AssetManager.Concept_Frame_IMG();
			
			nc = new NetConnection();
			nc.connect(null);
			
			ns = new NetStream(nc);
			
			video = new Video();
			video.attachNetStream(ns);
			
			var client:Object=new Object();
			client.onMetaData = onMetaData;
			ns.client = client; 
			
			videoWrapper = new Sprite();
			videoWrapper.addChild(video);
			video.x = VIDEO_X; video.y = VIDEO_Y;
			video.width = VIDEO_W; video.height = VIDEO_H;
			videoWrapper.graphics.beginFill(0x9E3A42);
			videoWrapper.graphics.drawRect( MARGIN_X, MARGIN_Y, video.width + PADDING, video.height + PADDING);
			videoWrapper.graphics.endFill();
			

			aboutImage = new AssetManager.Concept_Frame_About_IMG();
			
			super(conceptImage);
		}
		
		/**
		 * 概念图片，默认显示它
		 */
		public var conceptImage:Bitmap;
		
		/**
		 * 播放的视频,一个实例两用
		 */
		public var video:Video;
		public var videoWrapper:Sprite;
		
		public var nc:NetConnection;
		public var ns:NetStream;
		
		/**
		 * 开发人员的图片，默认的文字有点难看
		 */
		public var aboutImage:Bitmap;
		static private const VIDEO_X:Number = 85;
		static private const VIDEO_Y:Number = 70;
		static private const VIDEO_W:Number = 525;
		static private const VIDEO_H:Number = 575;
		static private const MARGIN_X:Number = 72;
		static private const MARGIN_Y:Number = 56;
		static private const PADDING:Number = 25;
		
		override protected function init(ev:Event = null):void
		{
			super.init();
		}
		
		public function displayAbout(ev:MouseEvent):void 
		{
			view = aboutImage;
		}
		
		
		public function displayBattle(ev:MouseEvent):void 
		{
			ns.play('videos/Test_Battle.flv');
			view = videoWrapper;
		}
		public function displayChallenge(ev:MouseEvent):void 
		{
			ns.play('videos/Test_Challenge.flv');
			view = videoWrapper;
		}	
		public function outButton(ev:MouseEvent):void 
		{
			view = conceptImage;
		}
		public function outVideo(ev:MouseEvent):void 
		{
			view = conceptImage;
			ns.seek(0);
		}
		private function onMetaData(data:Object):void
		{
		}
	}
}