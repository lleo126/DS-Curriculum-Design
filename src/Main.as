package
{
	import assets.AssetManager;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	import views.View;
	import views.ViewStack;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class Main extends ViewStack
	{
		public static const DEBUG:Boolean = false;
		public static var current:Main;
		
		public function Main() 
		{
			View.initClass();
			super(View.MAIN_VIEW);
			
			current = this;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private var black:Shape = new Shape();
		private var fadeSpeed:Number = 0.1;
		
		//==========
		// 属性
		//==========
		
		override public function set view(value:DisplayObject):void 
		{
			mouseChildren = false;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			function onEnterFrame(e:Event):void 
			{
				black.alpha += fadeSpeed;
				if (1.0 <= black.alpha)
				{
					black.alpha = 1.0;
					fadeSpeed = -fadeSpeed;
					
					if (value as View == View.PLAY_VIEW)
					{
						AssetManager.songMusic.stop();
						AssetManager.soundMusic = new Sound();
						AssetManager.soundMusic.load(new URLRequest("music/MySound2.mp3"));
						AssetManager.songMusic = AssetManager.soundMusic.play(0,int.MAX_VALUE);
						AssetManager.songMusic.soundTransform = AssetManager.transMusic;
					}
					else if (this.view == View.PLAY_VIEW)
					{
						AssetManager.songMusic.stop();
						AssetManager.soundMusic = new Sound();
						AssetManager.soundMusic.load(new URLRequest("music/MySound.mp3"));
						AssetManager.songMusic = AssetManager.soundMusic.play(0,int.MAX_VALUE);
						AssetManager.songMusic.soundTransform = AssetManager.transMusic;
					}
					
					removeChild(_view);
					_view = value;
					addChild(_view);
					//_super.view = value;
					swapChildren(black, _view);
					stage.focus = null;
				}
				else if (black.alpha <= 0.0) 
				{
					removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					
					mouseChildren = true;
					black.alpha = 0.0;
					fadeSpeed = -fadeSpeed;
				}
			}
		}
		
		//==========
		// 方法
		//==========
		
		/**
		 * 初始化
		 * @param	e
		 */
		override protected function init(e:Event = null):void 
		{
			super.init();
			
			black.graphics.beginFill(0x000000);
			black.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			black.graphics.endFill();
			black.alpha = 0.0;
			addChild(black);
		}
	}
}