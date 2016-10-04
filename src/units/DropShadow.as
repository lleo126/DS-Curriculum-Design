package units 
{
	import assets.AssetManager;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	
	/**
	 * 单位的阴影，X 型椭圆。单位的碰撞体积越大，阴影越大；高度越大，阴影越浅。
	 * @author 彩月葵☆彡
	 */
	public class DropShadow extends SpriteEx
	{
		static public const MAX_TOP:Number = 200;
		static public const ALPHA:Number = 1.2;
		static public const OFFSET:Number = 30;
		
		public function DropShadow(unit:Unit) 
		{
			super(new AssetManager.DROP_SHADOW_IMG());
			
			this.unit = unit;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			displayObject.width = unit.unitTransform.radius * 2;
			displayObject.height = displayObject.width * 0.6;
			center();
			
			//addChild(displayObject);
			//阴影中心点要往下移一点
			//displayObject.y += OFFSET;
		}
		
		//==========
		// 变量
		//==========
		
		/**
		 * 所属的单位
		 */
		private var unit:Unit;
		
		//==========
		// 方法
		//==========
		
		override public function update(deltaTime:int):void 
		{
			displayObject.alpha = ALPHA - unit.unitTransform.z / MAX_TOP ;
		}
	}
}