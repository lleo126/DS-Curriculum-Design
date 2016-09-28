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
		public function DropShadow(unit:Unit) 
		{
			super(new AssetManager.DROP_SHADOW_IMG());
			
			this.unit = unit;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// 根据
			unit.width // /height
			// 设置
			displayObject.width = 200.0;
			displayObject.height = 150.0;
			addChild(displayObject);
			center();
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
		
		public function update():void 
		{
			displayObject.width = unit.unitTransform.z;
			center();
			alpha
		}
	}
}