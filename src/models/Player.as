package models
{
	import controls.APBar;
	import controls.HPBar;
	import controls.SPBar;
	import flash.text.TextField;
	import flash.utils.setTimeout;
	import units.Hero;
	import units.UnitStatus;
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
		 * 玩家的结束时间，若胜利则是游戏结束时间，若中途死亡则是死亡时间
		 */
		public var endTime:Date;
		
		/**
		 * 表示玩家通过情况或胜负
		 */
		public var status:String;
		
		/**
		 * 该玩家的血条
		 */
		public var hpBar:HPBar;
		
		/**
		 * 该玩家的雪条
		 */
		public var spBar:SPBar;
		
		/**
		 * 该玩家的蓄力条
		 */
		public var apBar:APBar;
		
		/**
		 * 该玩家的分数板
		 */
		// TODO(翔宇): 封装
		public var scoreBoard:TextField;
		
		/** 方向上键按下为 true */
		private var upHeld:Boolean = false;
		/** 方向左键按下为 true */
		private var leftHeld:Boolean = false;
		/** 方向下键按下为 true */
		private var downHeld:Boolean = false;
		/** 方向右键按下为 true */
		private var rightHeld:Boolean = false;
		
		
		private var _hero:Hero;
		private var _score:int = 0;
		
		//==========
		// 属性
		//==========
		
		public function get hero():Hero { return _hero; }
		public function set hero(value:Hero):void 
		{
			_hero = value;
			_hero.owner = this;
		}
		
		/**
		 * 玩家的分数
		 */
		public function get score():int { return _score; }
		public function set score(value:int):void 
		{
			_score = value;
			scoreBoard.text = int(_score).toString();
		}
		
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
		
		public function onThrow(keyCode:int, down:Boolean):void
		{
			if (down) // 蓄力
			{
				if (_hero.status != UnitStatus.LIFTING) _hero.lift();
			}
			else // 投掷
			{
				_hero.throw2();
			}
		}
		
		public function onAccelerate(keyCode:int, down:Boolean):void 
		{
			if (_hero.status != UnitStatus.MOVING) return;
			if (!down || _hero.accerelating) return;
			
			//trace( "down : " + down );
			_hero.accerelating = true;
			setTimeout(function ():void 
			{
				_hero.accerelating = false;
			}, 1000.0);
		}
		
		public function onSwitchSmall(keyCode:int, down:Boolean):void
		{
			if (!down) return;
			
			_hero.snowball = Hero.SNOWBALLS[0];
		}
		
		public function onSwitchMedium(keyCode:int, down:Boolean):void
		{
			if (!down) return;
			
			_hero.snowball = Hero.SNOWBALLS[1];
		}
		
		public function onSwitchLarge(keyCode:int, down:Boolean):void
		{
			if (!down) return;
			
			_hero.snowball = Hero.SNOWBALLS[2];
		}
		
		private function update():void
		{
			hero.unitTransform.speed = hero.maxSpeed * int(!(upHeld == downHeld && leftHeld == rightHeld));
			if (_hero.unitTransform.speed == 0.0) 
			{
				_hero.status = UnitStatus.STANDING;
			}
			else
			{
				_hero.status = UnitStatus.MOVING;
			}
			if (0.0 < hero.unitTransform.speed)
			{
				_hero.unitTransform.orientation = Math.atan2(int(downHeld) - int(upHeld), int(rightHeld) - int(leftHeld)) / Math.PI * 180.0;
			}
		}
	}
}