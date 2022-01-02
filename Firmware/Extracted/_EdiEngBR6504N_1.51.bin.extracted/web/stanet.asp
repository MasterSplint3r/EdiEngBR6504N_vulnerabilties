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
<p align="center"><b><font class="titlecolor" size="4"><script>dw(statInternet)</script></font></b>
<p align="center"><font class="textcolor"  size="2"><script>dw(statInternetDoc)</script><br></font></p>
<form name="internetSta">
<table width=540 border="1" cellspacing="0" align="center">
  <tr>
    <td class="table2" width="40%"><font size=2><script>dw(attainIpPtc)</script> :&nbsp;</td>
    <td class="table2"><font size=2>&nbsp;<% getInfo("sta-current"); %></td>
	<input type="hidden" name="ip" value="<% getInfo("sta-ip"); %>">
	<input type="hidden" name="dns1" value="<% getInfo("sta-dns1"); %>">
	<input type="hidden" name="dns2" value="<% getInfo("sta-dns2"); %>">
	<input type="hidden" name="gw" value="<% getInfo("sta-gateway"); %>">
  </tr>
  <tr>
    <td class="table2"><font size=2><script>dw(ipAddress)</script> :&nbsp;</td>
    <td class="table2"><font size=2>&nbsp;<% getInfo("sta-ip"); %></td>
  </tr>
  <tr>
    <td class="table2"><font size=2><script>dw(subnetMask)</script> :&nbsp;</td>
    <td class="table2"><font size=2>&nbsp;<% getInfo("sta-mask"); %></td>
  </tr>
  <tr>
    <td class="table2"><font size=2><script>dw(defaultGateway)</script> :&nbsp;</td>
	<td class="table2"><script>
	var check = document.internetSta.ip.value;
	if ( check != "") 
		document.write('<font size=2>&nbsp;'+document.internetSta.gw.value);
	else
		document.write('<font size=2>&nbsp;</td>');
</script>
  </tr>
  <tr>
    <td class="table2"><font size=2><script>dw(macAddress)</script> :&nbsp;</td>
    <td class="table2"><font size=2>&nbsp;<% getInfo("sta-mac"); %></td>
  </tr>
  <tr>
    <td class="table2"><font size=2><script>dw(primaryDNS)</script> :&nbsp;</td>
	<td class="table2"><script>
	if ( check != "")
    	document.write('<font size=2>&nbsp;'+document.internetSta.dns1.value);
	else
    	document.write('<font size=2>&nbsp;');
</script></td>
  </tr>
  <tr>
    <td class="table2"><font size=2><script>dw(secondaryDNS)</script> :&nbsp;</td>
	<td class="table2"><script>
	if ( check != "")
	    document.write('<font size=2>&nbsp;'+document.internetSta.dns2.value);
	else
	    document.write('<font size=2>&nbsp;');
</script></td>
  </tr>
</table>
</form>
</blockquote>
</body>
</html>
