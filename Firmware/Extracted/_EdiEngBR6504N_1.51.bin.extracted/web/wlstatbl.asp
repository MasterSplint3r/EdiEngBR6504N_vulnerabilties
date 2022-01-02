<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Active Wireless Client Table</title>

<!---------       Added for Multi-language Web Server       --------->
<script language ="javascript" src ="javascript.js"></script>
<script language ="javascript" src ="file/wireless-n.var"></script>

</head>

<body class="background">
<blockquote>
<b><font class="textcolor" size="4"><script>dw(wlAcTble);</script></font></b>

<p align="left"><font class="textcolor" size="2"><script>dw(wlstatblContent)</script></font></p><br>

<form action=/goform/formWirelessTbl method=POST name="formWirelessTbl">
<table border='0' width="468">
<tr class="stable">
<td width="8%"><font size=2><b>AID</b></td>
<td width="19%"><font size=2><b><script>dw(macAddress)</script></b></td>
<td width="20%"><font size="2">802.11 PhyMode</font></td>
<td width="17%"><font size="2">Power Save</font></td>
<td width="14%"><font size=2><b>BandWidth</b></td>
<% 	wirelessClientList(); %>
</tr>
</table>

<input type="hidden" value="/wlstatbl.asp" name="submit-url">
  <p><input type="submit" value="Refresh" name="refresh">&nbsp;&nbsp;
  <!--<input type="button" value=" Close " name="close" onClick="javascript:self.close();">--></p>
</form>
</blockquote>
</body>

</html>