package  {
	import flash.display.MovieClip;
	import com.thunder.ctrls.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.StageQuality;
	import com.thunder.events.ButtonEvent;
	import flash.external.ExternalInterface;
	
	public class Ctrl extends MovieClip {
		private var bkg:BkgImage;
		private var playBtn:PlayButton;
		private var pauseBtn:PauseButton;
		private var playBtnVisible:Boolean = true;
		private var muteBtnVisible:Boolean = false;
		private var msgBox:MessageBox;
		public function Ctrl() {
			// bkg = new BkgImage();
			// bkg.x = 100;
			// bkg.y = 100;
			// addChild(bkg);
			// this.x = 0;
			// this.y = 0;
			// this.width = stage.stageWidth;
			// this.height= stage.stageHeight;
			
			
			
			
			InitStyle();
			InitListener();
		}
		
		public function nextBtnVisible(str:String){
			MsgBox("hahhahahhahah")
			if (str == "false"){
				MsgBox("hahhahahhahah")
			}
		}
		private function MsgBox(str:String){
			var msgBox = new MessageBox(str);
			stage.addChild(msgBox);
		}
		private function InitStyle(){
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.quality = StageQuality.BEST;
			stage.doubleClickEnabled = true;
			stage.showDefaultContextMenu = false;
			
			playBtn = new PlayButton();
			playBtn.x = 27;
			playBtn.y = stage.stageHeight - 54;
			
			trace("stage.stageWidth: " + stage.stageWidth + " stage.stageHeight: " + stage.stageHeight);
			addChild(playBtn);
			
			pauseBtn = new PauseButton();
			pauseBtn.x = 27;
			pauseBtn.y = stage.stageHeight - 54;
			pauseBtn.visible = false;
			addChild(pauseBtn);
			
			nextBtn = new NextButton();
			nextBtn.x = 81;
			nextBtn.y = stage.stageHeight - 54;
			addChild(nextBtn);
			
			volumeHighBtn = new VolumeHigh();
			volumeHighBtn.x = stage.stageWidth - 196;
			volumeHighBtn.y = stage.stageHeight - 48;
			//volumeHighBtn.enabled = false;
			addChild(volumeHighBtn);
			
			volumeMuteBtn = new VolumeMute();
			volumeMuteBtn.x = stage.stageWidth - 196;
			volumeMuteBtn.y = stage.stageHeight - 48;
			volumeMuteBtn.visible = false;
			addChild(volumeMuteBtn);
			
			// stage.BkgBtn.x = 100;
			// stage.BkgBtn.y = 100;
			
			progress = new Progress();
			progress.x = 0;
			progress.y = this.stage.stageHeight - 83;
			progress.width = 10;
			this.stage.addChild(progress);
			
			progressBtn = new ProgressButton();
			progressBtn.x = 10;
			progressBtn.y = this.stage.stageHeight - 80;
			this.stage.addChild(progressBtn);
			
			volume = new Progress();
			volume.x = stage.stageWidth - 135;
			volume.y = this.stage.stageHeight - 49;
			volume.width = 1;
			this.stage.addChild(volume);
			
			volumeBtn = new  VolumeBtn();
			volumeBtn.x = stage.stageWidth - 130;
			volumeBtn.y = stage.stageHeight - 48;
			this.stage.addChild(volumeBtn);		
		}
		
		private function InitListener(){
			this.stage.addEventListener(Event.RESIZE, OnResize);
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
			playBtn.addEventListener(ButtonEvent.BTN_RELEASE, OnPlayBtnPress);
			pauseBtn.addEventListener(ButtonEvent.BTN_RELEASE, OnPlayBtnPress);
			volumeHighBtn.addEventListener(ButtonEvent.BTN_RELEASE, OnVolumeBtnPress);
			volumeMuteBtn.addEventListener(ButtonEvent.BTN_RELEASE, OnVolumeBtnPress);
		}
		
		private function OnMouseUp(evt:MouseEvent){
			// MsgBox("Init")
			
			progressBtn.pressed = false;
		}
		
		private function OnMouseMove(evt:MouseEvent){
			if (evt.buttonDown && progressBtn.pressed && evt.stageX < stage.stageWidth - 10){
				progress.width = evt.stageX;
				progressBtn.x = evt.stageX;
			}else if (evt.buttonDown && 
					  volumeBtn.pressed && 
					  evt.stageX < stage.stageWidth - 82 &&
					  evt.stageX > stage.stageWidth - 130){
				
				volume.width = evt.stageX - volume.x ;
				volumeBtn.x = evt.stageX;
			}
		}
		
		private function OnVolumeBtnPress(evt:ButtonEvent){
			trace("OnPlayBtnPress")
			muteBtnVisible = !muteBtnVisible;
			volumeMuteBtn.visible = muteBtnVisible;
			volumeHighBtn.visible = !muteBtnVisible;
		}
		
		private function OnPlayBtnPress(evt:ButtonEvent){
			trace("OnPlayBtnPress")
			playBtnVisible = !playBtnVisible;
			playBtn.visible = playBtnVisible;
			pauseBtn.visible = !playBtnVisible;
			
			if (!playBtnVisible){
				trace("OnFlashPlay")
				// ExternalInterface.call("function() {Aplayer.Open('http://192.168.24.195/124.mp4')}");
				ExternalInterface.call("OnFlashCall", "Play");
			}else{
				trace("OnFlashPause")
				ExternalInterface.call("OnFlashCall", "Pause");
			}
		}
		
		public function get playBtnState(){
			return playBtnVisible;
		}
		
		private function OnResize(evt:Event){
			playBtn.x = 27;
			playBtn.y = stage.stageHeight - 54;
			pauseBtn.x = 27;
			pauseBtn.y = stage.stageHeight - 54;
			nextBtn.x = 81;
			nextBtn.y = stage.stageHeight - 54;
			
			volumeHighBtn.x = stage.stageWidth - 196;
			volumeHighBtn.y = stage.stageHeight - 48;
			volumeMuteBtn.x = stage.stageWidth - 196;
			volumeMuteBtn.y = stage.stageHeight - 48;
			progress.x = 0;
			progress.y = this.stage.stageHeight - 83;
			progressBtn.y = this.stage.stageHeight - 80;
			volume.x = 630;
			volume.y = this.stage.stageHeight - 51;
			volumeBtn.y = stage.stageHeight - 48;
		}
	}
	
}
