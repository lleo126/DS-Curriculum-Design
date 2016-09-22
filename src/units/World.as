package units 
{
	import controllers.PlayerController;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import models.Player;
	import models.Setting;
	import views.View;
	
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class World extends Sprite 
	{
		public function World() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * 玩家，根据长度可以判断是单人还是双人
		 */
		private var players:Vector.<Player>;
		
		/**
		 * 游戏模式，可以是 CHALLENGE 或 BATTLE
		 */
		private var type:String;
		
		/**
		 * 玩家交互控制器
		 */
		private var playerController:PlayerController;
		
		/**
		 * 怪物
		 */
		private var monsters:Vector.<Monster>
		
		/**
		 * 障碍物
		 */
		private var obstacles:Vector.<Obstacle>;
		
		/**
		 * 道具
		 */
		private var items:Vector.<Item>;
		
		//==========
		// 属性
		//==========
		
		//==========
		// 方法
		//==========
		
		public function start(type:String, players:Vector.<Player>):void 
		{
			this.type = type;
			this.players = players;
			playerController = new PlayerController(players);
		}
		
		/**
		 * 继续或暂停游戏
		 * @param	b true 表示继续，false 表示暂停
		 */
		public function resume(b:Boolean):void 
		{
			
		}
		
		public function dispose():void 
		{
			
		}
		
		private function init(ev:Event):void 
		{
			// TODO
			View.PLAY_VIEW.addEventListener(KeyboardEvent.KEY_DOWN,	onKeyUpDown);
			View.PLAY_VIEW.addEventListener(KeyboardEvent.KEY_UP,	onKeyUpDown);
		}
		
		/**
		 * （每帧）更新所有单位
		 * @param	e
		 */
		private function update(e:Event = null):void 
		{
			
		}
		
		/**
		 * 按键按下时找 PlayerController 代理处理玩家操作
		 * @param	e
		 */
		private function onKeyUpDown(e:KeyboardEvent):void 
		{
			//if (!View.PLAY_VIEW.active) return;
			
			for (var i:int = 0; i < 2; ++i)
			{
				if (!(e.keyCode in Setting.current.hotkeys[i])) continue;
				
				playerController['on' + Setting.current.hotkeys[i]](i, e.keyCode, e.type == KeyboardEvent.KEY_DOWN);
			}
		}
	}
}