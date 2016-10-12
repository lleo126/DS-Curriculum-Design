package models
{
	import units.Hero;
	import units.StatusType;
	import views.View;
	
	/**
	 * 玩家信息
	 * @author 彩月葵☆彡
	 */
	public class Player
	{
		public function Player()
		{
			
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
		
		private var _hero:Hero;
		public function get hero():Hero 
		{
			return _hero;
		}
		public function set hero(value:Hero):void 
		{
			_hero = value;
			_hero.owner = this;
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
		
		/**
		 * 在世界暂停时会调用这个方法，停止所有按键并静止住人物
		 */
		public function releaseAll():void 
		{
			upHeld = leftHeld = downHeld = rightHeld = false;
			hero.unitTransform.speed = 0.0;
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
			if (!down || hero.lifted) return;
			
			hero.lift();
		}
		
		public function onThrow(keyCode:int, down:Boolean):void
		{
			if (down) // 蓄力
			{
				hero.ap += View.PLAY_VIEW.world.deltaTime;
			}
			else // 投掷
			{
				hero.throw2();
			}
		}
		
		public function onSwitchSmall(keyCode:int, down:Boolean):void
		{
			if (!down) return;
			
			hero.snowball = Hero.SNOWBALLS[0];
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
		
		private function update():void
		{
			hero.unitTransform.speed = hero.maxSpeed * int(!(upHeld == downHeld && leftHeld == rightHeld));
			if (_hero.unitTransform.speed == 0.0) 
			{
				_hero.status = StatusType.STANDING;
			}
			else
			{
				_hero.status = StatusType.MOVING;
			}
			if (0.0 < hero.unitTransform.speed)
			{
				hero.unitTransform.orientation = Math.atan2(int(downHeld) - int(upHeld), int(rightHeld) - int(leftHeld)) / Math.PI * 180.0;
			}
		}
	}
}