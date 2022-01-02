<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>WAN PPTP Setup </title>
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/netsys-n.var"></script>
<script language="JavaScript" src="file/function.js"></script>
<% language=javascript %>
<SCRIPT>
var pppConnectStatus=0;

function setPPPConnected()
{
   pppConnectStatus = 1;
}

function saveChanges(connect)
{
strIp = document.tcpip.pptpIPAddr;
strMask = document.tcpip.pptpIPMaskAddr;
strDefGateway = document.tcpip.pptpDfGateway;
strPPTPGateway = document.tcpip.pptpGateway;

	if ( !(document.tcpip.pptpConnectType.selectedIndex == 2 && pppConnectStatus==connect) && !(connect==3)) 
		return false;

	if ( document.tcpip.Mac.value == "" )
		document.tcpip.Mac.value="000000000000";
		
	if (document.tcpip.pptpIpMode[1].checked==true) {	// Use the following IP address
		if ( !ipRule( strIp, showText(IPAddr), "ip", 1))
			return false;
		if(!maskRule(strMask, 1))
			return false;
		if ( !ipRule( strDefGateway, showText(gatewayAddr), "gw", 1))
			return false;
	}
	else {	// use auto
        	if( !macRule(document.tcpip.Mac, 1))
            	return false;
	}	

	if (!strRule(document.tcpip.pptpUserName,showText(pptpUserId)))
		return false;
	if (!strRule(document.tcpip.pptpPassword,showText(pptpPass)))
		return false;




//**********  **********
		if (!strRule(strPPTPGateway,showText(pptpGate)))
			return false;

//********** idle time **********
	if (document.tcpip.pptpConnectType.value==1) {
		if (!portRule(document.tcpip.pptpIdleTime,showText(idleTime2), 0, "", 1, 1000, 1))
			return false;
	}
	if (!portRule(document.tcpip.pptpMTU,showText(mtu), 0, "", 512, 1492, 1))
		return false;
	
   return true;
}

function autoIpClicked() {
	if(document.tcpip.pptpIpMode[0].checked==true) {
		document.tcpip.pptpIPAddr.disabled=true;
		document.tcpip.pptpIPMaskAddr.disabled=true;
		document.tcpip.pptpDfGateway.disabled = true;
		document.tcpip.HostName.disabled = false;
		document.tcpip.Mac.disabled = false;
		document.tcpip.Clone.disabled = false;
	}
	else {
		document.tcpip.pptpIPAddr.disabled=false;
		document.tcpip.pptpIPMaskAddr.disabled=false;
		document.tcpip.pptpDfGateway.disabled = false;
		document.tcpip.HostName.disabled = true;
		document.tcpip.Mac.disabled = true;
		document.tcpip.Clone.disabled = true;
	}
}

function pptpTypeSelection() {
	if ( document.tcpip.pptpConnectType.selectedIndex == 2) {
		if (pppConnectStatus==0) {
			document.tcpip.pptpConnect.disabled=false;
			document.tcpip.pptpDisconnect.disabled = true;
		} else {
			document.tcpip.pptpConnect.disabled = true;
			document.tcpip.pptpDisconnect.disabled=false;
		}
		document.tcpip.pptpIdleTime.disabled = true;
	} else {
		document.tcpip.pptpConnect.disabled = true;
		document.tcpip.pptpDisconnect.disabled = true;
		if (document.tcpip.pptpConnectType.selectedIndex == 1)
			document.tcpip.pptpIdleTime.disabled=false;
		else
			document.tcpip.pptpIdleTime.disabled = true;
	}
}

function copyto() {
	document.tcpip.Mac.value=document.tcpip.macAddrValue.value;
}

function changePage()  {
	parent.lFrame.stepDisplay(2);
	document.location.replace("settype.asp")
}
</SCRIPT>
</SCRIPT>
</head>
<body class="background">
<blockquote>
<script>
<%  write("wizardEnabled = "+getIndex("wizardEnabled"));%>
if (wizardEnabled == 0)
	document.write('<span style="display:block">');
else
	document.write('<span style="display:none">');
</script>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(PPTP)</script></font></b><br><br>
<table border=0 width="520" cellspacing=0 cellpadding=0 align="center"><tr><td>
<p align="left"><font class="textcolor" size="2"><script>dw(wansetPageContent5)</script><br>
</font></p></td></tr></table><br>
</span>

<script>
if (wizardEnabled == 1)
	document.write('<span style="display:block">');
else
	document.write('<span style="display:none">');
</script>
<p align=center><font class="titlecolor" size="4"><script>dw(IPAddrInfo)</script></font><br><br>
<table border=0 width="520" cellspacing=0 cellpadding=0 align="center"><tr><td>
<p><b><font class="subcolor" size="2"><script>dw(PPTP)</script></font></b><br>
<font class="textcolor" size="2"><script>dw(wansetPageContent5)</script></font></p></td></tr></table>
</span>
<form action=/goform/formPPTPSetup method=POST name="tcpip">
<center><li><font class="textcolor" size=2><b><script>dw(wanInterSet)</script></b></li></center><br>
<table border=1 width="520" cellspacing=0 cellpadding=0 align="center">
<tr><td colspan="2" class="lstable"><input type="radio" value="0" name="pptpIpMode" <% if (getIndex("pptpIpMode")==0) write("checked"); %> onClick="autoIpClicked()"><font class="textcolor" size=2><b>&nbsp;<script>dw(obtainIP)</script> :</br></td></tr>

<tr>
<td width="35%" class="table2"><font size=2><script>dw(hostName)</script> :&nbsp;</td>
<td width="65%" class="ltable"><font size=2>&nbsp;<input type="text" name="HostName" value="<% getInfo("dynIPHostName"); %>" size="20" maxlength="30"></td>
</tr>

<tr>
<input type=hidden value=<% getInfo("cloneMac"); %> name="macAddrValue">
<td class="table2"><font size=2><script>dw(macAddr)</script> :&nbsp;</td>
<td class="ltable"><font size=2>&nbsp;<input type="text" name="Mac" size="18" maxlength="12" value="<% getInfo("wanMac"); %>">
<script>document.write('<input type="button" value="'+showText(clone)+'" name="Clone" onClick="copyto();" class="btnsize">')</script></td>
</tr>

<tr><td colspan="2" class="lstable"><input type="radio" name="pptpIpMode" value="1" <% if (getIndex("pptpIpMode")==1) write("checked"); %> onClick="autoIpClicked()"><font class="textcolor" size=2><b>&nbsp;<script>dw(useIPAddr)</script> :</b></td></tr>

<tr>
<td class="table2" class="table1"><font size=2 align=left><script>dw(IPAddr)</script> :&nbsp;</td>
<td class="ltable"><font size=2>&nbsp;<input type="text" name="pptpIPAddr" size="15" maxlength="15" value="<% getInfo("pptpIPAddr"); %>"></td>
</tr>

<tr>
<td class="table2"><font size=2><script>dw(subnetMask)</script> :&nbsp;</td>
<td class="ltable"><font size=2>&nbsp;<input type="text" name="pptpIPMaskAddr" size="15" maxlength="15" value="<% getInfo("pptpIPMaskAddr"); %>"></td>
</tr>

<tr>
<td class="table2"><font size=2><script>dw(defaultGateway)</script> :&nbsp;</td>
<td class="ltable"><font size=2>&nbsp;<input type="text" name="pptpDfGateway" size="15" maxlength="15" value="<% getInfo("pptpDfGateway"); %>"></td>
</tr>
 </table>
 <br>
 <center><li><font size=2><b><script>dw(pptpSet)</script></b></li></center><br>
<table border=1 width="520" cellspacing=0 cellpadding=0 align="center">

<tr>
<td class="table2" width="30%"><font size=2><script>dw(userID)</script> :&nbsp;</td>
<td class="ltable" width="70%"><font size=2>&nbsp;<input type="text" name="pptpUserName" size="20" maxlength="64" value="<% getInfo("pptpUserName"); %>"></td>
</tr>

<tr>
<td class="table2"><font size=2><script>dw(password)</script> :&nbsp;</td>
<td class="ltable"><font size=2>&nbsp;<input type="password" name="pptpPassword" size="20" maxlength="64" value="<% getInfo("pptpPassword"); %>"></td>
</tr>

<tr>
<td class="table2"><font size=2><script>dw(pptpGate)</script> :&nbsp;</td>
<td class="ltable"><font size=2>&nbsp;<input type="text" name="pptpGateway" size="15" maxlength="30" value="<% getInfo("pptpGateway"); %>"></td>
</tr>

<tr>
<td class="table2"><font size=2><script>dw(connectionID)</script> :&nbsp;</td>
<td class="ltable"><font size=2>&nbsp;<input type="text" name="pptpConntID" size="20" maxlength="30" value="<% getInfo("pptpConntID"); %>">&nbsp;(<script>dw(optional)</script>)</td>
</tr>

<tr>
<td class="table2"><font size=2><script>dw(mtu)</script> :&nbsp;</td>
<td class="ltable"><font size=2>&nbsp;<input type="text" name="pptpMTU" size="10" maxlength="4" value=<% getInfo("pptpMTU"); %>><font size=2>&nbsp;(512&lt;=<script>dw(mtuVal)</script>&lt;=1492)</td>
</tr>
			  
<tr>
<td class="table2"><font size=2><script>dw(BEZEQ)</script> :&nbsp;</td>
<td class="ltable">&nbsp;<input type="checkbox" name="pptpBEZEQEnable" value="ON" <% if (getIndex("pptpBEZEQEnable")) write("checked");%>><font size=2><script>dw(useInISRAEL)</script></td>
</tr>
 
<tr>
<td class="table2"><font size=2><script>dw(connectType)</script> :&nbsp;</td>
<td class="ltable"><font size=2>&nbsp;<select size="1" name="pptpConnectType" onChange="pptpTypeSelection()">
<script>
<%	write("type = "+getIndex("pptpConnectType"));%>
var typeTbl = new Array(showText(continuous), showText(connectDemand),showText(manual));
	for (i=0 ; i<3 ; i++) {
		if ( i == type )
			document.write("<option selected value='" +i+"'>" +typeTbl[i]+ "</option>");
		else
			document.write("<option value='" +i+"'>" +typeTbl[i]+ "</option>");
	}
</script></select>&nbsp;
<script>document.write('<input type="submit" value="'+showText(connect)+'" name="pptpConnect" onClick="return saveChanges(0)" class="btnsize">')</script>&nbsp;
<script>document.write('<input type="submit" value="'+showText(disconnect)+'" name="pptpDisconnect" onClick="return saveChanges(1)" class="btnsize">')</script>
<% if ( getIndex("pppConnectStatus") ) write("\n<script> setPPPConnected(); </script>\n"); %>
</td>
</tr>

<tr>
<td class="table2"><font size=2><script>dw(idleTime)</script> :&nbsp;</font></td>
<td class="ltable"><font size=2>&nbsp;<input type="text" name="pptpIdleTime" size="10" maxlength="4" value="<% getInfo("wan-pptp-idle"); %>">&nbsp;(1-1000 <script>dw(minute)</script>)<br></font></td>
</tr>
<script>
 pptpTypeSelection();
 autoIpClicked();
</script>
</table>
<br>

<script>
if (wizardEnabled == 0)
	document.write('<span style="display:block">');
else
	document.write('<span style="display:none">');
</script>
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td align="right">
	<script>buffer='<input type=submit value="'+showText(apply1)+'" name="save" onclick="return saveChanges(3)" style ="width:100px">';document.write(buffer);</script>
	<input type=hidden value="/wanpptp.asp" name="submit-url" id="submitUrl">
	<input type=hidden value="3" name="wanMode" >
	<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="document.tcpip.reset();">';document.write(buffer);</script>
</td>
</tr>
</table>
</span>


<script>
if (wizardEnabled == 1)
	document.write('<span style="display:block">');
else
	document.write('<span style="display:none">');
</script>
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td align="right">
	<script>buffer='<input type=button value="'+showText(back1)+'" style ="width:100px" onClick="changePage();">';document.write(buffer);</script>
	<script>buffer='<input type=submit value="'+showText(ok1)+'" name="save" style ="width:100px" onClick="return saveChanges(3)">';document.write(buffer);</script>
</td>
</tr>
</table>
</span>

<script>
if (wizardEnabled == 1) {
	document.getElementById('submitUrl').value = "/template1.html";
}
</script>
</form>
</blockquote>
</body>
</html>
