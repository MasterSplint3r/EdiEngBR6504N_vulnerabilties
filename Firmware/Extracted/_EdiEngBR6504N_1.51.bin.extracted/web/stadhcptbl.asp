<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Active DHCP Client Table</title>
    <script type="text/javascript" src="javascript.js"></script>
    <script type="text/javascript" src="file/statustool-n.var"></script>
</head>
<script>	
</script>
<body class="background">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(statDHCP)</script></font></b><br><br>
<table border=0 width="520" cellspacing="0" cellpadding="0" align="center"><tr><td>
<p><font class="textcolor" size="2"><script>dw(statDHCPDoc)</script></font>
</p></td></tr></table>
<form action=/goform/formReflashClientTbl method=POST name="formClientTbl">
<table border='1' width="520" cellspacing="0" align="center">
<tr class="stable"><td width="30%"><font size=2><b><script>dw(ipAddress)</script></b></td>
<td width="40%"><font size=2><b><script>dw(macAddress)</script></b></td>
<td width="30%"><font size=2><b><script>dw(timeExpired)</script>(s)</b></td></tr>
<% dhcpClientList(); %>
</table>
<input type="hidden" value="/stadhcptbl.asp" name="submit-url">
<p align="center"><script>document.write('<input type="submit" value="'+showText(refresh)+'" name="refresh" class="btnsize">')</script>&nbsp;&nbsp;</p>
</form>
</blockquote>
</body>
</html>
