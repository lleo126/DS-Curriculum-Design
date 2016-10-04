package units 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	import interfaces.IUpdate;
	import models.Player;
	
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
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(dropShadow);
			//graphics.lineStyle(4, 0xACED24);
			//graphics.drawRect(0, 0, width, height);
			addChild(body);
			//graphics.lineStyle(4, 0x02EDFA);
			//graphics.drawRect(0, 0, width, height);
			update(0.0);
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * 所属者
		 */
		public var owner:Player;
		
		/**
		 * 伤害值
		 */
		protected var damage:Number;
		
		/**
		 * 攻击距离
		 */
		protected var attackRange:Number;
		
		/**
		 * 阴影
		 */
		protected var dropShadow:DropShadow;
		
		//==========
		// 属性
		//==========
		
		/**
		 * 本体
		 */
		protected var _body:SpriteEx;
		public function get body():SpriteEx 
		{
			return _body;
		}
		// for test
		public function set body(value:SpriteEx):void 
		{
			_body = value;
		}
		
		/**
		 * 包含单位的 z 坐标，速度，碰撞大小等信息，与单位绑定
		 */
		protected var _unitTransform:UnitTransform;
		public function get unitTransform():UnitTransform 
		{
			return _unitTransform;
		}
		public function set unitTransform(value:UnitTransform):void 
		{
			_unitTransform = value;
			_unitTransform.unit = this;
			_unitTransform.update();
		}
		
		/**
		 * 最大速度
		 */
		protected var _maxSpeed:Number = 0.0;
		public function get maxSpeed():Number 
		{
			return _maxSpeed;
		}
		
		/**
		 * 血量
		 */
		protected var _hp:Number;
		public function get hp():Number 
		{
			return _hp;
		}
		public function set hp(value:Number):void 
		{
			_hp = value;
		}
		
		/**
		 * 状态
		 */
		protected var _status:String;
		public function get status():String 
		{
			return _status;
		}
		public function set status(value:String):void 
		{
			_status = value;
		}
		
		/**
		 * 该单位的击杀奖励分数
		 */
		protected var _bonus:int;
		public function get bonus():int 
		{
			return _bonus;
		}
		
		//==========
		// 方法
		//==========
		
		public function update(deltaTime:int):void 
		{
			body.update(deltaTime);
			dropShadow.update(deltaTime);
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
			(parent as World).removeUnit(this);
		}
	}
}

