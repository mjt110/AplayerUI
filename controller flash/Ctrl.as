﻿package  {
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
		private var bkg:BkgFakeBtn;
		private var playBtn:PlayButton;
		private var pauseBtn:PauseButton;
		private var volumeHighBtn:VolumeHigh;
		private var volumeMuteBtn:VolumeMute;
		private var progress:Progress;
		private var volume:Progress;
		private var durationCtrl:DurationCtrl;
		private var volumeBkg:VolumeProgress;
		private var progressBtn:ProgressButton;
		private var progressBkgBtn:ProgressBkgBtn;
		private var volumeBtn:VolumeBtn;
		
		private var nextBtn:NextButton;
		private var playBtnVisible:Boolean = true;
		private var muteBtnVisible:Boolean = false;
		private var duration:int = 0;
		private var msgBox:MessageBox;
		public function Ctrl() {
			
			// this.x = 0;
			// this.y = 0;
			// this.width = stage.stageWidth;
			// this.height= stage.stageHeight;
			
			
			InitExternalCall();
			InitStyle();
			InitListener();
		}
		
		private function InitExternalCall(){
			
			ExternalInterface.addCallback("SetProgressPos", this.SetProgressPos);
			ExternalInterface.addCallback("nextBtnVisible", this.nextBtnVisible);
			ExternalInterface.addCallback("playBtnVisible", this.playBtnVisibleFun);
			ExternalInterface.addCallback("pauseBtnVisible", this.pauseBtnVisible);
			ExternalInterface.addCallback("processVisible", this.processVisible);
			ExternalInterface.addCallback("OnStateChanged", this.OnStateChanged);
			ExternalInterface.addCallback("OnSeekCompleted", this.OnSeekCompleted);
			ExternalInterface.addCallback("UpdatePosition", this.UpdatePosition);
			ExternalInterface.addCallback("UpdateVolumePos", this.UpdateVolumePos);
		}
		
		public function nextBtnVisible(str:String){
			if (str == "false"){
				nextBtn.visible = false;
			}else if(str == "true"){
				nextBtn.visible = true;
			}
		}
		
		public function playBtnVisibleFun(str:String){
			if (str == "false"){
				// MsgBox("Set playBtn false");
				playBtn.visible = false;
			}else if(str == "true"){
				// MsgBox("Set playBtn true");
				playBtn.visible = true;
			}
		}
		
		public function pauseBtnVisible(str:String){
			if (str == "false"){
				pauseBtn.visible = false;
				// MsgBox("Set pauseBtn false");
			}else if(str == "true"){
				pauseBtn.visible = true;
				// MsgBox("Set pauseBtn true");
			}
		}
		
		public function processVisible(str:String){
			if (str == "false"){
				progress.visible = false;
				progressBtn.visible = false;
			}
		}
		
		public function OnStateChanged(oldState:String, newState:String){
			if (newState == "3"){// PS_PAUSED
				playBtn.visible = true;
				pauseBtn.visible = false;
				pauseBtn.enabled = false;
			}else if(newState == "5" || newState == "4"){// PS_PLAY
				playBtn.visible = false;
				playBtn.enabled = false;
				pauseBtn.visible = true;
			}else if(newState == "0"){// PS_READY
				// MsgBox("PS_READY");
			}
		}
		
		public function SetProgressPos(sPos:String){
			// MsgBox("SetPro: "+sPos)
			var iPos = new int(sPos);
			if(iPos != null && iPos > 0){
				var newPos = Math.floor((iPos/this.duration) * stage.stageWidth);
				progress.width = newPos;
				progressBtn.x = newPos;
			}
		}
		// private function 
		public function OnSeekCompleted(position:String){
			
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
			
			bkg = new BkgFakeBtn();
			bkg.x = 0;
			bkg.y = stage.stageHeight - 54;
			bkg.width = stage.stageWidth;
			bkg.enabled = false;
			this.stage.addChild(bkg);
			
			progressBkgBtn = new ProgressBkgBtn();
			progressBkgBtn.x = 0;
			progressBkgBtn.y = stage.stageHeight - 60;
			progressBkgBtn.width = stage.stageWidth;
			progressBkgBtn.enabled = false;
			this.stage.addChild(progressBkgBtn);
			
			
			playBtn = new PlayButton();
			playBtn.x = 0;
			playBtn.y = stage.stageHeight - 54;
			this.stage.addChild(playBtn);
			//trace("stage.stageWidth: " + stage.stageWidth + " stage.stageHeight: " + stage.stageHeight);
			
			pauseBtn = new PauseButton();
			pauseBtn.x = 0;
			pauseBtn.y = stage.stageHeight - 54;
			pauseBtn.visible = false;
			this.stage.addChild(pauseBtn);
			
			nextBtn = new NextButton();
			nextBtn.x = 55;
			nextBtn.y = stage.stageHeight - 54;
			this.stage.addChild(nextBtn);
			
			volumeHighBtn = new VolumeHigh();
			volumeHighBtn.x = stage.stageWidth - 170;
			volumeHighBtn.y = stage.stageHeight - 42;
			//volumeHighBtn.enabled = false;
			this.stage.addChild(volumeHighBtn);
			
			volumeMuteBtn = new VolumeMute();
			volumeMuteBtn.x = stage.stageWidth - 170;
			volumeMuteBtn.y = stage.stageHeight - 42;
			volumeMuteBtn.visible = false;
			this.stage.addChild(volumeMuteBtn);
			
			
			progress = new Progress();
			progress.x = 0;
			progress.y = this.stage.stageHeight - 60;
			progress.width = 10;
			progress.enabled = false;
			this.stage.addChild(progress);
			
			progressBtn = new ProgressButton();
			progressBtn.x = 10;
			progressBtn.y = this.stage.stageHeight - 64;
			this.stage.addChild(progressBtn);
			
			volumeBkg = new VolumeProgress();
			volumeBkg.x = stage.stageWidth - 135;
			volumeBkg.y = this.stage.stageHeight - 35;
			volumeBkg.enabled = false;
			this.stage.addChild(volumeBkg);
			
			volume = new Progress();
			volume.x = stage.stageWidth - 138;
			volume.y = this.stage.stageHeight - 35;
			volume.width = 1;
			this.stage.addChild(volume);
			
			volumeBtn = new  VolumeBtn();
			volumeBtn.x = stage.stageWidth - 138;
			volumeBtn.y = stage.stageHeight - 42;
			this.stage.addChild(volumeBtn);	

			durationCtrl = new DurationCtrl();
			durationCtrl.x = 130;
			durationCtrl.y = stage.stageHeight - 45;
			this.stage.addChild(durationCtrl);
			durationCtrl.text = "00:00/88:56";			
		}
		
		public function UpdatePosition(cur:String, dur:String){
			// MsgBox("UpdatePosition")
			this.duration = new int(dur);
			durationCtrl.SetDurationInfo(cur, dur);
		}
		
		public function UpdateVolumePos(sVolume:String){
			var iVolume = new int(sVolume);
			if(iVolume != null && iVolume > 0){
				var newPos = Math.floor((iVolume/100) * 56);
				volume.width = newPos;
				volumeBtn.x = newPos + volume.x;
			}
		}
		private function InitListener(){
			this.stage.addEventListener(Event.RESIZE, OnResize);
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
			playBtn.addEventListener(ButtonEvent.BTN_RELEASE, OnPlayBtnPress);
			pauseBtn.addEventListener(ButtonEvent.BTN_RELEASE, OnPauseBtnPress);
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
				
				var newPos = Math.floor((evt.stageX/stage.stageWidth) * this.duration);
				ExternalInterface.call("OnFlashCall", "SetPosition", newPos.toString());
			}else if (evt.buttonDown && 
					  volumeBtn.pressed && 
					  evt.stageX < stage.stageWidth - 82 &&
					  evt.stageX > stage.stageWidth - 138){
				
				volume.width = evt.stageX - volume.x ;
				volumeBtn.x = evt.stageX;
				
				var newVolume = Math.floor((volume.width/56) * 100);
				
				ExternalInterface.call("OnFlashCall", "SetVolume", newVolume.toString());
			}
		}
		
		private function OnVolumeBtnPress(evt:ButtonEvent){
			trace("OnPlayBtnPress")
			muteBtnVisible = !muteBtnVisible;
			volumeMuteBtn.visible = muteBtnVisible;
			volumeHighBtn.visible = !muteBtnVisible;
			
			if (muteBtnVisible){
				ExternalInterface.call("OnFlashCall", "SetVolume", "0");
			}else{
				ExternalInterface.call("OnFlashCall", "SetVolume", "50");
			}
		}
		
		private function OnPlayBtnPress(evt:ButtonEvent){
			//trace("OnPlayBtnPress")
			// playBtnVisible = !playBtnVisible;
			// playBtn.visible = playBtnVisible;
			// pauseBtn.visible = !playBtnVisible;
			
			// if (!playBtnVisible){
				// trace("OnFlashPlay")
				// ExternalInterface.call("function() {Aplayer.Open('http://192.168.24.195/124.mp4')}");
				// MsgBox("Playing")
				ExternalInterface.call("OnFlashCall", "Play");
			// }else{
				// trace("OnFlashPause")
				// ExternalInterface.call("OnFlashCall", "Pause");
			// }
		}
		
		private function OnPauseBtnPress(evt:Event){
			// MsgBox("Pause")
			ExternalInterface.call("OnFlashCall", "Pause");
		}
		
		public function get playBtnState(){
			return playBtnVisible;
		}
		
		private function OnResize(evt:Event){
			bkg.y = stage.stageHeight - 54;
			bkg.width = stage.stageWidth;
			
			progressBkgBtn.y = stage.stageHeight - 60;
			progressBkgBtn.width = stage.stageWidth;
			
			durationCtrl.x = 130;
			durationCtrl.y = stage.stageHeight - 45;
			
			playBtn.x = 0;
			playBtn.y = stage.stageHeight - 54;
			pauseBtn.x = 0;
			pauseBtn.y = stage.stageHeight - 54;
			nextBtn.x = 55;
			nextBtn.y = stage.stageHeight - 54;
			
			volumeBkg.x = stage.stageWidth - 135;
			volumeBkg.y = this.stage.stageHeight - 35;
			
			volumeHighBtn.x = stage.stageWidth - 170;
			volumeHighBtn.y = stage.stageHeight - 42;
			volumeMuteBtn.x = stage.stageWidth - 170;
			volumeMuteBtn.y = stage.stageHeight - 42;
			progress.x = 0;
			progress.y = this.stage.stageHeight - 60;
			progressBtn.y = this.stage.stageHeight - 64;
			
			volume.x = stage.stageWidth - 138;
			volume.y = this.stage.stageHeight - 35;
			volumeBtn.x = stage.stageWidth - 138;
			volumeBtn.y = stage.stageHeight - 42;
		}
	}
	
}
