package units 
{
	import avmplus.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	/**
	 * 工厂类
	 * @author 彩月葵☆彡
	 */
	public class Factory 
	{
		public function Factory(instance:*) 
		{
			klass = getDefinitionByName(getQualifiedClassName(instance)) as Class;
			returnInstance(instance);
		}
		
		/**
		 * 该工厂生成的实例的类型
		 */
		private var klass:Class;
		
		/**
		 * 实例池
		 */
		private var pool:Vector.<*> = new <*>[];
		
		/**
		 * 获取一个新的单位
		 * @return
		 */
		public function getInstance():*
		{
			return pool.length ? pool.pop() : new klass();
		}
		
		public function returnInstance(instance:*):void 
		{
			//trace( "Factory.returnInstance > instance : " + instance );
			pool.push(instance);
		}
	}
}