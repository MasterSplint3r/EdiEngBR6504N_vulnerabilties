<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/netsys-n.var"></script>
<title>WAN Dynamic IP Setup </title>
<% language=javascript %>
<SCRIPT>
function saveChanges() {
	if (document.tcpip.dynIPHostName.value=="" && document.tcpip.macAddr.value=="" ) {
		if ( document.tcpip.macAddr.value == "" )
			document.tcpip.macAddr.value="000000000000";
		return true;
	}

	var str = document.tcpip.macAddr.value;
	if ( str.length < 12) {
		alert(showText(wandipAlert));
		document.tcpip.macAddr.focus();
		return false;
	}
	
	for (var i=0; i<str.length; i++) {
		if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') || (str.charAt(i) >= 'a' && str.charAt(i) <= 'f') || (str.charAt(i) >= 'A' && str.charAt(i) <= 'F') )
			continue;

		alert(showText(wandipAlert2));
		document.tcpip.macAddr.focus();
		return false;
	}
	return true;
}

function copyto() {
	document.tcpip.macAddr.value=document.tcpip.macAddrValue.value;
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
<p align="center"><b><font class="titlecolor" size="4"><script>dw(DynamicIP)</script></font></b><br><br>
<div align="center">
	<table border="0" width="520" cellspacing="0" cellpadding="0" id="table1">
		<tr>
			<td><font class="textcolor"  size="2">
<span id="genTlId"><script>dw(wandipContent)</script></span></font></td>
		</tr>
	</table>
</div>
</span>

<span id="wizTlId" style="display:none">
<p align="center"><b><font class="titlecolor" size="4"><script>dw(IPAddrInfo)</script></font></b><br><br>
<table border="0" width="520" cellspacing="0" cellpadding="0" align="center"><tr><td>
<p><b><font class="subcolor" size="2"><script>dw(cableModem)</script></font></b></td></tr></table><br>
</span>

<form action=/goform/formWanTcpipSetup method=POST name="tcpip">
<table border="1" cellspacing="0" cellpadding="0" width="520" align="center">

<tr>
<td width="35%" class="table2"><font size=2><script>dw(hostName)</script> :&nbsp;</td>
<td width="65%" class="ltable"><font size=2>
<input type="text" name="dynIPHostName" value="<% getInfo("dynIPHostName"); %>" size="20" maxlength="30"></td>
</tr>

<tr>
<input type=hidden value=<% getInfo("cloneMac"); %> name="macAddrValue">
<td class="table2"><font size=2><script>dw(macAddr)</script> :&nbsp;</td>
<td class="ltable"><input type="text" name="macAddr" value="<% getInfo("wanMac"); %>" size="20" maxlength="12"></td>
</tr>

<tr>
<td class="table2" colspan="2"><script>document.write('<input type="button" value="'+showText(clone)+'" name="Clone" onClick="copyto();" class="btnsize">')</script></td>
</tr>

<tr>
<td class="table2"><font size=2>TTL :&nbsp;</td>
<td class="ltable"><font size=2>&nbsp;<input type="radio" value="0" name="pppEnTtl"<% if (getIndex("pppEnTtl")==0) write("checked"); %>>Disabled&nbsp;&nbsp;
<input type="radio" name="pppEnTtl" value="1"<% if (getIndex("pppEnTtl")==1) write("checked"); %>>Enabled</td></tr>
</table>
<br>

<span id="genBtId">
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td align="right">
	<script>buffer='<input type=submit value="'+showText(apply1)+'" name="save" onclick="return saveChanges();" style ="width:100px">';document.write(buffer);</script>
	<input type=hidden value="/wandip.asp" name="submit-url" id="submitUrl">
	<input type=hidden value="0" name="wanMode">
	<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="document.tcpip.reset();">';document.write(buffer);</script>
</td></tr>
</table>
</span>  

<span id="wizBtId" style="display:none">
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
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
<blockquote>
</body>
</html>


