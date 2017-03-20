
function APlayerUI() {
	
	
}

APlayerUI.UI=null;
APlayerUI.styleConfig=null;
APlayerUI.flashBarID=null;
APlayerUI.aplayer = null;
APlayerUI.updateDurationTimer = null;
APlayerUI.iPos = 0;
APlayerUI.iDuration = 0;
APlayerUI.flashUrl="http://169.254.15.254/ctrl.swf";
	
// styleConfigObj = {nextBtnVisible:false, processVisible:false}//只传需要隐藏的部分即可。
APlayerUI.InitUIStyle = function(uiElement, styleConfigObj){
	// alert("InitUIStyle")
	this.UI = uiElement;
	this.aplayer = uiElement.GetAPlayerObject();
	this.styleConfig = styleConfigObj;
	if (this.styleConfig == null){
		this.styleConfig = {};
	}
	
	this.flashBarID = this.UI.AddElement(3, this.flashUrl);
	this.UI.SetElementPosition(this.flashBarID, 7, 0, 80, 100, 20);
	this.UI.SetElementVisible(this.flashBarID, true);
	
	this.UI.ShowDefaultControlBar(false, 57);
	
	this.SetStyle(styleConfigObj);
}

APlayerUI.SetStyle = function(styleConfigObj){
	for (var funName in styleConfigObj){
		var tmpArr = new Array();
		tmpArr[0] = styleConfigObj[funName];
		this.CallAsFunc(funName, tmpArr);
	}
}

APlayerUI.CallAsFunc = function(sname, argArr){
	//paramArr内的所有实参统统当作string传递。AS所提供的供JS调用的方法
	//其形参都声明为string,此外，JS所传的参数个数应当符合AS那边的声明。
	var invokeStr = "<invoke name=\"";
	invokeStr = invokeStr + sname + "\" returntype=\"xml\"><arguments>";
	
	var tmpStr = ""
	for (var i = 0; i < argArr.length; i++) {
		if (argArr[i] && argArr[i].toString && argArr[i].toString()){
			tmpStr = tmpStr + "<string>";
			tmpStr = tmpStr + argArr[i].toString();
			tmpStr = tmpStr + "</string>"
		}
	}
	invokeStr = invokeStr + tmpStr;
	invokeStr = invokeStr + "</arguments></invoke>"

	// if (sname == "UpdateVolumePos")
		// alert(invokeStr);
	
	var ret = this.UI.CallFlashFunction(this.flashBarID, invokeStr);

	return ret;
}

APlayerUI.SetCtrlBarVisible = function(visible){
	if (this.flashBarID != null && this.UI != null){
		this.UI.SetElementVisible(this.flashBarID, visible);
	}
}

function UpdatePosition(){
	APlayerUI.iPos = APlayerUI.aplayer.GetPosition();
	
	var tmp = new Array()
	tmp[0] = APlayerUI.iPos;
	APlayerUI.CallAsFunc("SetProgressPos", tmp);
	
	tmp[0] = APlayerUI.aplayer.GetVolume();
	APlayerUI.CallAsFunc("UpdateVolumePos", tmp);
	
	APlayerUI.CallAsFunc("UpdatePosition", new Array(APlayerUI.iPos, APlayerUI.iDuration));
	
	
	// alert("SetProgressPos")
}

APlayerUI.OnStateChanged = function(oldState, newState){
	switch (newState){
		case 0:	// PS_READY
			APlayerUI.CallAsFunc("UpdatePosition", new Array(0, 0));
		case 3:	// PS_PAUSED
			//showflash();
			if (this.styleConfig["playBtnVisible"] == null || 
				this.styleConfig["playBtnVisible"] == true){
				this.CallAsFunc("playBtnVisible", new Array("true"));
				this.CallAsFunc("pauseBtnVisible", new Array("false"));
			}
			break;
		case 5:	// PS_PLAY
			//hideflash();
			this.iDuration = this.aplayer.GetDuration();
			if (this.styleConfig["playBtnVisible"] == null || 
				this.styleConfig["playBtnVisible"] == true){
				this.CallAsFunc("playBtnVisible", new Array("false"));
				this.CallAsFunc("pauseBtnVisible", new Array("true"));
			}
			
			if (this.styleConfig["processVisible"] == null || 
				this.styleConfig["processVisible"] == true){
				if (this.updateDurationTimer == null){
					this.updateDurationTimer = window.setInterval(UpdatePosition, 1000)
				}
			}
			break;				
	}
}

//AS代码对APlayer的控制，都集中在这里分发
APlayerUI.OnFlashCall = function(nID, args){
	if(nID != this.flashBarID)
		return;
	
	// alert(args.toString());
	if (args.indexOf("Pause") > 0){
		// alert("Pause");
		this.aplayer.Pause();
	}else if (args.indexOf("Play") > 0){
		// alert("PLAAYING");
		var state = this.aplayer.GetState()
		if (state == 0){
			// alert("Playing");
			this.aplayer.Open("http://169.254.15.254/test.mkv");
		}else{
			this.aplayer.Play();
		}
	}else if(args.indexOf("SetVolume") > 0){
		var arr = getAsArgsArr(args);//AS传过来的参数，第一个是函数名
		if(arr != null && arr.length > 1){
			var volumeVal = arr[1];
			volumeVal = Number(volumeVal);
			if (volumeVal != null && volumeVal != undefined){
				// alert("SetVolume volumeVal:"+volumeVal);
		
				this.aplayer.SetVolume(volumeVal);
			}
		}
	}else if(args.indexOf("SetPosition") > 0){
		var arr = getAsArgsArr(args);//AS传过来的参数，第一个是函数名
		if(arr != null && arr.length > 1){
			var posVal = arr[1];
			posVal = Number(posVal);
			if (posVal != null && posVal != undefined){
				// alert("SetVolume posVal:"+posVal);
		
				this.aplayer.SetPosition(posVal);
			}
		}
	}
}

var loadXML=function(xmlString){
	var xmlDoc = null;
	if(!window.DOMParser&&window.ActiveXObject){
		var xmlDomVersions = ['MSXML.2.DOMDocument.6.0', 'MSXML.2.DOMDocument.3.0', 'Microsoft.XMLDOM'];
		for (var i = 0; i < xmlDomVersions.length; i++) {
			try {
				xmlDoc = new ActiveXObject(xmlDomVersions[i]);
				xmlDoc.async = false;
				xmlDoc.loadXML(xmlString);//loadXML方法载入xml字符串
				break;
			} catch (e) {}
		}

	}
	return xmlDoc;
}

//AS使用OnFlashCall传过来的参数也统一为string
var getAsArgsArr=function(xmlStr){
	var xmlObj = loadXML(xmlStr);
	if(xmlObj == null){
		return null;
	}
	var elements = xmlObj.getElementsByTagName("arguments/string");
	if(elements.length < 1){
		return null;
	}
	var arr = new Array();
	
	for(var i=0;i<elements.length;i++){
		var val = elements[i].firstChild.nodeValue;
		if(val != null){
			arr.push(val);
		}
	}
	
	if (arr.length > 0)
		return arr;
	
	return null;
}
