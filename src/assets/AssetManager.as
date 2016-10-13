package assets 
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class AssetManager 
	{
		/********主界面图片********/
		[Embed(source="../../assets/main/Button_Challenge_Up.png")]
		public static const BUTTON_CHALLENGE_IMG:Class;
		
		[Embed(source="../../assets/main/Button_Battle_Up.png")]
		public static const BUTTON_BATTLE_IMG:Class;
		
		[Embed(source="../../assets/main/Button_Setting_Up.png")]
		public static const BUTTON_SETTING_IMG:Class;
		
		[Embed(source="../../assets/main/Button_Exit_Up.png")]
		public static const BUTTON_EXIT_IMG:Class;
		
		[Embed(source="../../assets/main/Button_About_Up.png")]
		public static const BUTTON_ABOUT_IMG:Class;
		
		[Embed(source = "../../assets/main/Concept_Frame.png")]
		public static const CONCEPT_FRAME_IMG:Class;
		
		[Embed(source = "../../assets/main/Concept_Frame_About.png")]
		public static const CONCEPT_FRAME_ABOUT_IMG:Class;
		
		[Embed(source="../../assets/Main/Background.png")]
		public static const MAIN_BACKGROUND_IMG:Class;
		
		[Embed(source = "../../assets/Main/Game_Name.png")]
		public static const MAIN_TITLE_IMG:Class;
		//==========================/
		
		/********设置界面图片*******/
		[Embed(source="../../assets/setting/Setting.png")]
		public static const SETTING_IMG:Class;
		
		[Embed(source="../../assets/setting/Slider_Bar.png")]
		public static const SLIDER_BAR_IMG:Class;
		
		[Embed(source="../../assets/setting/Slider_Tick.png")]
		public static const SLIDER_TICK_IMG:Class;
		
		[Embed(source="../../assets/setting/Music.png")]
		public static const MUISC_IMG:Class;
		
		[Embed(source="../../assets/setting/SoundEffect.png")]
		public static const SOUNDEFFECT_IMG:Class;

		[Embed(source="../../assets/setting/Role_One.png")]
		public static const ROLE_ONE_IMG:Class;
		
		[Embed(source="../../assets/setting/Role_Two.png")]
		public static const ROLE_TWO_IMG:Class;
		
		[Embed(source="../../assets/setting/Throw.png")]
		public static const RAISE_IMG:Class;
		
		[Embed(source="../../assets/setting/Dart.png")]
		public static const THROW_IMG:Class;
		
		[Embed(source="../../assets/setting/SmallBall.png")]
		public static const SMALLBALL_IMG:Class;
		
		[Embed(source="../../assets/setting/MiddleBall.png")]
		public static const MIDDLEBALL_IMG:Class;
		
		[Embed(source="../../assets/setting/BigBall.png")]
		public static const BIGBALL_IMG:Class;
		
		[Embed(source="../../assets/Button_Back.png")]
		public static const BUTTON_BACK_IMG:Class;
		
		[Embed(source="../../assets/setting/Key_Want.png")]
		public static const KEY_WANT_IMG:Class;
		
		[Embed(source = "../../assets/setting/Hot_Key_Panel.png")]
		public static const HOT_KEY_PANEL_IMG:Class;
		
		[Embed(source = "../../assets/setting/Sound_Panel.png")]
		public static const SOUND_PANEL_IMG:Class;
		
		[Embed(source = "../../assets/Setting/Background.jpg")]
		public static const SETTING_BACKGROUND:Class;
		//==========================/
		
		/********对战界面图片*******/
		[Embed(source = "../../assets/play/HP.png")]
		public static const HP_IMG:Class;
		
		[Embed(source="../../assets/play/SP.png")]
		public static const SP_IMG:Class;
		
		[Embed(source="../../assets/Play/AP.png")]
		public static const AP_IMG:Class;
		
		[Embed(source="../../assets/play/HP_GROOVE.png")]
		public static const HP_GROOVE_IMG:Class;
		
		[Embed(source="../../assets/play/SP_GROOVE.png")]
		public static const SP_GROOVE_IMG:Class;
		
		[Embed(source="../../assets/Play/AP_GROOVE.png")]
		public static const AP_GROOVE_IMG:Class;
		
		[Embed(source = "../../assets/play/WhiteBar.png")]
		public static const WHITEBAR_IMG:Class;
		
		[Embed(source="../../assets/play/Return_Game.png")]
		public static const RETURN_GAME_IMG:Class;
		
		[Embed(source = "../../assets/play/StopBackground.png")]
		public static const STOPBACKGROUND_IMG:Class;
		
		[Embed(source = "../../assets/play/Menu.png")]
		public static const MENU_IMG:Class;
		
		[Embed(source="../../assets/Play/Hero.png")]
		public static const HERO_IMG:Class;
		
		[Embed(source="../../assets/Play/Snowball.png")]
		public static const SNOWBALL_IMG:Class;
		
		[Embed(source="../../assets/Play/Drop_Shadow.png")]
		public static const DROP_SHADOW_IMG:Class;
		
		[Embed(source = "../../assets/Play/Baffle.png")]
		public static const BAFFLE:Class;

		//==========================/
		
		//===========成绩界面=======/
		
		[Embed(source = "../../assets/xml/Monster.xml", mimetype="application/octet-stream")]
		public static const MONSTER_XML:Class;
		
		[Embed(source = "../../assets/xml/Obstacle.xml", mimetype="application/octet-stream")]
		public static const OBSTACLE_XML:Class;
		
		[Embed(source = "../../assets/xml/Item.xml", mimetype="application/octet-stream")]
		public static const ITEM_XML:Class;
		
		[Embed(source = "../../assets/Score/Background2.png")]
		public static const BACKGROUND_SCORE:Class;
		
		[Embed(source = "../../assets/Score/Button_Back.png")]
		public static const BACK_BUTTON_SCORE:Class;
		
		[Embed(source = "../../assets/Score/Score.png")]
		public static const SCORE_TITLE:Class;

		//========游戏基本单位图片==/
		[Embed(source = "../../assets/photos/carambola.png")]
		public static const CARAMBOLA_IMG:Class;
		
		[Embed(source = "../../assets/photos/litchi.png")]
		public static const LITCHI_IMG:Class;
		
		[Embed(source = "../../assets/photos/mango.png")]
		public static const MANGO_IMG:Class;
		
		[Embed(source = "../../assets/photos/sourFruit.png")]
		public static const SOURFRUIT_IMG:Class;
		
		[Embed(source = "../../assets/photos/spicystrips.png")]
		public static const SPICYSTRIPS_IMG:Class;
		
		[Embed(source = "../../assets/photos/sour_spicystrips.png")]
		public static const SOUR_SPICYSTRIPS_IMG:Class;
		
		[Embed(source = "../../assets/photos/car2.png")]
		public static const CAR2_IMG:Class;
		
		[Embed(source = "../../assets/photos/car4.png")]
		public static const CAR4_IMG:Class;
		
		[Embed(source = "../../assets/photos/car6.png")]
		public static const CAR6_IMG:Class;
		
		[Embed(source = "../../assets/photos/car9.png")]
		public static const CAR9_IMG:Class;
		
		[Embed(source = "../../assets/photos/dog.png")]
		public static const DOG_IMG:Class;
		
		[Embed(source = "../../assets/photos/ice.png")]
		public static const ICE_IMG:Class;
		
		[Embed(source = "../../assets/photos/glue.png")]
		public static const GLUE_IMG:Class;
		
		[Embed(source = "../../assets/photos/poison.png")]
		public static const POISON_IMG:Class;
		
		[Embed(source = "../../assets/photos/salt.png")]
		public static const SALT_IMG:Class;
		
		[Embed(source = "../../assets/photos/tree2.png")]
		public static const TREE2_IMG:Class;
		
		[Embed(source = "../../assets/photos/tree3.png")]
		public static const TREE3_IMG:Class;
		
		[Embed(source = "../../assets/photos/tree4.png")]
		public static const TREE4_IMG:Class;

		[Embed(source = "../../assets/photos/tree6.png")]
		public static const TREE6_IMG:Class;
		
		[Embed(source = "../../assets/photos/tree7.png")]
		public static const TREE7_IMG:Class;
		
		[Embed(source = "../../assets/photos/tree8.png")]
		public static const TREE8_IMG:Class;
		
		[Embed(source = "../../assets/photos/tree9.png")]
		public static const TREE9_IMG:Class;
		
		[Embed(source = "../../assets/photos/Youling.png")]
		public static const YOULING_IMG:Class;
		
		[Embed(source = "../../assets/photos/ZhongZiShou.png")]
		public static const ZHONGZISHOU_IMG:Class;
		
		[Embed(source = "../../assets/photos/DaWangHua.png")]
		public static const DAWANGHUA_IMG:Class;
		
		[Embed(source = "../../assets/photos/Dustbin.png")]
		public static const DUSTBIN_IMG:Class;
		
		[Embed(source = "../../assets/photos/bicycle1.png")]
		public static const BICYCLE1_IMG:Class;
		
		[Embed(source = "../../assets/photos/bicycle2.png")]
		public static const BICYCLE2_IMG:Class;
		//==========================/
		
		//========动画图片==========/
		
		[Embed(source = "../../assets/Animation/VillagerRun1.png")]
		public static const HERO_MOVE:Class;
		
		[Embed(source = "../../assets/Animation/VillagerRun2.png")]
		public static const HERO_MOVE_TWO:Class;
		
		[Embed(source = "../../assets/Animation/ball.png")]
		public static const BALL_EXPLOSION:Class;
		
		[Embed(source = "../../assets/Animation/VillagerAttack1.png")]
		public static const HERO_ATTACK:Class;
		
		[Embed(source = "../../assets/Animation/VillagerAttack2.png")]
		public static const HERO_ATTACK_TWO:Class;
		//==========================/
		
		
		//========音效声明==========/
		public static var songMusic:SoundChannel;
		public static var songEffect:SoundChannel;
		public static var soundMusic:Sound;
		public static var soundEffect:Sound;
		public static var transMusic:SoundTransform = new SoundTransform();
		public static var transEffect:SoundTransform = new SoundTransform();
		//==========================/
		
	}
}