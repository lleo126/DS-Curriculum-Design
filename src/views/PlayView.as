package views 
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import models.Player;
	import models.Setting;
	import units.World;
	/**
	 * 游戏界面
	 * @author 彩月葵☆彡
	 */
	public class PlayView extends View 
	{
		public static const CHALLENGE:String	= 'challenge';
		public static const BATTLE:String		= 'battle';
		
		public function PlayView() 
		{
			_world = new World();
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * 玩家，根据长度可以判断是单人还是双人
		 */
		public var players:Vector.<Player>;
		
		/**
		 * 游戏模式，可以是 CHALLENGE 或 BATTLE
		 */
		public var type:String;
		
		//==========
		// 属性
		//==========
		
		private var _world:World;
		public function get world():World 
		{
			return _world;
		}
		
		//==========
		// 方法
		//==========
		
		override protected function placeElements():void 
		{
			addChild(_world);
		}
		
		override protected function inactivate(ev:Event):void 
		{
			super.inactivate(ev);
			world.dispose();
		}
		
		override protected function init(ev:Event = null):void 
		{
			trace( "PlayView.init > ev : " + ev );
			super.init();
			
		}
	}
}