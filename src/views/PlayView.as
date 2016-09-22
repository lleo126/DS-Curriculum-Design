package views 
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import models.Player;
	/**
	 * 游戏界面
	 * @author 彩月葵☆彡
	 */
	public class PlayView extends View 
	{
		public function PlayView() 
		{
			
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * 玩家，根据长度可以判断是单人还是双人
		 */
		public var players:Vector.<Player>;
		
		//==========
		// 方法
		//==========
		
		override protected function placeElements():void 
		{
			//var shape:Shape = new Shape();
			//shape.graphics.beginFill(0xF28405);
			//shape.graphics.drawCircle(20, 20, 30);
			//shape.graphics.endFill();
			//addChild(shape);
		}
		
		override protected function inactivate(ev:Event):void 
		{
			
		}
		
		override protected function init(ev:Event = null):void 
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN,	onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,	onKeyUp);
			super.init();
		}
		
		private function onKeyUp(e:Event):void 
		{
			if (!active) return;
			
		}
		
		private function onKeyDown(e:Event):void 
		{
			if (!active) return;
			
		}
	}

}