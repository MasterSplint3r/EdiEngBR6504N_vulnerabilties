<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>WAN Static IP Setup </title>
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/netsys-n.var"></script>
<script language="JavaScript" src="file/function.js"></script>
<% language=javascript %>
<SCRIPT>
function saveChanges()
{
	if ( !ipRule( document.tcpip.ip, showText(IPAddr), "ip", 1))
		return false;

	if ( !maskRule( document.tcpip.mask, 1))
		return false;

	if ( !ipRule( document.tcpip.gateway, showText(gatewayAddr), "gw", 1))
		return false;
   
	if ( !subnetRule(document.tcpip.ip, document.tcpip.mask, document.tcpip.gateway, showText(gatewayAddr)))
        return false;

	if (wizardEnabled ==1) {
		if ( !ipRule( document.tcpip.dns1, showText(dnsAddr), "gw", 1))
			return false;
	}
   
   return true;
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
<p align="center"><b><font class="titlecolor" size="4"><script>dw(StaticIP)</script></font></b><br><br>
<table border=0 align="center" width="540" cellspacing=0 cellpadding=0><tr><td>
<p align="left"><font class="textcolor" size="2"><script>dw(wansipContent)</script><br>
</font></p></td></tr></table><br>
</span>

<span id="wizTlId" style="display:none">
<p align="center"><b><font class="titlecolor" size="4"><script>dw(IPAddrInfo)</script></font></b><br><br>
<table border="0" width="540" cellspacing="0" cellpadding="0" align="center"><tr><td>
<p><b><font class="subcolor" size="2"><script>dw(fixedIP)</script></font></b><br>
<font class="textcolor"  size="2"><script>dw(wansipContent2)</script><br>
</font></p></td></tr></table><br>
</span>

<form action=/goform/formWanTcpipSetup method=POST name="tcpip">
<table border=1 align="center" width="540" cellspacing=0 cellpadding=0>
<tr class="table2">
<td width="65%"><font size=2><script>dw(StaticIPAddr)</script> :&nbsp;</td>
<td width="35%" align="left"><font size=2>&nbsp;<input type="text" name="ip" size="15" maxlength="15" value=<% getInfo("wan-ip-rom"); %>></td>
</tr>
</table>

<table border=1 align="center" width="540" cellspacing=0 cellpadding=0>
<tr class="table2">
<td width="65%"><font size=2><script>dw(subnetMask)</script> :&nbsp;</td>
<td width="35%" align="left"><font size=2>&nbsp;<input type="text" name="mask" size="15" maxlength="15" value="<% getInfo("wan-mask-rom"); %>"></td>
</tr>
</table>

<span id="dnsId" style="display:none">
<table border=1 align="center" width="540" cellspacing=0 cellpadding=0>
<tr class="table2">
<td width="65%"><font size=2><script>dw(dnsAddr)</script> :&nbsp;</td>
<td width="35%" align="left"><font size=2>&nbsp;<input type="text" name="dns1" size="15" maxlength="15" value="<% getInfo("wan-dns1"); %>"></td>
</tr>
</table>
</span>

<table border=1 align="center" width="540" cellspacing=0 cellpadding=0>
<tr class="table2">
<td width="65%"><font size=2><script>dw(gateAddr)</script> :&nbsp;</td>
<td width="35%" align="left"><font size=2>&nbsp;<input type="text" name="gateway" size="15" maxlength="15" value="<% getInfo("wan-gateway-rom"); %>"></td>
</tr>
</table>

<table border=1 align="center" width="540" cellspacing=0 cellpadding=0>
<tr class="table2">
<td width="65%"><font size=2>TTL :&nbsp;</td>
<td width="35%" align="left"><font size=2>&nbsp;<input type="radio" value="0" name="pppEnTtl"<% if (getIndex("pppEnTtl")==0) write("checked"); %>>Disabled&nbsp;&nbsp;
<input type="radio" name="pppEnTtl" value="1"<% if (getIndex("pppEnTtl")==1) write("checked"); %>><font class="textcolor" size="2">Enabled</font></td></tr>
</table>

<br>
<span id="genBtId">
<table border=0 align="center" width="540" cellspacing=0 cellpadding=0>
<tr><td align="right">
	<script>buffer='<input type=submit value="'+showText(apply1)+'" onclick="return saveChanges()" style ="width:100px">';document.write(buffer);</script>
	<input type=hidden value="/wansip.asp" name="submit-url" id="submitUrl">
	<input type=hidden value="1" name="wanMode" >
	<input type=hidden value="fixedIp" name="ipMode" >
	<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="document.tcpip.reset();">';document.write(buffer);</script>
</td>
</tr>
</table>
</span>

<span id="wizBtId" style="display:none">
<table width="540" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td align="right">
	<script>buffer='<input type=button value="'+showText(back1)+'" style ="width:100px" onClick="changePage();">';document.write(buffer);</script>
	<script>buffer='<input type=submit value="'+showText(ok1)+'" name="save" style ="width:100px" onClick="return saveChanges()">';document.write(buffer);</script>
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
    document.getElementById('dnsId').style.display = "none";
}
else {
    document.getElementById('genTlId').style.display = "none";
    document.getElementById('genBtId').style.display = "none";
    document.getElementById('wizTlId').style.display = "block";
    document.getElementById('wizBtId').style.display = "block";
    document.getElementById('dnsId').style.display = "block";
	document.getElementById('submitUrl').value = "/template1.html";
}

</script>
</form>
</blockquote>
</body>
</html>
