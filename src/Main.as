package
{
	import assets.AssetManager;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.net.URLRequest;
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
		public static const DEBUG:Boolean = true;
		static public var current:Main;
		
		public function Main() 
		{
			View.initClass();
			super(View.MAIN_VIEW);
			
			current = this;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//==========
		// 属性
		//==========
		
		override public function set view(value:DisplayObject):void 
		{

			
			if (value as View == View.PLAY_VIEW)
			{
				AssetManager.songMusic.stop();
				AssetManager.soundFactory = new Sound();
				AssetManager.soundFactory.load(new URLRequest("music/MySound2.mp3"));
				AssetManager.songMusic = AssetManager.soundFactory.play(0,int.MAX_VALUE);
				AssetManager.songMusic.soundTransform = AssetManager.transMusic;
			}
			else if (this.view == View.PLAY_VIEW)
			{
				AssetManager.songMusic.stop();
				AssetManager.soundFactory = new Sound();
				AssetManager.soundFactory.load(new URLRequest("music/MySound.mp3"));
				AssetManager.songMusic = AssetManager.soundFactory.play(0,int.MAX_VALUE);
				AssetManager.songMusic.soundTransform = AssetManager.transMusic;
			}
			
			
			super.view = value;
			stage.focus = null;
			
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
		}
	}
}