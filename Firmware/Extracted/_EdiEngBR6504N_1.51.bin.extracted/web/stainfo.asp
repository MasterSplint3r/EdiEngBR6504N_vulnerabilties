<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Access Point Status</title>
    <script type="text/javascript" src="javascript.js"></script>
    <script type="text/javascript" src="file/statustool-n.var"></script>
</head>
<script>
	
</script>
<body class="background">
<p align="center"><b><font class="titlecolor" size="4"><script>dw(sta2info)</script></font></b></p>
	<table border="0" width="520" cellspacing="0" cellpadding="0" id="table1" align="center">
		<tr>
			<td><font class="textcolor"  size="2"><script>dw(statInfoDoc)</script></font></td>
		</tr>
	</table><br>
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
  <tr class="stable">
    <td align="center" colspan="2"><font size="2"><b><script>dw(system)</script></b></font></td>
  </tr>
  <tr class="table2">
    <td width=50% align="center"><font size=2><script>dw(model)</script></td>
    <td width=50%><font size=2>&nbsp;<% getInfo("name"); %></td>
  </tr>
  <tr class="table2">
    <td align="center"><font size=2><script>dw(upTime)</script></td>
    <td><font size=2>&nbsp;<% getInfo("uptime"); %></td>
  </tr>
  <tr class="table2">
    <td align="center"><font size=2><script>dw(verHardware)</script></td>
    <td><font size=2 >&nbsp;Rev. A</td>
  </tr>
<!--  <tr class="table2">
    <td align="center"><font size=2>Serial Number&nbsp;</td>
    <td><font size=2 >&nbsp;</td>
  </tr>-->
  <tr class="table2">
    <td align="center"><font size=2><script>dw(verBootCode)</script></td>
    <td><font size=2 >&nbsp;1.0</td>
  </tr>
  <tr class="table2">
    <td align="center"><font size=2><script>dw(verRuntimeCode)</script></td>
    <td><font size=2>&nbsp;<% getInfo("fwVersion"); %></td>
  </tr>
</table>
</body>
</html>
