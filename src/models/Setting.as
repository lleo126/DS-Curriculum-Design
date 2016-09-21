package models 
{
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class Setting 
	{
		public static var current:Setting = new Setting();
		
		public function Setting() 
		{
			hotkeys[0][Keyboard.W]			= 'MoveUp';
			hotkeys[0][Keyboard.A]			= 'MoveLeft';
			hotkeys[0][Keyboard.S]			= 'Movedown';
			hotkeys[0][Keyboard.D]			= 'Moveright';
			hotkeys[0][Keyboard.J]			= 'Lift';
			hotkeys[0][Keyboard.K]			= 'Throw';
			hotkeys[0][Keyboard.U]			= 'SwitchSnowballSmall';
			hotkeys[0][Keyboard.I]			= 'SwitchSnowballMedium';
			hotkeys[0][Keyboard.O]			= 'SwitchSnowballLarge';
			
			hotkeys[1][Keyboard.UP]			= 'MoveUp';
			hotkeys[1][Keyboard.LEFT]		= 'MoveLeft';
			hotkeys[1][Keyboard.DOWN]		= 'Movedown';
			hotkeys[1][Keyboard.RIGHT]		= 'Moveright';
			hotkeys[1][Keyboard.NUMPAD_1]	= 'Lift';
			hotkeys[1][Keyboard.NUMPAD_2]	= 'Throw';
			hotkeys[1][Keyboard.NUMPAD_4]	= 'SwitchSnowballSmall';
			hotkeys[1][Keyboard.NUMPAD_5]	= 'SwitchSnowballMedium';
			hotkeys[1][Keyboard.NUMPAD_6]	= 'SwitchSnowballLarge';
		}
		
		public var soundValue:Number = 100.0;
		public var soundEffectValue:Number = 80.0;
		// TODO: 按键映射表
		public var hotkeys:Vector.<Object> = new <Object>[ { }, { } ];
	}
}