package models 
{
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	/**
	 * 设置，单例
	 * @author 彩月葵☆彡
	 */
	public class Setting 
	{
		public static const current:Setting = new Setting();
		
		public function Setting() 
		{
			hotkeys[0][Keyboard.W]			= 'MoveUp';
			hotkeys[0][Keyboard.A]			= 'MoveLeft';
			hotkeys[0][Keyboard.S]			= 'MoveDown';
			hotkeys[0][Keyboard.D]			= 'MoveRight';
			hotkeys[0][Keyboard.J]			= 'Lift';
			hotkeys[0][Keyboard.K]			= 'Throw';
			hotkeys[0][Keyboard.U]			= 'SwitchSmall';
			hotkeys[0][Keyboard.I]			= 'SwitchMedium';
			hotkeys[0][Keyboard.O]			= 'SwitchLarge';
			
			hotkeys[1][Keyboard.UP]			= 'MoveUp';
			hotkeys[1][Keyboard.LEFT]		= 'MoveLeft';
			hotkeys[1][Keyboard.DOWN]		= 'MoveDown';
			hotkeys[1][Keyboard.RIGHT]		= 'MoveRight';
			hotkeys[1][Keyboard.NUMPAD_1]	= 'Lift';
			hotkeys[1][Keyboard.NUMPAD_2]	= 'Throw';
			hotkeys[1][Keyboard.NUMPAD_4]	= 'SwitchSmall';
			hotkeys[1][Keyboard.NUMPAD_5]	= 'SwitchMedium';
			hotkeys[1][Keyboard.NUMPAD_6]	= 'SwitchLarge';
		}
		
		public var soundValue:Number = 100.0;
		public var soundEffectValue:Number = 80.0;
		/**
		 * 按键映射表，[0] 表示玩家 1，[1] 表示玩家 2
		 */
		public var hotkeys:Vector.<Object> = new <Object>[ { }, { } ];
	}
}