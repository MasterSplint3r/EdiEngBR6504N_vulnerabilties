<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="no-cache">
<title>WLAN Basic Settings</title>
<script language ='javascript' src ='javascript.js'></script>
<script language ='javascript' src ='file/fwwl-n.var'></script>
<script language="JavaScript" src="file/function.js"></script>

<SCRIPT>
function openWindow(url, windowName) {
	var wide=660;
	var high=420;
	if (document.all)
		var xMax = screen.width, yMax = screen.height;
	else if (document.layers)
		var xMax = window.outerWidth, yMax = window.outerHeight;
	else
	   var xMax = 640, yMax=500;
	var xOffset = (xMax - wide)/2;
	var yOffset = (yMax - high)/3;

	var settings = 'width='+wide+',height='+high+',screenX='+xOffset+',screenY='+yOffset+',top='+yOffset+',left='+xOffset+', resizable=yes, toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes';

	window.open( url, windowName, settings );
}

function showMacClick(url) {
	openWindow(url, 'showWirelessClient' );
}

function saveChanges()
{
	if (apMode == 0 || apMode == 1 || apMode == 2 || apMode == 5 ) {
		if (document.wlanSetup.ssid.value=="") {
			alert(showText(wlbasicAlertEmpty));
			document.wlanSetup.ssid.value = document.wlanSetup.ssid.defaultValue;
			document.wlanSetup.ssid.focus();
			return false;
		}
	}

	if (apMode != 0 || apMode != 3 || apMode != 4 || apMode !=5) {
		if ( document.wlanSetup.wlanMac.value == "" )
			document.wlanSetup.wlanMac.value="000000000000";
		if ( !macRule(document.wlanSetup.wlanMac,showText(wlbasicStrMacAddr), 1))
			return false;
	}
	
	if (apMode == 3) {
		if ( !macRule(document.wlanSetup.wlLinkMac1,showText(wlbasicStrMacAddr1), 1))
			return false;
	}
	
	if (apMode == 4 || apMode == 5 ) {
		if ( !macRule(document.wlanSetup.wlLinkMac1,showText(wlbasicStrMacAddr1), 1))
			return false;
		if ( !macRule(document.wlanSetup.wlLinkMac2,showText(wlbasicStrMacAddr2), 1))
			return false;
		if ( !macRule(document.wlanSetup.wlLinkMac3,showText(wlbasicStrMacAddr3), 1))
			return false;
		if ( !macRule(document.wlanSetup.wlLinkMac4,showText(wlbasicStrMacAddr4), 1))
			return false;

	}
	
	if(document.wlanSetup.ssid.value!="<% getInfo("ssid"); %>"){
			document.wlanSetup.wpsStatus.value="1";
	}
	else{
	document.wlanSetup.wpsStatus.value="0";
	}
	ssidValue=document.wlanSetup.ssid.value;
	tempString="";
	for(i=0;i<ssidValue.length;i++) {
		if ( ssidValue.charAt(i) == ' ' ) {
			tempString+='_';
		}else{
			tempString+=ssidValue.charAt(i);
		}
  	}
 document.wlanSetup.ssid.value=tempString;
	return true;
}

function copyto() {
	document.wlanSetup.wlanMac.value=document.wlanSetup.macAddrValue.value;
}

function displayObj() {
    var showSsid = new Array("block","block","block","none","none","block");
    var showChan = new Array("block","block","none","block","block","block");
    var showClit = new Array("block","none","none","none","none","block");
	var showSurvey = new Array("none","block","block","none","none","none");  
	var showMac = new Array("none","none","none","block","block","block");
	var showMMac = new Array("none","none","none","none","block","block");
	var showSec3 = new Array("none","none","none","block","none","none");
	var showSec4 = new Array("none","none","none","none","block","none");
    var showSec5 = new Array("none","none","none","none","none","block");
    var showClone = new Array("none","block","block","none","none","none");
    var showRepeater = new Array("none","none","none","none","none","none","block");
//  var showClone = new Array("none","none","none","none","none","none");
    
    for (i=0; i<=6; i++) {
        if (document.wlanSetup.apMode.value == i) {
            document.getElementById('ssidId').style.display = showSsid[i];
            document.getElementById('chanId').style.display = showChan[i];
            document.getElementById('clitId').style.display = showClit[i];
            if (apMode == 1 || apMode == 2 )
                document.getElementById('surveyId').style.display = showSurvey[i];
            else
                document.getElementById('surveyId').style.display = "none";
            document.getElementById('macId').style.display = showMac[i];
            document.getElementById('multiMacId').style.display = showMMac[i];
            document.getElementById('secId3').style.display = showSec3[i];
            document.getElementById('secId4').style.display = showSec4[i];
            document.getElementById('secId5').style.display = showSec5[i];
            document.getElementById('cloneMacId').style.display = showClone[i];
            document.getElementById('repeaterId').style.display = showRepeater[i];
        }
    }
}

function reloadPage() {
    location.reload();
}
</SCRIPT>
</head>
<body class="background">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(wlSettings)</script></font></b></p>
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
<p align="left"><font class="textcolor" size="2"><script>dw(wlBasicInfo)</script></font></p></td></tr></table><br>
<form action=/goform/formWlanSetup method=POST name="wlanSetup">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="table2">
	<td width="35%"><font size=2><script>dw(mode)</script> :&nbsp;</td>
	<td width="65%" align="left"><font size=2>&nbsp;<select name="apMode" onChange="displayObj();">
<script>
<%  write("wlDev = "+getIndex("wlDev")+";");%>
<%  write("apMode = "+getIndex("apMode")+";");%>
<%  write("wisp = "+getIndex("opMode")+";");%>
    var modeTbl = new Array("AP","Station-Ad Hoc","Station-Infrastructure","AP Bridge-Point to Point","AP Bridge-Point to Multi-Point","AP Bridge-WDS");
for ( i=0; i<6; i++) {
    if ( i==apMode) {
        if ( (wlDev!=3 && wlDev!=4) || (i!=1 && i!=2))
            document.write('<option selected value="'+i+'">'+modeTbl[i]+'</option>');
    }
    else {
        if ( (wlDev!=3 && wlDev!=4) || (i!=1 && i!=2))
            document.write('<option value="'+i+'">'+modeTbl[i]+'</option>');
    }
}
</script></select></td></tr>
</table>

<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="table2"><td width="35%"><font size=2><script>dw(band)</script> :&nbsp;</td>
	<td width="65%" align="left"><font size=2>&nbsp;<select name="band">
<script>
<%  write("bandVal = "+getIndex("band")+";");%>
bandVal = bandVal-1;
	var bandTbl = new Array("2.4 GHz (B)","2.4 GHz (N)","2.4 GHz (B+G)", "2.4 GHz (G)", "2.4 GHz (B+G+N)");
	for (i=0; i<5; i++) {
		if (i==bandVal)
			document.write('<option selected value="'+i+'">'+bandTbl[i]+'</option>');
		else
			document.write('<option value="'+i+'">'+bandTbl[i]+'</option>');
	}
</script>

</td></tr>
</table>


<span id="ssidId" style="display:none">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="table2"><td width="35%"><font size=2><script>dw(wlEssid)</script> :&nbsp;</td>
	<td width="65%" align="left"><font size=2>&nbsp;<input type="text" name="ssid" size="25" maxlength="32" value=""></td></tr>
	<script>document.wlanSetup.ssid.value="<% getInfo("ssid"); %>"</script>
</table></span>

<span id="chanId" style="display:none">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="table2"><td width="35%"><font size=2><script>dw(wlChannelNum)</script> :&nbsp;</td>
	<td width="65%" align="left">&nbsp;<font size=2><select size="1" name="chan">
		<script>
			<% write("regDomain = "+getIndex("regDomain"));%>
			<% write("defaultChan = "+getIndex("channel"));%>
			var domainMin = new Array("1","1","1","10","10","1");
			var domainMax = new Array("11","11","13","11","13","14");
			for (i=1; i<=6; i++) {
				if ( i == regDomain ) {
					for (j=domainMin[i-1]; j<=domainMax[i-1]; j++) {
						if ( j==defaultChan)
	   		  				document.write('<option selected value="'+j+'">'+j+'</option>');
						else
		   		  			document.write('<option value="'+j+'">'+j+'</option>');
					}
   				}
			}
		</script>
		</select></td></tr>
</table>
</span>

<span id="clitId" style="display:none">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="table2"><td width="35%"><font size=2><script>dw(wlAssClients)</script> :&nbsp;</td>
	        <td width="65%" align="left"><font size=2>&nbsp;<script>document.write('<input type=button value="'+showText(swActCli)+'" name="showMac" onClick=showMacClick("/wlstatbl.asp")>')</script>
        </td></tr>
</table></span>
  
<span id="surveyId" style="display:none">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="table2"><td width="35%"><font size=2><script>dw(wlSiteSurvey)</script> :&nbsp;</td>
	<td width="65%" align="center"><font size=2>&nbsp;<script>document.write('<input type="button" value="'+showText(selSS)+'" name="selSurvey" onClick="showMacClick(\'/wlsurvey.asp\')">')</script></td></tr>
</table></span>

<span id="cloneMacId" style="display:none">
<table border=1 width="520" cellspacing=0 cellpadding="0" align="center" <% if (getIndex("modelType")==1) write("style='display:none'"); %>>
<tr class="table2"><input type=hidden value=<% getInfo("cloneMac"); %> name="macAddrValue">
<td width="35%"><font size=2><script>dw(wlWlanMac)</script> :&nbsp;</td>
<td width="65%" align="left"><font size=2>&nbsp;<input type="text" name="wlanMac" value="<% getInfo("wlanMac"); %>" size="20" maxlength="12">&nbsp;&nbsp;

<script>document.write('<input type="button" value="'+showText(cloneMac)+'" name="Clone" onClick="copyto();">')</script></td>
</tr>
</table>

<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="table2"><td width="35%"><font size=2><script>dw(wlAutoMacClone)</script> :&nbsp;</td>
<td width="65%" align="left"><font size=2>&nbsp;<% getInfo("wlMacAddr"); %>&nbsp;&nbsp;<input type="radio" name="autoMacClone" value="no"<% if (getIndex("autoMacClone")==0) write("checked"); %>><script>dw(disable)</script>&nbsp;&nbsp;
<input type="radio" name="autoMacClone" value="yes"<% if (getIndex("autoMacClone")==1) write("checked"); %>><script>dw(enable)</script></td></tr>
</table>
</span>

<span id="repeaterId" style="display:none">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="table2"><td>&nbsp;</td></tr>
	<tr>
		<td width="35%"><font size=2><script>dw(wlRootApSsid)</script> :&nbsp;</td>
		<td width="65%" align="left"><font size=2>&nbsp;<input type="text" name="repeaterSSID" size="25" maxlength="32" value="<% getInfo("repeaterSSID"); %>"></td>
	</tr>
	
	<script>
	if (apMode == 6) {
		document.write('<tr class="table2"><td width="35%"><font size=2' + showText(wlSiteSurvey) + ' :&nbsp;</td><td width="65%" align="center"><font size=2>&nbsp;<input type=button value="'+showText(selSS)+'" name="selSurvey" onClick=showMacClick("/wlsurvey2.asp")></td></tr>');
	}
	</script>
</table>

<!--<table border=0 width="470" cellspacing=3>
	<tr><td width="35%" class="table1"><font size=2>Set Security :&nbsp;</td>
	<td width="65%" class="table2"><font size=2>&nbsp;<input type="button" value="Set Security" name="selSurvey" onClick="showMacClick('/wlencrypt.asp')"></td></tr>
</table> -->
</span>

<span id="macId" style="display:none">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="table2"><td width="35%"><font size=2><script>dw(wlMacAddress)</script> 1 :&nbsp;</td>
	<td width="65%" align="left"><font size=2>&nbsp;<input type="text" size="15" maxlength="12" value="<% getInfo("wlLinkMac1"); %>" name="wlLinkMac1"></td></tr>
</table></span>

<span id="multiMacId" style="display:none">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="table2"><td width="35%"><font size=2><script>dw(wlMacAddress)</script> 2 :&nbsp;</td>
	<td width="65%" align="left"><font size=2>&nbsp;<input type="text" size="15" maxlength="12" value="<% getInfo("wlLinkMac2"); %>" name="wlLinkMac2"></td></tr>
</table>
	
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="table2"><td width="35%"><font size=2><script>dw(wlMacAddress)</script> 3 :&nbsp;</td>
	<td width="65%" align="left"><font size=2>&nbsp;<input type="text" size="15" maxlength="12" value="<% getInfo("wlLinkMac3"); %>" name="wlLinkMac3"></td></tr>
</table>
	
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="table2"><td width="35%"><font size=2><script>dw(wlMacAddress)</script> 4 :&nbsp;</td>
	<td width="65%" align="left"><font size=2>&nbsp;<input type="text" size="15" maxlength="12" value="<% getInfo("wlLinkMac4"); %>" name="wlLinkMac4"></td></tr>
</table>
</span>
	
<span id="secId3" style="display:none">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
    <tr class="table2"><td width="35%"><font size=2><script>dw(wlSetSecure)</script> :&nbsp;</td>
    <td width="65%" align="left"><font size=2>&nbsp;<script>document.write('<input type="button" value="'+showText(wlSetSecure)+'" name="selSurvey" onClick="showMacClick(\'/wlwdsenp3.asp\')">')</script></td></tr>
</table></span>

<span id="secId4" style="display:none">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
    <tr class="table2"><td width="35%"><font size=2><script>dw(wlSetSecure)</script> :&nbsp;</td>
    <td width="65%" align="left"><font size=2>&nbsp;<script>document.write('<input type="button" value="'+showText(wlSetSecure)+'" name="selSurvey" onClick="showMacClick(\'/wlwdsenp4.asp\')">')</script></td></tr>
</table></span>

<span id="secId5" style="display:none">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
    <tr class="table2"><td width="35%"><font size=2><script>dw(wlSetSecure)</script> :&nbsp;</td>
    <td width="65%" align="left"><font size=2>&nbsp;<script>document.write('<input type="button" value="'+showText(wlSetSecure)+'" name="selSurvey" onClick="showMacClick(\'/wlwdsenp5.asp\')">')</script></td></tr>
</table></span>

<script>
displayObj();
if (wisp==1) 
	document.wlanSetup.chan.disabled=true;
</script>

<br>
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tbody><tr><td align="right">
			<script>buffer='<input type=submit value="'+showText(apply1)+'" name="B1" onclick="return saveChanges()" style ="width:100px">';document.write(buffer);</script>
			<input type="hidden" value="/wlbasic.asp" name="wlan-url">
			<input type="hidden" value="0" name="wpsStatus">
			<input type="hidden" value=<% write(getIndex("opMode")); %> name="wisp">
 			<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="document.wlanSetup.reset();">';document.write(buffer);</script>
</td>
</tr></tbody>
</table>
</form>
</blockquote>
</body>
</html>
