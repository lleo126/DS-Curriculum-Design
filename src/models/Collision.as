package models 
{
	import units.Unit;
	import units.UnitTransform;
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class Collision 
	{
		public function Collision(source:Unit, target:Unit, next:UnitTransform) 
		{
			this.source = source;
			this.target = target;
			this.next = next;
			_nextDistance = UnitTransform.getDistance(source.unitTransform, next);
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * 碰撞的单位
		 */
		public var source:Unit;
		
		/**
		 * 被碰撞的单位
		 */
		public var target:Unit;
		
		/**
		 * 碰撞单位的候选移动位置
		 */
		public var next:UnitTransform;
		
		
		private var _nextDistance:Number;
		
		//==========
		// 属性
		//==========
		
		/**
		 * 碰撞源与碰撞候选移动位置的距离
		 */
		public function get nextDistance():Number { return _nextDistance; }
	}
}