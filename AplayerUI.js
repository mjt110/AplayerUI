
function APlayerUI() {
	
	
}

APlayerUI.UI=null;
APlayerUI.styleConfig=null;
APlayerUI.flashBarID=null;
APlayerUI.flashUrl="http://192.168.24.195/client/ctrl.swf";
	
	
// styleConfigObj = {nextBtnVisible:false, processVisible:false}//只传需要隐藏的部分即可。
APlayerUI.InitUIStyle = function(uiElement, styleConfigObj){
	alert("InitUIStyle")
	this.UI = uiElement;
	this.styleConfig = styleConfigObj;
	
	this.flashBarID = this.UI.AddElement(3, this.flashUrl);
	this.UI.SetElementPosition(this.flashBarID, 7, 0, 80, 100, 20);
	this.UI.SetElementVisible(this.flashBarID, true);
	
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
	var invokeStr = '<invoke name=\"';
	invokeStr = invokeStr + sname + '\" returntype=\"xml\"><arguments>';
	
	var tmpStr = ""
	for (var i = 0; i < argArr.length; i++) {
		if (argArr[i].toString()){
			tmpStr = tmpStr + "<string>";
			tmpStr = tmpStr + argArr[i].toString();
			tmpStr = tmpStr + "</string>"
		}
	}
	invokeStr = invokeStr + tmpStr;
	invokeStr = invokeStr + '</arguments></invoke>'
	
	alert(this.flashBarID);
	var ret = this.UI.CallFlashFunction(this.flashBarID, invokeStr);
	alert(ret);
	return ret;
}

APlayerUI.SetCtrlBarVisible = function(visible){
	if (this.flashBarID != null && this.UI != null){
		this.UI.SetElementVisible(this.flashBarID, visible);
	}
}

