<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Access Control Add PC</title>
<script language ='javascript' src ='javascript.js'></script>
<script language ='javascript' src ='file/fwwl-n.var'></script>
<script language="JavaScript" src="file/function.js"></script>
<script>
var nameTbl = new Array(16);
nameTbl[0] = "WWW";
nameTbl[1] = "E-mail Sending";
nameTbl[2] = "News Forums";
nameTbl[3] = "E-mail Receiving";
nameTbl[4] = "Secure HTTP";
nameTbl[5] = "File Transfer";
nameTbl[6] = "MSN Messenger";
nameTbl[7] = "Telnet Service";
nameTbl[8] = "AIM";
nameTbl[9] = "NetMeeting";
nameTbl[10] = "DNS";
nameTbl[11] = "SNMP";
nameTbl[12] = "VPN-PPTP";
nameTbl[13] = "VPN-L2TP";
nameTbl[14] = "TCP";
nameTbl[15] = "UDP";

var desTbl = new Array(16);
desTbl[0] = "HTTP, TCP Port 80, 3128, 8000, 8080, 8081";
desTbl[1] = "SMTP, TCP Port 25";
desTbl[2] = "NNTP, TCP Port 119";
desTbl[3] = "POP3, TCP Port 110";
desTbl[4] = "HTTPS, TCP Port 443";
desTbl[5] = "FTP, TCP Port 21";
desTbl[6] = "TCP Port 1863";
desTbl[7] = "TCP Port 23";
desTbl[8] = "AOL Instant Messenger, TCP Port 5190";
desTbl[9] = "H.323, TCP Port 389,522,1503,1720,1731";
desTbl[10] = "UDP Port 53";
desTbl[11] = "UDP Port 161, 162";
desTbl[12] = "TCP Port 1723";
desTbl[13] = "UDP Port 1701";
desTbl[14] = "All TCP Port";
desTbl[15] = "All UDP Port";

function checkValue(str) {
   for (var i=0; i<str.length; i++) {
    if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
    		(str.charAt(i) == ',' ) || (str.charAt(i) == '-' ))
			continue;
	return 0;
  }
  return 1;
}

function addClick() {
	if (document.formFilterAdd.sipaddr.value=="") {
		alert(showText(fwaddpcAlertIpEmpty));
		document.formFilterAdd.sipaddr.value = document.formFilterAdd.sipaddr.defaultValue;
		document.formFilterAdd.sipaddr.focus();
		return false;
	}
	if ( checkIpAddr(document.formFilterAdd.sipaddr, showText(fwaddpcStrInvIpStart)) == false )
    	return false;
	if (document.formFilterAdd.eipaddr.value!="") {
		if ( checkIpAddr(document.formFilterAdd.eipaddr, showText(fwaddpcStrInvIpEnd)) == false )
    		return false;
	}
//--------------------------------------------------------------------------------------------
//  if (!document.formFilterAdd.enabled.checked)
//  	return true;
  
	var longVal=0;
	with (document.formFilterAdd ) {
		if (Index0.checked==true)	longVal |=0x0001;
		if (Index1.checked==true)	longVal |=0x0002;
		if (Index2.checked==true)	longVal |=0x0004;
		if (Index3.checked==true)	longVal |=0x0008;
		if (Index4.checked==true)	longVal |=0x0010;
		if (Index5.checked==true)	longVal |=0x0020;
		if (Index6.checked==true)	longVal |=0x0040;
		if (Index7.checked==true)	longVal |=0x0080;
		if (Index8.checked==true)	longVal |=0x0100;
		if (Index9.checked==true)	longVal |=0x0200;
		if (Index10.checked==true)	longVal |=0x0400;
		if (Index11.checked==true)	longVal |=0x0800;
		if (Index12.checked==true)	longVal |=0x1000;
		if (Index13.checked==true)	longVal |=0x2000;
		if (Index14.checked==true)	longVal |=0x4000;
		if (Index15.checked==true)	longVal |=0x8000;
	}
	document.formFilterAdd.serindex.value=longVal;
	if ( checkValue( document.formFilterAdd.Port.value ) == 0 ) {
		alert(showText(fwaddpcAlertInvPort));
		document.formFilterAdd.Port.focus();
		return false;
	}
 return true;
}

function disableDelButton() {
	document.formFilterDel.deleteSelFilterIp.disabled = true;
	document.formFilterDel.deleteAllFilterIp.disabled = true;
}
</script>
</head>
<body class="background" topmargin="10">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(fwAccAdd);</script></font></b></p>

<table border=0 width="520" cellspacing=0 cellpadding=0 align="center">
<tr><td><font class="textcolor"  size="2"><script>dw(fwAccAddInfo);</script><br></font></td></tr>
</table><br>
<table border=1 width="520" cellspacing=0 cellpadding=0 align="center">
<form action=/goform/formFilter method=POST name="formFilterAdd">
<input type="hidden" name="enabled" value="<% if (getIndex("ACPCEnabled")) write("ON");%>">
<!--
<tr><td><font size=2><b>
   	<input type="checkbox" name="enabled" value="ON" <% if (getIndex("ACPCEnabled")) write("checked");
   	%> ONCLICK=updateState()>&nbsp;&nbsp;Enable IP Filtering</b><br>
    </td>
</tr>
-->
<tr>
   <td class="table2" width="30%"><font size=2><script>dw(clientPcDescription);</script> :&nbsp;</td>
   <td class="table2">&nbsp;<input type="text" name="comment" size="20" maxlength="16"></td></li>
</tr>
<tr>
   <td class="table2"><font size=2><script>dw(clientPcIpAddress);</script> :&nbsp;</td>
   <td class="table2">&nbsp;<input type="text" name="sipaddr" size="15" maxlength="15">&nbsp;<b>-</b>&nbsp;
   <input type="text" name="eipaddr" size="15" maxlength="15"></td>
</tr>
<table border=1 width="520" cellspacing=0 cellpadding=0 align="center">
<br>
<tr height="25" class="ltable"><td colspan="3"><font size=2 class="textcolor">&nbsp;<script>dw(clientPcService);</script> :</td></tr>
<tr class="stable">
<td width="30%"><font size=2><script>dw(serviceName);</script></font></td>
<td width="55%"><font size=2><script>dw(detailDescription);</script></font></td>
<td width="15%"><font size=2><script>dw(select);</script></font></td>
</tr>
<script>
for(i=0;i<16;i++){
	document.write("<tr class=table1 align=center>");
	document.write("<td><font size=2>" + nameTbl[i] + "</font></td>");
	document.write("<td><font size=2>" + desTbl[i] + "</font></td>");
	document.write("<td><input type=\"checkbox\" name=\"Index"+i+"\"></td></tr>");
}
</script>
</table>
<br>
<table border=1 width="520" cellspacing=0 cellpadding=0 align="center">
<tr class="stable">
<td colspan="2"><font size=2><script>dw(usrDefineService);</script></font></td></tr>
<tr class="table2">
<td align="left"><font size=2>&nbsp;<script>dw(protocol);</script> :</td>
<td align="left"><select name="protocol">
    <option selected value="0"><script>dw(botholitec);</script></option>
    <option value="1">TCP</option>
    <option value="2">UDP</option>
    </select></font>&nbsp;&nbsp;</td>
</tr>
<tr class="table2">
<td align="left"><font size=2>&nbsp;<script>dw(portRange);</script>:</font></td>
<td align="left">
<input type="text" name="Port" size="60" maxlength="59">
</td>
</tr>
<tr class="stable"><td colspan="2" align="right">
	<script>document.write('<input type="submit" class="btnsize" value="'+showText(add)+'" name="addACPC" onClick="return addClick()">');</script>
	<script>document.write('<input type="reset" class="btnsize" value="'+showText(reset)+'" name="reset">');</script>
	<input type="hidden" value="/fwcontrol.asp" name="submit-url">
	<input type="hidden" name="serindex">
   </td></tr>
</form>
</table>
</blockquote>
</body>
</html>
