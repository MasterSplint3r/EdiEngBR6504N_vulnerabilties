<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>WAN L2TP Setup </title>
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
strIp = document.tcpip.L2TPIPAddr;
strMask = document.tcpip.L2TPMaskAddr;
strDefGateway = document.tcpip.L2TPDefGateway;
strL2TPGateway = document.tcpip.L2TPGateway;

	if ( !(document.tcpip.L2TPConnectType.selectedIndex == 2 && pppConnectStatus==connect) && !(connect==3)) 
		return false;

	if ( document.tcpip.Mac.value == "" )
		document.tcpip.Mac.value="000000000000";
		
	if (document.tcpip.L2TPIpMode[1].checked==true) {
		if ( !ipRule( strIp, showText(IPAddr), "ip", 1))
			return false;
		if(!maskRule(strMask, 1))
			return false;
		if ( !ipRule( strDefGateway, showText(gatewayAddr), "gw", 1))
			return false;
	}
	else {
        	if( !macRule(document.tcpip.Mac, 1))
            	return false;
	}   

	if (!strRule(document.tcpip.L2TPUserName,showText(l2tpUserId)))
		return false;
	if (!strRule(document.tcpip.L2TPPassword,showText(l2tpPass)))
		return false;
//********** L2TP gateway **********
	if (!strRule(strL2TPGateway,showText(L2TPGateway)))
		return false;
		/*
	if (l2tpGwMode == 0) {
		if ( !ipRule( strL2TPGateway, showText(pptpGateAddr), "gw", 1))
			return false;
	}
	*/
//********** idle time **********
	if ( document.tcpip.L2TPConnectType.selectedIndex == 1) {
		if (!portRule(document.tcpip.L2TPIdleTime, showText(idleTime2), 0, "", 1, 1000, 1))
			return false;
	}
	if (!portRule(document.tcpip.L2TPMTU, showText(mtu), 0, "", 512, 1492, 1))
		return false;
	
	return true;
}

function autoIpClicked() {
  if(document.tcpip.L2TPIpMode[0].checked==true){
      document.tcpip.L2TPIPAddr.disabled = true;
      document.tcpip.L2TPMaskAddr.disabled = true;
      document.tcpip.L2TPDefGateway.disabled = true;
      document.tcpip.HostName.disabled = false;
      document.tcpip.Mac.disabled = false;
      document.tcpip.Clone.disabled = false;
   }
 else{
	  document.tcpip.L2TPIPAddr.disabled = false;
      document.tcpip.L2TPMaskAddr.disabled = false;
      document.tcpip.L2TPDefGateway.disabled = false;
      document.tcpip.HostName.disabled = true;
      document.tcpip.Mac.disabled = true;
      document.tcpip.Clone.disabled = true;
  }
}

function L2TPTypeSelection()
{
  if ( document.tcpip.L2TPConnectType.selectedIndex == 2) {
  	if (pppConnectStatus==0) {
  		document.tcpip.L2TPConnect.disabled=false;
		document.tcpip.L2TPDisconnect.disabled=true;
	}
	else {
 		document.tcpip.L2TPConnect.disabled=true;
		document.tcpip.L2TPDisconnect.disabled=false;
	}
	document.tcpip.L2TPIdleTime.disabled=true;
  }
  else {
	document.tcpip.L2TPConnect.disabled=true;
	document.tcpip.L2TPDisconnect.disabled=true;
	if (document.tcpip.L2TPConnectType.selectedIndex == 1)
		document.tcpip.L2TPIdleTime.disabled=false;
	else
		document.tcpip.L2TPIdleTime.disabled=true;
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
<p align="center"><b><font class="titlecolor" size="4"><script>dw(L2TP)</script></font></b>
<p align="center"><font class="textcolor" size="2"><script>dw(wansetPageContent6)</script><br></font></p>
</span>
<script>
if (wizardEnabled == 1)
	document.write('<span style="display:block">');
else
	document.write('<span style="display:none">');
</script>
<p align="center"><font class="titlecolor" size="4"><script>dw(IPAddrInfo)</script></font><br><br>
<table border=0 width="520" cellspacing=0 cellpadding=0 align="center"><tr><td>
<p><b><font class="subcolor" size="2"><script>dw(L2TP)</script></font></b><br>
<font class="textcolor" size="2"><script>dw(wansetPageContent6)</script><br></font></p></td></tr></table>
</span>

<form action=/goform/formL2TPSetup method=POST name="tcpip">
<center><li><font size=2 class="textcolor"><b><script>dw(wanInterSet)</script></b></li></center><br>
<table border=1 width="520" cellspacing=0 cellpadding=0 align="center">

<tr>
<td colspan="2" class="lstable"><input type="radio" value="0" name="L2TPIpMode" <% if (getIndex("L2TPIpMode")==0) write("checked"); %> onClick="autoIpClicked()"><font size=2 class="textcolor"><b>&nbsp;<script>dw(obtainIP)</script> :</b></font></td>
</tr>

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

<tr>
<td colspan="2" class="lstable"><input type="radio" name="L2TPIpMode" value="1" <% if (getIndex("L2TPIpMode")==1) write("checked"); %> onClick="autoIpClicked()"><font size=2 class="textcolor"><b>&nbsp;<script>dw(useIPAddr)</script> :</b></font></td>
</tr>

<tr>
<td class="table2" width="35%" class="table1"><font size=2 align=left><script>dw(IPAddr)</script> :&nbsp;</td>
<td class="ltable" width="65%"><font size=2>&nbsp;<input type="text" name="L2TPIPAddr" size="18" maxlength="15" value="<% getInfo("L2TPIPAddr"); %>"></td>
</tr>

<tr>
<td class="table2"><font size=2><script>dw(subnetMask)</script> :&nbsp;</td>
<td class="ltable"><font size=2>&nbsp;<input type="text" name="L2TPMaskAddr" size="18" maxlength="15" value="<% getInfo("L2TPMaskAddr"); %>"></td>
</tr>

<tr>
<td class="table2"><font size=2><script>dw(defaultGateway)</script> :&nbsp;</td>
<td class="ltable"><font size=2>&nbsp;<input type="text" name="L2TPDefGateway" size="18" maxlength="15" value="<% getInfo("L2TPDefGateway"); %>"></td>
</tr>

</table>
 <br>

<center><li><font size=2><b><script>dw(l2tpSet)</script></b></li></center><br>
<table border=1 width="520" cellspacing=0 cellpadding=0 align="center">

<tr>
<td class="table2" width="30%"><font size=2><script>dw(userID)</script> :&nbsp;</td>
<td class="ltable" width="70%"><font size=2>&nbsp;<input type="text" name="L2TPUserName" size="18" maxlength="64" value="<% getInfo("L2TPUserName"); %>"></td>
</tr>

<tr>
<td class="table2"><font size=2><script>dw(password)</script> :&nbsp;</td>
<td class="ltable"><font size=2>&nbsp;<input type="password" name="L2TPPassword" size="18" maxlength="64" value="<% getInfo("L2TPPassword"); %>"></td>
</tr>

<tr>
<td class="table2"><font size=2><script>dw(L2TPGateway)</script> :&nbsp;</td>
<td class="ltable"><font size=2>&nbsp;<input type="text" name="L2TPGateway" size="18" maxlength="30" value="<% getInfo("L2TPGateway"); %>"></td>
</tr>

<tr>
<td class="table2"><font size=2><script>dw(mtu)</script> :&nbsp;</td>
<td class="ltable"><font size=2>&nbsp;<input type="text" name="L2TPMTU" size="10" maxlength="4" value=<% getInfo("L2TPMTU"); %>><font size=2>&nbsp;(512&lt;=MTU Value&lt;=1492)</font></td>
</tr>
			  
<tr>
<td class="table2"><font size=2><script>dw(connectType)</script> :&nbsp;</td>
<td class="ltable"><font size=2>&nbsp;<select size="1" name="L2TPConnectType" onChange="L2TPTypeSelection()">
<script>
<%	write("type = "+getIndex("L2TPConnectType"));%>
var typeTbl = new Array(showText(continuous),showText(connectDemand),showText(manual));
	for (i=0 ; i<3 ; i++) {
		if ( i == type )
			document.write("<option selected value='" +i+"'>" +typeTbl[i]+ "</option>");
		else
			document.write("<option value='" +i+"'>" +typeTbl[i]+ "</option>");
	}
</script></select>&nbsp;
<script>document.write('<input type="submit" value="'+showText(connect)+'" name="L2TPConnect" onClick="return saveChanges(0)" class="btnsize">')</script>&nbsp;
<script>document.write('<input type="submit" value="'+showText(disconnect)+'" name="L2TPDisconnect" onClick="return saveChanges(1)" class="btnsize">')</script>
<% if ( getIndex("pppConnectStatus") ) write("\n<script>setPPPConnected(); </script>\n"); %>
</td>
</tr>

<tr>
<td class="table2"><font size=2><script>dw(idleTime)</script> :&nbsp;</font></td>
<td class="ltable"><font size=2>&nbsp;<input type="text" name="L2TPIdleTime" size="10" maxlength="4" value="<% getInfo("L2TPIdleTime"); %>">&nbsp;(1-1000 minutes)<br></font></td>
</tr>

<script>
<%	write("l2tpGwMode = "+getIndex("l2tpGwMode")+";");%>
 L2TPTypeSelection();
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
	<input type=hidden value="/wanl2tp.asp" name="submit-url" id="submitUrl">
	<input type=hidden value="6" name="wanMode" >
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
