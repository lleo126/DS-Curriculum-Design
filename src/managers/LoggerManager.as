package managers 
{
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	/**
	 * ...
	 * @author 彩月葵☆彡
	 */
	public class LoggerManager 
	{
		public static const BINARY_SEARCH:LoggerManager = new LoggerManager('binary-search');
		public static const CIRCULAR_QUEUE:LoggerManager = new LoggerManager('circular-queue');
		
		public function LoggerManager(filePath:String, traceId:Boolean = false) 
		{
			this.filePath = filePath;
			this.traceId = traceId;
			
			//outputFile = File.applicationDirectory.resolvePath(outputFilePath);
			//inputStream = new FileStream();
			//inputStream.addEventListener();
			//inputStream.open(File.applicationDirectory.resolvePath(inputFilePath), FileMode.WRITE);
		}
		
		private var filePath:String;
		private var inputFile:File;
		private var outputFile:File;
		private var traceId:Boolean;
		private var loggers:Vector.<Logger> = new <Logger>[];
		private var inputStream:FileStream;
		
		public function get inputFilePath():String { return filePath + '.in'; }
		public function get outputFilePath():String { return filePath + '.out'; }
		
		public function newLogger():Logger 
		{
			var logger:Logger = new Logger(this, traceId ? loggers.length : -1);
			loggers.push(logger);
			return logger;
		}
		
		public function input(...data):void 
		{
			//for (var i:int = 0; i < data.length; i++) 
			//{
				//inputStream.writeUTFBytes(data[i].toString() + '\n');
			//}
		}
		
		public function output(...data):void 
		{
			
		}
	}
}