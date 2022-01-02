<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>WAN Telstra Big Pond Setup </title>
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/netsys-n.var"></script>
<script language="JavaScript" src="file/function.js"></script>
<% language=javascript %>
<SCRIPT>
function saveChanges()
{
	if (document.tcpip.telBPEnabled.checked) {
		if ( !ipRule( document.tcpip.telBPIPAddr, showText(IPAddr), "ip", 1))
			return false;
	}
	if (!strRule(document.tcpip.telBPUserName, showText(telUserName)))
		return false;
	if (!strRule(document.tcpip.telBPPassword, showText(telPass)))
		return false;
   return true;
}

function updateState() {
	if (document.tcpip.telBPEnabled.checked)
		document.tcpip.telBPIPAddr.disabled=false;
	else 
		document.tcpip.telBPIPAddr.disabled=true;
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
<p align="center"><b><font class="titlecolor" size="4"><script>dw(TelstraBigPond)</script></font></b><br><br>
<table border=0 width="520" align="center" cellspacing=0 cellpadding=0><tr><td>
<p align="left"><font class="textcolor"  size="2"><script>dw(wantelstraPageContent)</script></font></p></td></tr></table><br>
</span>
       
<script>
if (wizardEnabled == 1)
	document.write('<span style="display:block">');
else
	document.write('<span style="display:none">');
</script>
<p align="center"><font class="titlecolor" size="4"><b><script>dw(IPAddrInfo)</script></b></font><br><br>
<table border=0 width="520" align="center" cellspacing=0 cellpadding=0><tr><td>
<p><b><font class="subcolor" size="2"><script>dw(TelstraBigPond)</script></font></b><br>
<font class="textcolor"  size="2"><script>dw(wantelstraPageContent)</script></font></p></td></tr></table><br>
</span>

<form action=/goform/formTELBPSetup method=POST name="tcpip">
<table border=1 width="520" align="center" cellspacing=0 cellpadding=0>
<tr class="table2">
<td width="35%"><font size=2><script>dw(userName)</script> :&nbsp;</td>
<td width="65%" align="left">&nbsp;<input type="text" name="telBPUserName" size="20" maxlength="64" value="<% getInfo("telBPUserName"); %>"></td>
</tr>

<tr class="table2">
<td><font size=2><script>dw(password)</script> :&nbsp;</b></td>
<td align="left">&nbsp;<input type="password" name="telBPPassword" size="20" maxlength="64" value="<% getInfo("telBPPassword"); %>"></td>
</tr>

<tr class="lstable"><td colspan="2"><font size=2><b>
<input type="checkbox" name="telBPEnabled" value="ON" <% if (getIndex("telBPEnabled")) write("checked"); %> onClick="updateState();"><font size="2" class="textcolor">&nbsp;&nbsp;<script>dw(userLogin)</script></font></b><br></td>
</tr>

<tr class="table2">
<td><font size=2><script>dw(loginServer)</script> :&nbsp;</td>
<td align="left">&nbsp;<input type="text" name="telBPIPAddr" size="15" maxlength="15" value="<% getInfo("telBPIPAddr"); %>"></td>
</tr>
 <script> updateState(); </script>
 </table>
</p>
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
	<script>buffer='<input type=submit value="'+showText(apply1)+'" name="B1" onclick="return saveChanges()" style ="width:100px">';document.write(buffer);</script>
	<input type=hidden value="/wantelstra.asp" name="submit-url" id="submitUrl">
	<input type=hidden value="4" name="wanMode">
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
