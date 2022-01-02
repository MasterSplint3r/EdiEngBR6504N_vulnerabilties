<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset =utf-8">
<title>WLAN Basic Settings</title>
<script language ="javascript" src ="javascript.js"></script>
<script language ="javascript" src ="file/wireless-n.var"></script>
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

function saveChanges() {
	if ( document.wlanSetup.wlanMac.value == "" )
		document.wlanSetup.wlanMac.value="000000000000";
		
	if ( !macRule(document.wlanSetup.wlanMac,'wireless MAC address', 1))
		return false;
		
	if (document.wlanSetup.ssid.value=="") {
		alert('ESSID cannot be empty!');
		document.wlanSetup.ssid.value = document.wlanSetup.ssid.defaultValue;
		document.wlanSetup.ssid.focus();
		return false;
	}
	
	return true;
}

function copyto() {
	document.wlanSetup.wlanMac.value=document.wlanSetup.macAddrValue.value;
}

function reloadPage() {
    location.reload();
}
</SCRIPT>
</head>

<body class="background" background="file/back-a.gif">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(wirelessWSet)</script></font></b></p>

</blockquote>
<div align="center">
<table border="0" width="520" id="table1">
<tr>
	<td>
		<p align="left"><font class="textcolor" size="2"><script>dw(wlBasicInfo)</script></font></p></td>
		</tr>
	</table></div>
<form action=/goform/formWlanSetup method=POST name="wlanSetup">
<input type=hidden value=1 name="wisp">

<table border=1 width="520" cellspacing=0 align="center">
<tr>
	<td width="35%" class="table2"><font size=2><script>dw(essid)</script> :&nbsp;</td>
	<td width="65%" class="table2">
		<font size=2>&nbsp;<input type="text" name="repeaterSSID" size="25" maxlength="32" value="<% getInfo("repeaterSSID"); %>" style="font-size: 10pt; font-family: Arial">
	</td>
</tr>
</table>

<table width="520" border="1" cellspacing="0" align="center">
<tr>
	<td width="35%" class="table2"><font size=2><script>dw(channelNum)</script> :&nbsp;</td>
	<td width="65%" class="table2">&nbsp;<font size=2>
		<select size="1" name="chan">
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
		</select>
	</td>
</tr>
</table>

<table border=1 width="520" cellspacing=0 align="center">
<tr>
	<td width="35%" class="table2"><font size=2><script>dw(siteSurvey)</script> :&nbsp;</td>
	<td width="65%" class="table2">
		<font size=2>&nbsp;<script>document.write('<input type="button" value="'+showText(selectSite)+'" name="selSurvey" onClick="showMacClick(\'/wlsurvey2.asp\')" class="btnsize">')</script>
	</td>
</tr>
</table>

<br>
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
	<td align="right">
<script>document.write('<input type="submit" value="'+showText(applys)+'" onClick="return saveChanges()" style ="width:100px">');</script>
<input type="hidden" value="/wlwanset.asp" name="wlan-url">
<script>document.write('<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="window.location.reload();">');</script>
	</td>
</tr>
</tbody>
</table>
</form>
</body>
</html>