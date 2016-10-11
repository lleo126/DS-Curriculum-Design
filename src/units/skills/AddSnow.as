package units.skills 
{
	import assets.AssetManager;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import units.Hero;
	import units.Unit;
	/**
	 * ...
	 * @author leo126
	 */
	public class AddSnow extends Skill 
	{
		
		public function AddSnow() 
		{
			//super();
			//
		}
		public var addSnow:Number;
		
		override public function apply(unit:Unit):void 
		{
			(unit as Hero).sp += addSnow;
			AssetManager.soundEffect = new Sound();
			if (addSnow > 0)
			{
				AssetManager.soundEffect.load(new URLRequest("music/HP_SP_Up.mp3"));
			}
			else
			{
				AssetManager.soundEffect.load(new URLRequest("music/HP_SP_Down.mp3"));
			}
			AssetManager.songEffect = AssetManager.soundEffect.play();
			AssetManager.songEffect.soundTransform = AssetManager.transEffect;
		}
	}
}