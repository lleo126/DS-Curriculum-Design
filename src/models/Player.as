package models
{
	import units.Hero;
	import views.View;
	
	/**
	 * 玩家信息
	 * @author 彩月葵☆彡
	 */
	public class Player
	{
		public function Player()
		{
			_hero.owner = this;
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * 玩家的分数
		 */
		public var score:int = 0;
		
		/**
		 * 玩家的结束时间，若胜利则是游戏结束时间，若中途死亡则是死亡时间
		 */
		public var endTime:int;
		
		//==========
		// 属性
		//==========
		
		/**
		 * 该玩家控制的人物
		 */
		private var _hero:Hero = new Hero();
		
		public function get hero():Hero
		{
			return _hero;
		}
		
		/** 方向上键按下为 true */
		private var upHeld:Boolean = false;
		/** 方向左键按下为 true */
		private var leftHeld:Boolean = false;
		/** 方向下键按下为 true */
		private var downHeld:Boolean = false;
		/** 方向右键按下为 true */
		private var rightHeld:Boolean = false;
		
		//==========
		// 方法
		//==========
		
		private function update():void
		{
			_hero.unitTransform.speed = _hero.maxSpeed * int(!(upHeld == downHeld && leftHeld == rightHeld));
			if (0.0 < _hero.unitTransform.speed)
			{
				_hero.unitTransform.orientation = Math.atan2(int(downHeld) - int(upHeld), int(rightHeld) - int(leftHeld)) / Math.PI * 180.0;
			}
		}
		
		public function onMoveUp(keyCode:int, down:Boolean):void
		{
			upHeld = down;
			update();
		}
		
		public function onMoveLeft(keyCode:int, down:Boolean):void
		{
			leftHeld = down;
			update();
		}
		
		public function onMoveDown(keyCode:int, down:Boolean):void
		{
			downHeld = down;
			update();
		}
		
		public function onMoveRight(keyCode:int, down:Boolean):void
		{
			rightHeld = down;
			update();
		}
		
		public function onLift(keyCode:int, down:Boolean):void
		{
			if (!down || _hero.lifted) return;
			
			_hero.lift();
		}
		
		public function onThrow(keyCode:int, down:Boolean):void
		{
			if (down) // 蓄力
			{
				_hero.accumulation += View.PLAY_VIEW.world.deltaTime;
			}
			else // 投掷
			{
				_hero.throw2();
			}
		}
		
		public function onSwitchSmall(keyCode:int, down:Boolean):void
		{
			if (!down) return;
			
			_hero.snowball = Hero.SNOWBALLS[0];
		}
		
		public function onSwitchMedium(keyCode:int, down:Boolean):void
		{
			if (!down) return;
			
			hero.snowball = Hero.SNOWBALLS[1];
		}
		
		public function onSwitchLarge(keyCode:int, down:Boolean):void
		{
			if (!down) return;
			
			hero.snowball = Hero.SNOWBALLS[2];
		}
	}
}