<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset =utf-8">
<title>WDS AP Table</title>
<script language ="javascript" src ="javascript.js"></script>
<script language ="javascript" src ="file/wireless-n.var"></script>
</head>

<body class="background">
<table border='0' width="520" align="center" cellspacing="0" cellpadding="0">
	<tr><td>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(wlWdsTbl)</script></font></b></p>
<p align="left"><font class="textcolor" size="2"><script>dw(wlwdstblContent)</script></font></p>
</td></tr></table>

<form action=/goform/formWirelessTbl method=POST name="formWirelessTbl">
<table border='1' width="520" align="center" cellspacing="0" cellpadding="0">
<tr class='stable'><td width="30%" align=center><font size=2><b><script>dw(macAddress)</script></b></td>
<td width="15%" align=center><font size=2><b><script>dw(txPacket)</script></b></td>
<td width="15%" align=center><font size=2><b><script>dw(txError)</script></b></td>
<td width="15%" align=center><font size=2><b><script>dw(rxPacket)</script></b></td>
<td width="25%" align=center><font size=2><b><script>dw(txRate)</script> (Mbps)</b></td></tr>
<% wdsList(); %>
</table><br>
<table border='0' width="520" align="center" cellspacing="0" cellpadding="0">
	<tr><td align="right">
<input type="hidden" value="/wlwdstbl.asp" name="submit-url">
  <p><script>document.write('<input type="submit" value="'+showText(refresh)+'" name="refresh" class="btnsize">')</script>&nbsp;&nbsp;
  <script>document.write('<input type="button" value="'+showText(close)+'" name="close" onClick="window.close();" class="btnsize">')</script></p>
</td></tr></table>
</form>
</body>

</html>
