package com.thunder.ctrls {
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
    import flash.display.SimpleButton
    import com.thunder.events.ButtonEvent;
	
	public class ProgressButton extends SimpleButton {
		private var progress:Progress;
		private var bPressed:Boolean = false;
		
		public function ProgressButton(){
			super();
			trace("ProgressButton init");
			this.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, OnMouseDown);
		}
		
		private function OnMouseDown(evt:MouseEvent){
			bPressed = true;
		}
		
		private function OnMouseUp(evt:MouseEvent){
			bPressed = false;
		}
		
		public function get pressed(){
			return bPressed;
		}
		public function set pressed(val:Boolean){
			bPressed = val;
		}
	}
	
}
