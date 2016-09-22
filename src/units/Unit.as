package units 
{
	import flash.display.Bitmap;
	import flash.events.Event;
	
	/**
	 * 游戏世界中最基本的单位，抽象类
	 * @author 彩月葵☆彡
	 */
	public class Unit extends SpriteEx 
	{
		public function Unit(img:Bitmap) 
		{
			super(_img = img);
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * 移动速度
		 */
		private var speed:Number;
		
		/**
		 * 攻击距离
		 */
		private var attackRange:Number;
		
		//==========
		// 属性
		//==========
		
		/**
		 * 血量
		 */
		private var _hp:Number;
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
		private var _status:String;
		public function get status():String 
		{
			return _status;
		}
		public function set status(value:String):void 
		{
			_status = value;
		}
		
		/**
		 * 底部坐标
		 */
		private var _bottom:Number;
		public function get bottom():Number 
		{
			return _bottom;
		}
		public function set bottom(value:Number):void 
		{
			_bottom = value;
		}
		
		/**
		 * z 轴高度，从 z 轴底部坐标（bottom）到 z 轴顶部坐标（top）的高度
		 */
		private var _altitude:Number;
		public function get altitude():Number 
		{
			return _altitude;
		}
		
		public function set altitude(value:Number):void 
		{
			_altitude = value;
		}
		
		/**
		 * z 轴顶部坐标
		 */
		public function get top():Number 
		{
			return bottom + altitude;
		}
		
		/**
		 * 该单位的击杀奖励分数
		 */
		protected var _bonus:int;
		public function get bonus():int 
		{
			return _bonus;
		}
		
		/**
		 * 碰撞半径
		 */
		protected var _radius:Number;
		public function get radius():Number 
		{
			return _radius;
		}
		
		/**
		 * 该单位的图片
		 */
		protected var _img:Bitmap;
		public function get img():Bitmap 
		{
			return _img;
		}
		
		/**
		 * 朝向，单位的图片根据朝向设定
		 */
		protected var _orientation:int;
		public function get orientation():int 
		{
			return _orientation;
		}
		public function set orientation(value:int):void 
		{
			_orientation = value;
		}
		
		//==========
		// 方法
		//==========
		
		/**
		 * 当它被添加入舞台时调用
		 * @param	e
		 */
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
		}
	}
}