package models 
{
	/**
	 * 用来保存单位生成的信息数据
	 * @author 彩月葵☆彡
	 */
	public class GenerationOption 
	{
		public function GenerationOption(xml:XML = null, maxUnit:int = 0, delay:Number = NaN) 
		{
			this.xml = xml;
			this.maxUnit = maxUnit;
			this.delay = delay;
		}

		/**
		 * 保存该类型的描述数据
		 */
		public var xml:XML;
		
		/**
		 * 生成单位的时间间隔
		 */
		public var delay:Number;
		
		/**
		 * 最多生成多少个单位
		 */
		public var maxUnit:int;
	}
}