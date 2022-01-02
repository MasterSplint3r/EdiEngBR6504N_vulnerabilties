<html>
<head>
<script language="JavaScript" src="file/function.js"></script>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>WAN Interface Setup </title>
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/netsys-n.var"></script>
<% language=javascript %>
<SCRIPT>
var pppConnectStatus=0;

function setPPPConnected()
{
   pppConnectStatus = 1;
}

function saveChanges(connect)
{
  if ( !(document.tcpip.pppConnectType.selectedIndex == 2 && pppConnectStatus==connect) && !(connect==3)) 
		return false;
	if (!strRule(document.tcpip.pppUserName,showText(pppoeUser)))
		return false;
	if (!strRule(document.tcpip.pppPassword,showText(pppoePass)))
		return false;

	if ( document.tcpip.pppConnectType.selectedIndex != 0 ) {
		if (!portRule(document.tcpip.pppIdleTime,showText(idleTime2), 0, "", 1, 1000, 1))
			return false;
	}
	if (!portRule(document.tcpip.pppMTU,showText(mtu), 0, "", 512, 1492, 1))
		return false;
   return true;
}

function pppTypeSelection() {
	if ( document.tcpip.pppConnectType.selectedIndex == 2) {
		if (pppConnectStatus==0) {
			document.tcpip.pppConnect.disabled=false;
			document.tcpip.pppDisconnect.disabled = true;
		} else {
			document.tcpip.pppConnect.disabled = true;
			document.tcpip.pppDisconnect.disabled=false;
		}
		document.tcpip.pppIdleTime.disabled = true;
	} else {
		document.tcpip.pppConnect.disabled = true;
		document.tcpip.pppDisconnect.disabled = true;
		if (document.tcpip.pppConnectType.selectedIndex == 1)
			document.tcpip.pppIdleTime.disabled=false;
		else
			document.tcpip.pppIdleTime.disabled=true;
	}
}

function changePage()  {
	parent.lFrame.stepDisplay(2);
	document.location.replace("settype.asp")
}
</SCRIPT>
</head>
<body class="background">
<blockquote>
<span id="genTlId">
<p align="center"><b><font class="titlecolor" size="4"><script>dw(PPPoE)</script></font></b><br><br>
<table border=0 width="520" align="center" cellspacing=0 cellpadding=0><tr><td>
<p align="left"><font class="textcolor" size="2"><script>dw(pppoeContent)</script></font></p>
</td></tr></table></span>
	
<span id="wizTlId" style="display:none">
<p align="center"><b><font class="titlecolor" size="4"><script>dw(IPAddrInfo)</script></font></b><br><br>
<table border=0 width="520" align="center" cellspacing=0 cellpadding=0><tr><td>
<p><b><font class="subcolor" size="2">PPPoE</font></b><br>
<font class="textcolor" size="2"><script>dw(wanpppoeContent)</script></font></p></td></tr></table><br>
</span>

<form action=/goform/formWanTcpipSetup method=POST name="tcpip">
<table border=1 width="520" align="center" cellspacing=0 cellpadding=0>
 <tr class="stable">
	<td width="100%" colspan="2"><font size=2>&nbsp;<script>dw(usePPPoE)</script></td>
</tr>
	   
<tr class="table2">
<td width="35%"><font size=2><script>dw(userName)</script> :&nbsp;</td>
<td width="65%" align="left"><font size=2>&nbsp;<input type="text" name="pppUserName" size="20" maxlength="64" value="<% getInfo("pppUserName"); %>"></td>
</tr>

<tr class="table2">
<td><font size=2><script>dw(password)</script> :&nbsp;</td>
<td align="left"><font size=2>&nbsp;<input type="password" name="pppPassword" size="20" maxlength="64" value="<% getInfo("pppPassword"); %>"></td>
</tr>

<tr class="table2">
<td width="35%"><font size=2><script>dw(serviceName)</script> :&nbsp;</td>
<td width="65%" align="left"><font size=2>&nbsp;<input type="text" name="pppServName" size="20" maxlength="30" value=<% getInfo("pppServName"); %>></td>
</tr>

<tr class="table2">
<td width="35%"><font size=2><script>dw(mtu)</script> :&nbsp;</td>
<td width="65%" align="left"><font size=2>&nbsp;<input type="text" name="pppMTU" size="10" maxlength="4" value=<% getInfo("pppMTU"); %>><font size=2>&nbsp;(512&lt;=MTU Value&lt;=1492)</td>
</tr>	  
			  
<tr class="table2">
<td><font size=2><script>dw(connectType)</script> :&nbsp;</td>
<td align="left"><font size=2>&nbsp;<select size="1" name="pppConnectType" onChange="pppTypeSelection()">
	<% var type = getIndex("pppConnectType");
		if ( type == 0 ) {
			write( "<option selected value=\"0\"><script>dw(continuous)</script></option>" );
			write( "<option value=\"1\"><script>dw(connectDemand)</script></option>" );
			write( "<option value=\"2\"><script>dw(manual)</script></option>" );
		}
		if ( type == 1 ) {
			write( "<option value=\"0\"><script>dw(continuous)</script></option>" );
			write( "<option selected value=\"1\"><script>dw(connectDemand)</script></option>" );
			write( "<option value=\"2\"><script>dw(manual)</script></option>" );
		}
		if ( type == 2 ) {
			write( "<option value=\"0\"><script>dw(continuous)</script></option>" );
			write( "<option value=\"1\"><script>dw(connectDemand)</script></option>" );
			write( "<option selected value=\"2\"><script>dw(manual)</script></option>" );
	}  %>
        </select>&nbsp;
	<script>document.write('<input type="submit" value="'+showText(connect)+'" name="pppConnect" onClick="return saveChanges(0)" class="btnsize">')</script>&nbsp;
	<script>document.write('<input type="submit" value="'+showText(disconnect)+'" name="pppDisconnect" onClick="return saveChanges(1)" class="btnsize">')</script>
	<% if ( getIndex("pppConnectStatus") ) write("\n<script> setPPPConnected(); </script>\n"); %>
	</td>
 </tr>

<tr class="table2">
<td><font size=2><script>dw(idleTime)</script> :&nbsp;</td>
<td align="left"><font size=2>&nbsp;<input type="text" name="pppIdleTime" size="10" maxlength="4" value="<% getInfo("wan-ppp-idle"); %>">&nbsp;(1-1000 <script>dw(minute)</script>)</td>
</tr>

<tr class="table2">
<td><font size=2>TTL :&nbsp;</td>
<td align="left"><font size=2>&nbsp;<input type="radio" value="0" name="pppEnTtl"<% if (getIndex("pppEnTtl")==0) write("checked"); %>>Disabled&nbsp;&nbsp;
<input type="radio" name="pppEnTtl" value="1"<% if (getIndex("pppEnTtl")==1) write("checked"); %>>Enabled</td></tr>

 </table>
   <SCRIPT>
      pppTypeSelection();
  </SCRIPT>
 </table>
<br>

<span id="genBtId">
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td align="right">
	<script>buffer='<input type=submit value="'+showText(apply1)+'" name="save" onclick="return saveChanges(3)" style ="width:100px">';document.write(buffer);</script>
	<input type=hidden value="/wanpppoe.asp" name="submit-url" id="submitUrl">
	<input type=hidden value="2" name="wanMode">
	<input type=hidden value="ppp" name="ipMode" >
	<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="document.tcpip.reset();">';document.write(buffer);</script>
</td>
</tr>
</table>
</span>


<span id="wizBtId" style="display:none">
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
<%  write("wizardEnabled = "+getIndex("wizardEnabled"));%>
if (wizardEnabled == 0) {
    document.getElementById('genTlId').style.display = "block";
    document.getElementById('genBtId').style.display = "block";
    document.getElementById('wizTlId').style.display = "none";
    document.getElementById('wizBtId').style.display = "none";
}
else {
    document.getElementById('genTlId').style.display = "none";
    document.getElementById('genBtId').style.display = "none";
    document.getElementById('wizTlId').style.display = "block";
    document.getElementById('wizBtId').style.display = "block";
	document.getElementById('submitUrl').value = "/template1.html";
}

</script>

  
</form>
</blockquote>
</body>
</html>
