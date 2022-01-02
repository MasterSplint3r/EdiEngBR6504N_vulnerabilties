<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>WAN DNS Setup </title>
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/netsys-n.var"></script>
<script language="JavaScript" src="file/function.js"></script>
<% language=javascript %>
<SCRIPT>
function saveChanges() {
	if (document.tcpip.dns1.value=="" && document.tcpip.dns2.value=="") {
		document.tcpip.dnsMode.value="dnsAuto";
		document.tcpip.dns1.value="0.0.0.0";
		document.tcpip.dns2.value="0.0.0.0";
		
	}	
	else {
		document.tcpip.dnsMode.value="dnsManual";
		if (document.tcpip.dns1.value=="") document.tcpip.dns1.value="0.0.0.0";
		if (document.tcpip.dns2.value=="") document.tcpip.dns2.value="0.0.0.0";
		
		if ( !ipRule( document.tcpip.dns1,showText(dnsAddr1), "gw", 1))
			return false;
		if ( !ipRule( document.tcpip.dns2,showText(dnsAddr2), "gw", 1))
			return false;
	}
   return true;
}
</SCRIPT>
</head>
<body class="background">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(DNS)</script></font></b>
<div align="center">
	<table border="0" width="520" cellspacing="1" id="table1">
		<tr>
			<td><font class="textcolor" size="2"><script>dw(wandnsContent)</script></font></td>
		</tr>
	</table>
</div>
<form action=/goform/formWanTcpipSetup method=POST name="tcpip">

<table border=1 width="520" cellspacing=0 cellpadding=0 align="center">
    <tr>
       <td class="table2" width="60%"><font size=2><script>dw(dnsAddr)</script> :&nbsp;</td>
       <td width="40%" class="ltable"><font size=2><input type="text" name="dns1" size="18" maxlength="15" value=<% getInfo("wan-dns1"); %>></td>
    </tr>
    <tr>
       <td class="table2"width="60%"><font size=2><script>dw(secDnsAddr)</script> :&nbsp;</td>
       <td width="40%" class="ltable"><font size=2><input type="text" name="dns2" size="18" maxlength="15" value=<% getInfo("wan-dns2"); %>></td>
    </tr>
  </table>

<br>
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td align="right">
	<script>buffer='<input type=submit value="'+showText(apply1)+'" name="save" onclick="return saveChanges();" style ="width:100px">';document.write(buffer);</script>
	<input type=hidden value="/wandns.asp" name="submit-url">
	<input type=hidden value="dnsManual" name="dnsMode" >
	<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="document.tcpip.reset();">';document.write(buffer);</script>
</td>
</tr>
</table>
</form>
</blockquote>
</body>
</html>
