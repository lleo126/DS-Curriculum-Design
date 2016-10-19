package managers 
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
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
		
		public function LoggerManager(filePath:String) 
		{
			this.filePath = filePath;
			
			inputStream = new FileStream();
			inputStream.open(new File(File.applicationDirectory.resolvePath(inputFilePath).nativePath), FileMode.WRITE);
			outputStream = new FileStream();
			outputStream.open(new File(File.applicationDirectory.resolvePath(outputFilePath).nativePath), FileMode.WRITE);
			
			NativeApplication.nativeApplication.addEventListener(Event.EXITING, onApplicationExit);
		}
		
		private var filePath:String;
		private var loggers:Vector.<Logger> = new <Logger>[];
		private var inputStream:FileStream;
		private var outputStream:FileStream;
		
		public function get inputFilePath():String { return filePath + '.in'; }
		public function get outputFilePath():String { return filePath + '.out'; }
		
		public function newLogger():Logger 
		{
			var logger:Logger = new Logger(this, loggers.length);
			loggers.push(logger);
			return logger;
		}
		
		public function input(...data):void 
		{
			for (var i:int = 0; i < data.length; i++) 
			{
				var line:String = data[i] == null ? 'null' : data[i].toString();
				inputStream.writeUTFBytes(line + '\n');
			}
		}
		
		public function output(...data):void 
		{
			for (var i:int = 0; i < data.length; i++) 
			{
				var line:String = data[i] == null ? 'null' : data[i].toString();
				outputStream.writeUTFBytes(line + '\n');
			}
		}
		
		private function onApplicationExit(e:Event):void 
		{
			NativeApplication.nativeApplication.removeEventListener(Event.EXITING, onApplicationExit);
			
			inputStream.close();
			outputStream.close();
		}
	}
}