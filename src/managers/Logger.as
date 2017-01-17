package managers 
{
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class Logger 
	{
		public function Logger(manager:LoggerManager, id:Number = -1) 
		{
			this.manager = manager;
			this.id = id;
		}
		
		private var id:Number;
		private var manager:LoggerManager;
		
		private function get prefix():String { return id == -1 ? '' : '#' + id.toString(); }
		
		public function input(...data):void 
		{
			manager.input.apply(this, [prefix].concat(data));
		}
		
		public function output(...data):void 
		{
			manager.output.apply(this, [prefix].concat(data));
		}
	}
}