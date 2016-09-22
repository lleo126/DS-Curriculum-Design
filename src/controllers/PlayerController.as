package controllers 
{
	import models.Player;
	/**
	 * 玩家的控制器，专门处理事件交互
	 * @author 彩月葵☆彡
	 */
	public class PlayerController 
	{
		public function PlayerController(players:Vector.<Player>) 
		{
			this.players = players;
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * 玩家，从 PlayView 中获取来的
		 */
		public var players:Vector.<Player>;

		//==========
		// 方法
		//==========
		
		public function onMoveUp():void 
		{
			
		}
		
		public function onMoveLeft():void 
		{
			
		}
		
		public function onMoveDown():void 
		{
			
		}
		
		public function onMoveRight():void 
		{
			
		}
		
		public function onLift():void 
		{
			
		}
		
		public function onThrow():void 
		{
			
		}
		
		public function onSwitchSmall():void 
		{
			
		}
		
		public function onSwitchMedium():void 
		{
			
		}
		
		public function onSwitchLarge():void 
		{
			
		}
	}

}