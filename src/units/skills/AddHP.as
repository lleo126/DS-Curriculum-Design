package units.skills 
{
	import assets.AssetManager;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import units.Unit;
	/**
	 * ...
	 * @author leo126
	 */
	public class AddHP extends Skill 
	{
		
		public function AddHP() 
		{
			//super();
			//
		}
		
		public var addHP:Number;
		
		override public function apply(unit:Unit):void 
		{
			unit.hp += addHP;
			AssetManager.soundEffect = new Sound();
			if (addHP > 0)
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