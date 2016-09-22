package controls 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.media.Video;
	import views.View;
	import views.ViewStack;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class ConceptFrame extends ViewStack 
	{
		public function ConceptFrame(defaultView:DisplayObject) 
		{
			super(conceptImage);
		}
		
		/**
		 * 概念图片，默认显示它
		 */
		public var conceptImage:Bitmap;
		
		/**
		 * 播放的视频，两种过场动画用同一个实例应该可以吧，不可以的话自己改下
		 */
		public var video:Video;
		
		/**
		 * 开发人员的图片，默认的文字有点难看
		 */
		public var aboutImage:Bitmap;
	}
}