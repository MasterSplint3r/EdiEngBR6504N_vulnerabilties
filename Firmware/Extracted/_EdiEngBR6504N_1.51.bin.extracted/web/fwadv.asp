<html><head><title></title>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script language ='javascript' src ='javascript.js'></script>
<script language ='javascript' src ='file/fwwl-n.var'></script>
<script language="JavaScript">
function validateNum(str)
{
  for (var i=0; i<str.length; i++) {
   	if ( !(str.charAt(i) >='0' && str.charAt(i) <= '9')) {
		alert(showText(fwadvInvValue));
		return false;
  	}
  }
  return true;
}

function saveChanges()
{
	strpodPack = document.DoS.podPack;
	strpodBur = document.DoS.podBur;
	strsynPack = document.DoS.synPack;
	strsynBur = document.DoS.synBur;

if (document.DoS.podEnable.checked) {
	if ( validateNum(strpodPack.value) == 0 ) {
		setFocus(strpodPack);
		return false;
	}
	num = parseInt(strpodPack.value);
	if (strpodPack.value == "" || num < 0 || num > 255) {
		alert(showText(fwadvInvPacket));
		setFocus(strpodPack);
		return false;
	}
	if ( validateNum(strpodBur.value) == 0 ) {
		setFocus(strpodBur);
		return false;
	}
	num = parseInt(strpodBur.value);
	if (strpodBur.value == "" || num < 0 || num > 255) {
		alert(showText(fwadvInvBurst));
		setFocus(strpodBur);
		return false;
	}
}

if (document.DoS.synEnable.checked) {
	if ( validateNum(strsynPack.value) == 0 ) {
		setFocus(strsynPack);
		return false;
	}
	num = parseInt(strsynPack.value);
	if (strsynPack.value == "" || num < 0 || num > 255) {
		alert(showText(fwadvInvPacketSync));
		setFocus(strsynPack);
		return false;
	}
	if ( validateNum(strsynBur.value) == 0 ) {
		setFocus(strsynBur);
		return false;
	}
	num = parseInt(strsynBur.value);
	if (strsynBur.value == "" || num < 0 || num > 255) {
		alert(showText(fwadvInvBurstSync));
		setFocus(strsynBur);
		return false;
	}
}
if (document.DoS.scanEnable.checked) {
	var longVal=0;
	if (document.DoS.Index0.checked==true)	longVal |= 0x001;
	if (document.DoS.Index1.checked==true)	longVal |= 0x002;
	if (document.DoS.Index2.checked==true)	longVal |= 0x004;
	if (document.DoS.Index3.checked==true)	longVal |= 0x008;
	if (document.DoS.Index4.checked==true)	longVal |= 0x010;
	if (document.DoS.Index5.checked==true)	longVal |= 0x020;
	if (document.DoS.Index6.checked==true)	longVal |= 0x040;
	document.DoS.scanNumVal.value=longVal;
}
	return true;
}

function ItemEnable() {
	if (!document.DoS.podEnable.checked) {
		document.DoS.podPack.disabled = true;
		document.DoS.podBur.disabled = true;
		document.DoS.podTime.disabled = true;
	}
	else {
		document.DoS.podPack.disabled = false;
		document.DoS.podBur.disabled = false;
		document.DoS.podTime.disabled = false;
	}
	if (!document.DoS.synEnable.checked) {
		document.DoS.synPack.disabled = true;
		document.DoS.synBur.disabled = true;
		document.DoS.synTime.disabled = true;
	}
	else {
		document.DoS.synPack.disabled = false;
		document.DoS.synBur.disabled = false;
		document.DoS.synTime.disabled = false;
	}
	if (!document.DoS.scanEnable.checked) {
		document.DoS.Index0.disabled = true;
		document.DoS.Index1.disabled = true;
		document.DoS.Index2.disabled = true;
		document.DoS.Index3.disabled = true;
		document.DoS.Index4.disabled = true;
		document.DoS.Index5.disabled = true;
		document.DoS.Index6.disabled = true;
	}
	else {
		document.DoS.Index0.disabled = false;
		document.DoS.Index1.disabled = false;
		document.DoS.Index2.disabled = false;
		document.DoS.Index3.disabled = false;
		document.DoS.Index4.disabled = false;
		document.DoS.Index5.disabled = false;
		document.DoS.Index6.disabled = false;
	}
}
</script></head>
<body class="background">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(fwDos);</script></font></b>
<form action=/goform/formPreventionSetup method=POST name="DoS">
<table border=0 width="520" cellspacing=0 cellpadding=0 align=center>
<tr><td><font class="textcolor"  size="2"><script>dw(fwDosInfo);</script><br></font></td></tr>
</table><br>
<table border=1 width="520" cellspacing=0 cellpadding=0 align=center>
<tr class="stable"><td colspan="2" align="left"><font size="2"><script>dw(fwDosFeature);</script></font></td></tr>

<input type="hidden" value="<% getInfo("scanNum"); %>" name="scanNumVal">
<tr>
<td class="table3" width="35%">
<input type="checkbox" name="podEnable" value="ON" <% if (getIndex("podEnable")==1) write("checked"); %> onClick="ItemEnable();">&nbsp;&nbsp;
<font size="2"><script>dw(fwDosDeath);</script> :&nbsp;</font></td>

<td class="table3" width="65%">
<input type="text" name="podPack" size="3" maxlength="3" value="<% getInfo("podPack"); %>">
<font size="2"><script>dw(fwadvPacket);</script></font>

&nbsp;&nbsp;<font size="2"><script>dw(fwadvPer);</script></font>
<select name="podTime">
<script>
var TimeTbl = new Array("Second","Minute","Hour");
<%	write("podTimeVal = "+getIndex("podTime"));%>
for ( i=0; i<=2; i++) {
	if (i == podTimeVal)
		document.write('<option selected value="'+i+'">'+TimeTbl[i]+'</option>');
	else
		document.write('<option value="'+i+'">'+TimeTbl[i]+'</option>');
}
</script></select>

&nbsp;&nbsp;<font size="2"><script>dw(fwadvBurst);</script></font>
<input type="text" name="podBur" size="3" maxlength="3" value="<% getInfo("podBur"); %>">
</td></tr>

<tr>
<td class="table3">
<input type="checkbox" name="pingEnable" value="ON" <% if (getIndex("pingEnable")==1) write("checked"); %>>
<font size="2"><script>dw(fwDosPing);</script> :&nbsp;</font>
<td class="table3" align="center">&nbsp;</td>
</tr>

<tr>
<td class="table3" valign="top">
<input type="checkbox" name="scanEnable" value="ON" <% if (getIndex("scanEnable")==1) write("checked"); %> onClick="ItemEnable();">
<font size="2"><script>dw(fwDosScan);</script> :&nbsp;</font></td>
<td class="table3">
<script>
var scanTbl = new Array("NMAP FIN / URG / PSH","Xmas tree","Another Xmas tree","Null scan","SYN / RST","SYN / FIN","SYN (only unreachable port)");
var val=0x001;
for(i=0; i<=6; i++){
	if (document.DoS.scanNumVal.value & val) 
		document.write('<input type="checkbox" name="Index'+i+'" checked>');
	else
		document.write('<input type="checkbox" name="Index'+i+'">');
	document.write('<font size=2>' + scanTbl[i] + '</font><br>');
	val *=2;
}
</script>
</td></tr>

<tr>
<td class="table3" width="40%">&nbsp;<input type="checkbox" name="synEnable" value="ON" <% if (getIndex("synEnable")==1) write("checked"); %> onClick="ItemEnable();">&nbsp;&nbsp;
<font size="2"><script>dw(fwDosSync);</script> :&nbsp;</font></td>

<td class="table3" width="60%">
<input type="text" name="synPack" size="3" maxlength="3" value="<% getInfo("synPack"); %>">
<font size="2"><script>dw(fwadvPacket);</script></font>

&nbsp;&nbsp;<font size="2"><script>dw(fwadvPer);</script></font>
<select name="synTime">
<script>
<%	write("synTimeVal = "+getIndex("synTime"));%>
for ( i=0; i<=2; i++) {
	if (i == synTimeVal)
		document.write('<option selected value="'+i+'">'+TimeTbl[i]+'</option>');
	else
		document.write('<option value="'+i+'">'+TimeTbl[i]+'</option>');
}
</script></select>

&nbsp;&nbsp;<font size="2"><script>dw(fwadvBurst);</script></font>
<input type="text" name="synBur" size="3" maxlength="3" value="<% getInfo("synBur"); %>">
</td></tr>
<script>
ItemEnable();
</script>
</table>
<br>
<table width="560" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td align="right">
		<script>document.write('<input type=submit value="'+showText(apply1)+'" name="B1" style ="width:100px" onClick="return saveChanges()">');</script>
		<input type=hidden value="/fwdos.asp" name="submit-url">
		<script>;document.write('<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="document.DoS.reset();">');</script>
	</td>
</tr>
</table>
</form>
</blockquote>
</body></html>
