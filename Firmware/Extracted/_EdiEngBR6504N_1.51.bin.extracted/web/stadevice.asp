<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Access Point Status</title>
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/statustool-n.var"></script>
</head>
<body class="background">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(statDevice)</script></font></b>
<p align="center"><font class="textcolor" size="2"><script>dw(statDeviceDoc)</script><br></font></p>
<form name="DevSta">
<table width=540 border="1" cellspacing="0" align="center">
<tr>
<td colspan="2" class="stable"><font size=2><script>dw(cfgWireless)</script></font></td></tr>
<tr class="table2">
<td><font size=2>&nbsp;<script>dw(mode)</script></td><td width=60%><font size=2>&nbsp;
<script>
<%  write("apMode = "+getIndex("apMode")+";");%>
var modeTbl = new Array("AP","Station-Ad Hoc","Station-Infrastructure","AP Bridge-Point to Point","AP Bridge-Point to Multi-Point","AP Bridge-WDS","Universal Repeater");
	for (i=0 ; i<7 ; i++) {
		if ( i==apMode )
			document.write(modeTbl[i]);
	}
</script>
</td></tr>
	
<tr class="table2">
<td><font size=2>&nbsp;<script>dw(essid)</script></td>
<td><font size=2>&nbsp;<% getInfo("ssid_drv"); %></td></tr>
	
<tr class="table2">
<td><font size=2>&nbsp;<script>dw(channelNum)</script></td>
<td><font size=2>&nbsp;<% getInfo("channel_drv"); %></td></tr>
	
<tr class="table2">
<td><font size=2>&nbsp;<script>dw(security)</script></td>
<td width=60%><font size=2>&nbsp;
<script>
<%  write("encrypt = "+getIndex("encrypt")+";");%>
<%  write("wep = "+getIndex("wep")+";");%>
	var modeTbl = new Array("Disable","WEP","WPA pre-shared key","WPA RADIUS");
	for (i=0 ; i<6 ; i++) {
		if ( i == encrypt )
			document.write(modeTbl[i] +"</td>");
	}
	document.write('</tr>');

//	if (apMode == 0 || apMode == 5) {
//		document.write('<tr class="table2"><td><font size=2>&nbsp;Associated Clients</td>');
//		document.write('<td><font size=2>&nbsp;<% getInfo("clientnum"); %></td></tr>');
//	}
//	if (apMode == 1 || apMode == 2) {
//		document.write('<tr class="table2"><td><font size=2><b>&nbsp;State</b></td>');
//		document.write('<td><font size=2>&nbsp;<% getInfo("state_drv"); %></td></tr>');
//	}
</script>
<tr>
	<td colspan="2" class="stable"><font size=2><script>dw(cfgLAN)</script></font></td>
</tr>
<tr class="table2">
	<td><font size=2>&nbsp;<script>dw(ipAddress)</script></td>
	<td><font size=2>&nbsp;<% getInfo("ip"); %></td>
</tr>
<tr class="table2">
	<td><font size=2>&nbsp;<script>dw(subnetMask)</script></td>
	<td><font size=2>&nbsp;<% getInfo("mask"); %></td>
</tr>
<tr class="table2">
	<td><font size=2>&nbsp;<script>dw(DhcpServer)</script></td>
	<td><font size=2>&nbsp;<%  choice = getIndex("dhcp-current");
		if ( choice == 0 ) write( "<script>dw(disable)</script>" );
		if ( choice == 2 ) write( "<script>dw(enable)</script>" );
	%></td>
</tr>
<tr class="table2">
	<td><font size=2>&nbsp;<script>dw(macAddress)</script></td>
	<td><font size=2>&nbsp;<% getInfo("hwaddr"); %></td>
</tr>
</table>
</form>
</blockquote>
</body>
</html>
