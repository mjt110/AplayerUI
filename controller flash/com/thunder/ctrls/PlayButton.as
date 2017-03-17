package com.thunder.ctrls
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import flash.display.SimpleButton
    import com.thunder.events.ButtonEvent;
   
    public dynamic class PlayButton extends SimpleButton
    {	
		public function PlayButton(){
			super();
			trace("PlayButton init");
			this.addEventListener(MouseEvent.MOUSE_DOWN, OnPress);
			this.addEventListener(MouseEvent.MOUSE_UP, OnRelease);
		}
		
		public function OnPress(evt:MouseEvent){
			trace("PlayButton OnPress");
			dispatchEvent(new ButtonEvent(ButtonEvent.BTN_PRESS));
		}
		public function OnRelease(evt:MouseEvent){
			trace("PlayButton OnPress");
			dispatchEvent(new ButtonEvent(ButtonEvent.BTN_RELEASE));
		}
   }
}