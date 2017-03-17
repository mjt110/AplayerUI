package com.thunder.ctrls{
    import flash.display.Sprite;
    import flash.text.TextField;
	import flash.events.MouseEvent;
	
    public class MessageBox extends Sprite {
		//var textfield:TextField;
		//var msgbox:Sprite;
        function MessageBox(str:String):void {
		trace("MessageBox")
         var msgbox:Sprite = new Sprite();
		 msgbox.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDown);
          // drawing a white rectangle
          msgbox.graphics.beginFill(0xFFFFFF); // white
          msgbox.graphics.drawRect(0,0,300,20); // x, y, width, height
          msgbox.graphics.endFill();
 
          // drawing a black border
          msgbox.graphics.lineStyle(2, 0x000000, 100);  // line thickness, line color (black), line alpha or opacity
          msgbox.graphics.drawRect(0,0,300,20); // x, y, width, height
        
          var textfield:TextField = new TextField();
          textfield.text = str;

          addChild(msgbox);
          addChild(textfield);
		  // this.visible = false;
        }
		
		private function OnMouseDown(evt:MouseEvent){
			trace("MessageBox OnMouseUp")
			this.visible = false;
		}
		
		public function Show(str:String){
			//textfield.text = str;
			this.visible = true;
		}
     }
  }