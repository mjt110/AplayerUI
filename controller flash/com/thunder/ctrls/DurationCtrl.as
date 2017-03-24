package com.thunder.ctrls {
	
	import flash.display.MovieClip;
	import flash.text.*;
	
	
	public class DurationCtrl extends MovieClip {
		private var textObj:TextField;
		
		public function DurationCtrl() {
			// constructor code
			textObj = new TextField();
			
			addChild(textObj);
		}
		
		public function set text(str:String){
			textObj.text = str;
		}
		
		private function MillisecondToText(ms:int) {
				var s = ms / 1000;
				ms = ms % 1000;
				var h = s / 3600;
				s = s % 3600;
				var m = s / 60;
				s = s % 60;

				h = Math.floor(h);
				m = Math.floor(m);
				s = Math.floor(s);

				var text = "";
				if (h > 0 && h < 10)
					text = "0" + h + ":";

				if (m >= 0 && m < 10)
					text = text + "0" + m + ":";
				else
					text = text + m + ":";

				if (s >= 0 && s < 10)
					text = text + "0" + s;
				else
					text = text + s;
				return text;
			}	
		
		public function SetDurationInfo(curSecond:String, duration:String){
			var iCurSec = new int(curSecond);
			var iDur	= new int(duration);
			var str = MillisecondToText(iCurSec) + "/" + MillisecondToText(iDur);
			
			this.text = str;
			
			return str;
		}
	}
	
}
