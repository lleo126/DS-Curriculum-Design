package units 
{
	import assets.AssetManager;
	import events.UnitEvent;
	import flash.display.Bitmap;
	import models.Collision;
	
	[event(UnitEvent.COLLIDED)]
	
	/**
	 * 玩家投掷的雪球
	 * @author 彩月葵☆彡
	 */
	public class Snowball extends Unit 
	{
		/** 质量，与蓄力后雪球的投掷距离成反比 */
		public static const MASS:Number = 28.0;
		private static const MAX_SPEED:Number = 1.0;
		public static const ATTACK_RANGE_RATIO:Number = 5.0;
		private static const DAMAGE_SNOW_RATIO:Number = 0.2;
		private static const STRAIGHT_ATTACK_BONUS:Number = 1.2;
		
		/**
		 * 
		 * @param	radius		大小，正比影响爆炸范围
		 * @param	bonus		消耗的雪量
		 */
		public function Snowball(radius:Number, bonus:int) 
		{
			_body = new SpriteEx(new AssetManager.SNOWBALL_IMG());
			
			_damage = _unitTransform.radius = radius;
			_unitTransform.altitude = _body.width = _body.height = 2.0 * radius;
			_attackRange = radius * ATTACK_RANGE_RATIO;
			_bonus = bonus;
			_maxSpeed = MAX_SPEED;
			
			_body.pivotX = radius;
			_body.pivotY = 2.0 * radius;
			
			addEventListener(UnitEvent.COLLIDED, onCollided);
		}
		
		//==========
		// 方法
		//==========
		
		override public function removeFromWorld():void 
		{
			/** 根据圆锥体积公式 V = s * h / 3   ->   h = 1.5 * V / (PI * r) */
			var deltaSnow:Number = 1.5 * bonus / (Math.PI * attackRange) / World.ALPHA_SNOW_RATIO * DAMAGE_SNOW_RATIO;
			world.addSnow(deltaSnow, unitTransform, attackRange);
			trace( "deltaSnow : " + deltaSnow );
			super.removeFromWorld();
		}
		
		override internal function addToWorldUnits(world:World):void 
		{
			super.addToWorldUnits(world);
			world.snowballs.push(this);
		}
		
		override internal function removeFromWorldUnits():void 
		{
			if (!world) return;
			
			world.snowballs.splice(world.snowballs.indexOf(this), 1);
			super.removeFromWorldUnits();
		}
		
		override public function update(deltaTime:int):void 
		{
			super.update(deltaTime);
			unitTransform.vz -= World.GRAVITY;
		}
		
		public function clone():Snowball
		{
			return new Snowball(_unitTransform.radius, bonus);
		}
		
		private function onCollided(e:UnitEvent):void 
		{
			var unit:Unit = (e.data as Collision).target as Unit;
			if (unit is Hero || unit is Obstacle)
			{
				unit.attacked(this, _damage * STRAIGHT_ATTACK_BONUS, true);
			}
		}
	}
}