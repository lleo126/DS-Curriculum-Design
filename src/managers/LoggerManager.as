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
		private static const ENABLED:Boolean = true;
		public static const INSERTION_SORT:LoggerManager = new LoggerManager('insertion-sort');
		public static const BINARY_SEARCH:LoggerManager = new LoggerManager('binary-search');
		public static const CIRCULAR_QUEUE:LoggerManager = new LoggerManager('circular-queue');
		public static const MATRIX:LoggerManager = new LoggerManager('matrix');
		public static const DEPTH_FIRST_SEARCH:LoggerManager = new LoggerManager('depth-first-search');
		
		public function LoggerManager(filePath:String) 
		{
			this.filePath = filePath;
			
			if (!ENABLED) return;
			
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
			write.apply(this, [inputStream].concat(data));
		}
		
		public function output(...data):void 
		{
			write.apply(this, [outputStream].concat(data));
		}
		
		private function write(stream:FileStream, ...data):void 
		{
			if (!ENABLED) return;
			
			for (var i:int = 0; i < data.length; i++) 
			{
				if (i) stream.writeUTFBytes(' ')
				
				var text:String = data[i] == null ? 'null' : data[i].toString();
				stream.writeUTFBytes(text);
			}
			stream.writeUTFBytes('\n');
		}
		
		private function onApplicationExit(e:Event):void 
		{
			NativeApplication.nativeApplication.removeEventListener(Event.EXITING, onApplicationExit);
			
			inputStream.close();
			outputStream.close();
		}
	}
}