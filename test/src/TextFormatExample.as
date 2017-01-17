 package { 
    import flash.display.Sprite; 
    import flash.text.TextField; 
    import flash.text.TextFieldAutoSize; 
    import flash.text.TextFormat; 
    public class TextFormatExample extends Sprite { 
        private var label:TextField; 
        public function TextFormatExample() { 
            configureLabel(); 
            setLabel("Hello World and welcome to the show"); 
        } 
        public function setLabel(str:String):void { 
            label.text = str; 
        } 
//下面开始设定TextField 
        private function configureLabel():void { 
//下面的还是在TextField层面设定，这些对TextField都是全局有效的 
            label = new TextField(); 
            label.autoSize = TextFieldAutoSize.LEFT; 
            label.background = true; 
            label.border = true; 
//开始设定TextFormat啦，就是文字格式 
            var format:TextFormat = new TextFormat(); 
            format.font = "Verdana"; 
            format.color = 0xFF0000; 
            format.size = 30; 
            format.underline = true; 
/* 
绑定TextField的默认样式为刚才的TextFormat的，当然你可以使用setTextFormat(format:TextFormat, beginIndex:int = -1, endIndex:int = -1)，用这个你可以更方便控制样式的范围 
*/ 
            label.defaultTextFormat = format; 
            addChild(label); 
        } 
    } 
} 