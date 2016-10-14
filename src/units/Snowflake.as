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
		/**
		 * 风的速度，雪花会被风吹飞
		 */
		private static var SPEED:Number;
		private static var ORIENTATION:Number;
		private static var MAX_SPEED:Number = 0.1;
		private static var MASS:Number = 10.0;
		
		init();
		public static function init():void 
		{
			var timer:Timer = new Timer(0);
			timer.addEventListener(TimerEvent.TIMER, update);
			timer.start();
		}
		
		public static function update(e:TimerEvent = null):void 
		{
			SPEED = MAX_SPEED * Math.random();
			ORIENTATION = 360.0 * Math.random();
		}
		
		public function Snowflake() 
		{
			_body = new SpriteEx(new AssetManager.SNOWFLAKE1_IMG()); // TODO: 替换成雪花图片
			_mass = MASS;
		}
		
		override public function update(deltaTime:int):void 
		{
			super.update(deltaTime);
			
			_unitTransform.speed = SPEED;
			_unitTransform.orientation = ORIENTATION;
			_unitTransform.vz -= mass;
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
	}
}