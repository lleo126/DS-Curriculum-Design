package units 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import interfaces.IUpdate;
	import models.Player;
	
	[event(Event.CHANGE)]
	
	/**
	 * 游戏世界中最基本的单位，抽象类
	 * @author 彩月葵☆彡
	 */
	public class Unit extends Sprite implements IUpdate
	{
		public function Unit() 
		{
			_unitTransform = new UnitTransform(this);
			dropShadow = new DropShadow(this);
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * 当它被第一次添加入舞台时调用
		 * @param	e
		 */
		protected function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(dropShadow);
			addChild(body);
			update(0);
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * 所属者
		 */
		public var owner:Player;
		
		/**
		 * 世界
		 */
		internal var world:World;
		
		/**
		 * 伤害值
		 */
		protected var damage:Number;
		
		/**
		 * 攻击距离
		 */
		protected var _attackRange:Number;
		
		/**
		 * 阴影
		 */
		protected var dropShadow:DropShadow;
		
		protected var _body:SpriteEx;
		protected var _unitTransform:UnitTransform;
		protected var _maxSpeed:Number = 0.0;
		protected var _hp:Number;
		protected var _maxHP:Number;
		protected var _status:String = StatusType.MOVING;
		protected var _bonus:int;
		
		//==========
		// 属性
		//==========
		
		/**
		 * 本体
		 */
		public function get body():SpriteEx { return _body; }
		// for test
		public function set body(value:SpriteEx):void 
		{
			_body = value;
		}
		
		/**
		 * 包含单位的 z 坐标，速度，碰撞大小等信息，与单位绑定
		 */
		public function get unitTransform():UnitTransform { return _unitTransform; }
		public function set unitTransform(value:UnitTransform):void 
		{
			_unitTransform = value;
			_unitTransform.unit = this;
			_unitTransform.update();
		}
		
		/**
		 * 最大速度
		 */
		public function get maxSpeed():Number { return _maxSpeed; }
		public function set maxSpeed(value:Number):void 
		{
			_maxSpeed = value;
		}
		/**
		 * 血量
		 */
		public function get hp():Number { return _hp; }
		public function set hp(value:Number):void 
		{
			_hp = Math.min(value, maxHP);
		}
		
		/**
		 * 最大血量
		 */
		public function get maxHP():Number { return _maxHP; }
		public function set maxHP(value:Number):void 
		{
			_maxHP = value;
		}
		
		/**
		 * 状态
		 */
		public function get status():String { return _status; }
		public function set status(value:String):void 
		{
			_status = value;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		/**
		 * 该单位的击杀奖励分数
		 */
		public function get bonus():int { return _bonus; }
		
		public function get attackRange():Number 
		{
			return _attackRange;
		}
		
		//==========
		// 方法
		//==========
		
		public function update(deltaTime:int):void 
		{
			if (Main.DEBUG)
			{
				graphics.clear();
				graphics.lineStyle(3, 0x4186F4);
				graphics.drawEllipse(-unitTransform.radius / scaleX, -unitTransform.top / scaleX, 2.0 * unitTransform.radius / scaleX, unitTransform.altitude / scaleX);
			}
			dropShadow.update(deltaTime);
			body.update(deltaTime);
		}
		
		public function dispose():void 
		{
			removeFromWorld();
		}
		
		/**
		 * 根据 XML 设置属性
		 */
		public function setByXML(xml:XML):void
		{
			
		}	
		
		public function removeFromWorld():void 
		{
			world.removeUnit(this);
		}
		
		internal function addToWorldUnits(world:World):void 
		{
			this.world = world;
		}
		
		internal function removeFromWorldUnits():void 
		{
			world = null;
		}
	}
}

