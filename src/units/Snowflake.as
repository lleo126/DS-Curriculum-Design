package units 
{
	import assets.AssetManager;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * 雪花，落下来增加雪量
	 * @author 彩月葵☆彡
	 */
	public class Snowflake extends Unit 
	{
		private static const MAX_SPEED:Number = 0.3;
		private static const MASS:Number = 1.0;
		/**
		 * 雪花落下来的高度
		 */
		private static const Z:Number = 600.0;
		private static const DELTA_SNOW:Number = 100.0;
		private static const MELT_RANGE_RATIO:Number = 4.0;
		private static const DELAY:Number = 0.0;
		/**
		 * 风的速度，雪花会被风吹飞
		 */
		private static var SPEED:Number = 0;
		//private static var ORIENTATION:Number = 360.0 * Math.random();
		private static var ORIENTATION:Number = 0;
		
		
		init();
		public static function init():void 
		{
			var timer:Timer = new Timer(DELAY);
			timer.addEventListener(TimerEvent.TIMER, update);
			timer.start();
		}
		
		public static function update(e:TimerEvent = null):void 
		{
			SPEED += (Math.random() < 0.5 ? 1.0 : -1.0) * MAX_SPEED * 0.05 * Math.random();
			//ORIENTATION += (Math.random() < 0.5 ? 1.0 : -1.0) * 10.0 * Math.random();
		}
		
		public function Snowflake() 
		{
			_mass = MASS;
			_maxSpeed = MAX_SPEED;
			_unitTransform.vz = -mass * World.GRAVITY;
			_unitTransform.radius = 30.0;
		}
		
		override protected function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_unitTransform.z = Z;
			addChild(_body);
			_body.center();
			update(0);
		}
		
		override public function update(deltaTime:int):void 
		{
			super.update(deltaTime);
			
			_unitTransform.speed = SPEED;
			_unitTransform.orientation = ORIENTATION;
		}
		
		override public function setByXML(xml:XML):void 
		{
			name = xml.name.text().toString();
			
			var ImageClass:Class = AssetManager[xml.img[0].text().toString()];
			_body = new SpriteEx(new ImageClass());
			_body.pivotX = parseFloat(xml.pivotX.text().toString());
			_body.pivotY = parseFloat(xml.pivotY.text().toString());
			
			var scale:Number = parseFloat(xml.width.text().toString()) / _body.width;
			_unitTransform.radius = parseFloat(xml.radius.text().toString()) * scale;
			_unitTransform.altitude = parseFloat(xml.unitTransform.altitude.text().toString()) * scale;
			
			addEventListener(Event.ADDED_TO_STAGE, function ():void 
			{
				removeEventListener(Event.ADDED_TO_STAGE, arguments.callee);
				
				scaleX = scaleY = scale;
			});
		}
		
		override public function dispose():void 
		{
			//trace( "Snowflake.dispose" );
			super.dispose();
			(UnitGenerator.UNIT_FACTORIES['units.Snowflake'] as Pool).returnInstance(this);
		}
		
		override internal function addToWorldUnits(world:World):void 
		{
			super.addToWorldUnits(world);
			world.snowflakes.push(this);
		}
		
		override internal function removeFromWorldUnits():void 
		{
			if (!world) return;
			
			world.snowflakes.splice(world.snowflakes.indexOf(this), 1);
			super.removeFromWorldUnits();
		}
		
		public function melt():void 
		{
			world.addSnow(DELTA_SNOW, _unitTransform, _unitTransform.radius * MELT_RANGE_RATIO);
			dispose();
		}
	}
}