package units 
{
	import assets.AssetManager;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	/**
	 * 单位的阴影，X 型椭圆。单位的碰撞体积越大，阴影越大；高度越大，阴影越浅。
	 * @author 彩月葵☆彡
	 */
	public class DropShadow extends Bitmap 
	{
		public function DropShadow(unit:Unit) 
		{
			super(new AssetManager.DROP_SHADOW_IMG());
			this.unit = unit;
		}
		
		//==========
		// 变量
		//==========
		
		private var unit:Unit;
		
		//==========
		// 方法
		//==========
		
		public function update():void 
		{
			
		}
	}
}