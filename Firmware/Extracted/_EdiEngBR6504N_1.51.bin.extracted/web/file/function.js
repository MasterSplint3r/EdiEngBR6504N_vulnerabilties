var shead = document.getElementsByTagName('head');
var sscript = document.createElement('script');
sscript.src = '/file/fun-n.var';
sscript.type= 'text/javascript';
shead[0].appendChild(sscript);

//	o-------------: What added for multi-language webs! AT:2006.01.06.16 ------------

function helpSta() {
	var dateTbl = new Array(showText(date), "12/17/2001", "12/17/2001", "12/17/2001", "12/17/2001", "01/01/1970", "01/01/1970", "01/01/1970", "01/01/1970", "01/01/1970");
	var timeTbl = new Array(showText(time), "10:01:21", "10:01:11", "10:01:09", "09:47:17", "00:01:13", "00:01:13", "00:01:13", "00:01:13", "00:00:25");
var logTbl = new Array(showText(logMess), showText(ntpdat), "192.168.2.100"+ showText(logsucc), showText(userTimeOut),showText(ntpDate), showText(dhcpClientReceive) , showText(dhcpClientSend), showText(dhcpReceiveOffer),showText(dhcpSendDis),"192.168.2.100"+ showText(logsucc));
	for ( i=0 ; i<=9 ;i++) {
		document.write("<tr><td><font face='Arial' size='1'>"+ dateTbl[i] +"</td><td><font face='Arial' size='1'>"+ timeTbl[i] +"</td><td><font face='Arial' size='1'>"+ logTbl[i] +"</td></tr>");
	}
}

function helpSup() {}

//	o--------------------------------------------------------------------------------

function strRule(name, str) {
	if(name.value=="") {
		alert(str + showText(cannotEmpty));
		setFocus(name);
		return false;
	}
	return true;
}

function validateKey(str) {
   for (var i=0; i<str.length; i++) {
    if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
    		(str.charAt(i) == '.' ) )
			continue;
	return 0;
  }
  return 1;
}
function checkFormat(str,msg){
i=1;

  	while ( str.length!=0) {
		if ( str.charAt(0) == '.' ) {
			i++;
		}
		str = str.substring(1);
  	}

  	if ( i > 4 ){
  			alert(msg);
  			return false;
  		}
  	else
  			return true;
  		
}
function getDigit(str, num) {
  i=1;
  if ( num != 1 ) {
  	while (i!=num && str.length!=0) {
		if ( str.charAt(0) == '.' ) {
			i++;
		}
		str = str.substring(1);
  	}
  	if ( i!=num )
  		return -1;
  }
  for (i=0; i<str.length; i++) {
  	if ( str.charAt(i) == '.' ) {
		str = str.substring(0, i);
		break;
	}
  }
  if ( str.length == 0)
  	return -1;
  d = parseInt(str, 10);
  return d;
}

function checkDigitRange(str, num, min, max) {
  d = getDigit(str,num);
  if ( d > max || d < min )
      	return false;
  return true;
}

function checkMask(str, num, msg) {
	d = getDigit(str,num);
	if( !(d==0 || d==128 || d==192 || d==224 || d==240 || d==248 || d==252 || d==254 || d==255 )) {
		alert(msg + showText(functionAlert));
		return false;
	}
		return true;
}

function setFocus(field) {
	field.value = field.defaultValue;
	field.focus();
	return;
}

function maskRule (mask, defVal) {
	if (mask.value == "") {
		alert(showText(functionAlert2));
		if (defVal == 1)
			mask.value = mask.defaultValue;
		mask.focus();
		return false;
	}
	if ( validateKey( mask.value ) == 0 ) {
		alert(showText(functionAlert3));
		if (defVal == 1)
			mask.value = mask.defaultValue;
		mask.focus();
		return false;
	}
	if ( !checkMask(mask.value,1, showText(alertFunctionInvMask1st)) ) {
		if (defVal == 1)
			mask.value = mask.defaultValue;
		mask.focus();
		return false;
	}
	if ( !checkMask(mask.value,2, showText(alertFunctionInvMask2nd)) ) {
		if (defVal == 1)
			mask.value = mask.defaultValue;
		mask.focus();
		return false;
	}
	if ( !checkMask(mask.value,3, showText(alertFunctionInvMask3rd)) ) {
		if (defVal == 1)
			mask.value = mask.defaultValue;
		mask.focus();
		return false;
	}
	if ( !checkMask(mask.value,4, showText(alertFunctionInvMask4th)) ) {
		if (defVal == 1)
			mask.value = mask.defaultValue;
		mask.focus();
		return false;
	}
	return true;
}

function checkIpAddr(field, msg)
{
   if ( validateKey(field.value) == 0) {
      alert(msg +showText(functionAlert4));
      return false;
   }
   if ( !checkDigitRange(field.value,1,0,255) ) {
      alert(msg + showText(functionAlert5));
      return false;
   }
   if ( !checkDigitRange(field.value,2,0,255) ) {
      alert(msg + showText(functionAlert6));
      return false;
   }
   if ( !checkDigitRange(field.value,3,0,255) ) {
      alert(msg + showText(functionAlert7));
      return false;
   }
   if ( !checkDigitRange(field.value,4,0,254) ) {
      alert(msg + showText(functionAlert8));
      return false;
   }
   return true;
}

function ipRule(ip, str, type, defVal) {
	if (type == "ip") {
		if (ip.value=="") {
			alert(str+showText(functionAlert9));
			if (defVal == 1)
				ip.value = ip.defaultValue;
			ip.focus();
			return false;
		}
	}
	else {
		if (ip.value=="" || ip.value=="0.0.0.0") {
			ip.value = "0.0.0.0";
			return true;
		}
	}

	if ( checkFormat(ip.value,showText(functionAlert13)+":"+ip.value) == false)
		return false;
	if ( checkIpAddr(ip, showText(alertFunctionInvalid)+str) == false ){
		if (defVal == 1)
			ip.value = ip.defaultValue;
		ip.focus();
    	return false;
	}
   return true;
}

function checkSubnet(ip, mask, client) {
  ip_d = getDigit(ip, 1);
  mask_d = getDigit(mask, 1);
  client_d = getDigit(client, 1);
  if ( (ip_d & mask_d) != (client_d & mask_d ) )
	return false;

  ip_d = getDigit(ip, 2);
  mask_d = getDigit(mask, 2);
  client_d = getDigit(client, 2);
  if ( (ip_d & mask_d) != (client_d & mask_d ) )
	return false;

  ip_d = getDigit(ip, 3);
  mask_d = getDigit(mask, 3);
  client_d = getDigit(client, 3);
  if ( (ip_d & mask_d) != (client_d & mask_d ) )
	return false;

  ip_d = getDigit(ip, 4);
  mask_d = getDigit(mask, 4);
  client_d = getDigit(client, 4);
  if ( (ip_d & mask_d) != (client_d & mask_d ) )
	return false;

  return true;
}

function subnetRule(ip, mask, client, str) {
	if (client.value!="" && client.value!="0.0.0.0") {
        if ( !checkSubnet(ip.value, mask.value, client.value)) {
            alert(showText(functionAlert10)+str+showText(functionAlert11));
            client.value = client.defaultValue;
			client.focus();
            return false;
        }
    }
	return true;
}

function portRule( fromPort, fromStr, toPort, toStr, min, max, defVal) {
//********** from port **********
	if (fromPort.value=="") {
		alert(fromStr+showText(functionAlert12)+min+"-"+max+".");
		if ( defVal == 1 )
			fromPort.value = fromPort.defaultValue;
		fromPort.focus();
		return false;
	}
	if ( validateKey( fromPort.value ) == 0 ) {
		alert(showText(functionAlert13)+fromStr+showText(functionAlert14));
		if ( defVal == 1 )
			fromPort.value = fromPort.defaultValue;
		fromPort.focus();
		return false;
	}
	d1 = getDigit(fromPort.value, 1);
	if (d1 > max || d1 < min) {
		alert(showText(functionAlert13)+fromStr+showText(functionAlert15)+min+"-"+max+".");
		if ( defVal == 1 )
			fromPort.value = fromPort.defaultValue;
		fromPort.focus();
		return false;
	}
//********** to port **********
	if (toStr != "") {
		if (toPort.value!="") {
  			if ( validateKey( toPort.value ) == 0 ) {
				alert(showText(functionAlert13)+toStr+showText(functionAlert14));
				if ( defVal == 1 )
					toPort.value = toPort.defaultValue;
				toPort.focus();
				return false;
  			}
			d2 = getDigit(toPort.value, 1);
 			if (d2 > max || d2 < min) {
			alert(showText(functionAlert13)+toStr+showText(functionAlert15)+min+"-"+max+".");
				if ( defVal == 1 )
					toPort.value = toPort.defaultValue;
				toPort.focus();
				return false;
  			}
			if (d1 > d2 ) {
				alert(showText(functionAlert16));
				if ( defVal == 1 )
					toPort.value = toPort.defaultValue;
				fromPort.focus();
				return false;
			}
		}
	}
	return true;
}

function macRule( mac, defVal) {
	var str = mac.value;
	if ( str.length < 12) {
		alert(showText(functionAlert17));
		if ( defVal == 1 )
			mac.value = mac.defaultValue;
		mac.focus();
		return false;
	}

	for (var i=0; i<str.length; i++) {
		if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
			(str.charAt(i) >= 'a' && str.charAt(i) <= 'f') ||
			(str.charAt(i) >= 'A' && str.charAt(i) <= 'F') )
			continue;

		alert(showText(functionAlert18));
		if ( defVal == 1 )
			mac.value = mac.defaultValue;
		mac.focus();
		return false;
	}
		return true;
}

function MM_openBrWindow(theURL,winName,features){
	window.open(theURL,winName,features);
}

function deleteClick() {
	if ( !confirm(showText(functionConfirm)) ) {
		return false;
	}
	else
		return true;
}

function deleteAllClick() {
	if ( !confirm(showText(functionConfirm2)) ) {
		return false;
	}
	else
		return true;
}

function qosTxt(text) {
	var buffer;
	if (text == "title")	buffer = showText(alertFunctionQoS);
	if (text == "enable")	buffer = "<b>&nbsp;&nbsp;"+showText(alertFunctionQoSEnable)+"</b>";
	if (text == "wan1Tbl")	buffer = "<b>"+showText(alertFunctionQoSTable)+":</b>";
	if (text == "wan2Tbl")	buffer = "<b>"+showText(alertFunctionQoSWan2)+":</b>";
	if (text == "wan3Tbl")	buffer = "<b>"+showText(alertFunctionQoSWan3)+":</b>";
	if (text == "wan4Tbl")	buffer = "<b>"+showText(alertFunctionQoSWan4)+":</b>";
	if (text == "priority")	buffer = "<b>"+showText(alertFunctionPriority)+"</b>";
	if (text == "name")		buffer = "<b>"+showText(alertFunctionRule)+"</b>";
	if (text == "upload")	buffer = "<b>"+showText(alertFunctionUpBand)+"</b>";
	if (text == "download")	buffer = "<b>"+showText(alertFunctionDnBand)+"</b>";
	if (text == "select")	buffer = "<b>"+showText(alertFunctionSelect)+"</b>";
	document.write(buffer);	
}

function qosBtnTxt(form) {
	form.addQos.value	=showText(alertFunctionAdd); 
	form.showQos.value	=showText(alertFunctionEdit); 
	form.delSelQos.value=showText(alertFunctionDelSelect); 
	form.delAllQos.value=showText(alertFunctionDelAll); 
	form.moveUpQos.value=showText(alertFunctionMoveUp); 
	form.moveDownQos.value=showText(alertFunctionMoveUp); 
	form.reset.value	=showText(alertFunctionReset); 
	return true;
}

function qosAddTxt(text) {
	var buffer;
	if (text == "title")	buffer = showText(alertFunctionQoS);
	if (text == "descript")	buffer = "";
	if (text == "name")		buffer = "<b>"+showText(alertFunctionRule)+" :&nbsp;</b>";
	if (text == "wanIf")	buffer = "<b>"+showText(alertFunctionWanPort)+" :&nbsp;</b>";
	if (text == "strBw")	buffer = "<b>"+showText(alertFunctionBandwidth)+" :&nbsp;</b>";
	if (text == "scAddr")	buffer = "<b>"+showText(alertFunctionLocalAddr)+" :&nbsp;</b>";
	if (text == "ip")		buffer = "<b>"+showText(alertFunctionLocalIp)+" :&nbsp;</b>";
	if (text == "mac")		buffer = "<b>"+showText(alertFunctionMacAddr)+" :&nbsp;</b>";
	if (text == "dtIp")		buffer = "<b>"+showText(alertFunctionRemoteIp)+" :&nbsp;</b>";
	if (text == "traf")		buffer = "<b>"+showText(alertFunctionTraffic)+" :&nbsp;</b>";
	if (text == "ptl")		buffer = "<b>"+showText(alertFunctionProtocol)+" :&nbsp;</b>";
	if (text == "scPort")	buffer = "<b>"+showText(alertFunctionLocalRange)+" :&nbsp;</b>";
	if (text == "dtPort")	buffer = "<b>"+showText(alertFunctionRemoteRange)+" :&nbsp;</b>";
	if (text == "btn") { 
		document.formQos.apply.value=showText(alertFunctionSave);
		document.formQos.reset.value=showText(alertFunctionReset); return true; 
	}
	document.write(buffer);	
}
