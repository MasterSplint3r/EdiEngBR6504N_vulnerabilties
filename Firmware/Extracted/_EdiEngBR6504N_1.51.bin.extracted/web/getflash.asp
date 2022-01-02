<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Hardware Setting</title>
</head>
<body class="background">
<blockquote>
<table border="1" cellspacing="0" width="540" align="center">

<tr>
<td class="ltable"><font size=2>Model :&nbsp;</td>
<td class="table2"><font size=2>&nbsp;<% getInfo("modelname"); %></td>
</tr>

<tr>
<td class="ltable"><font size=2>Module :&nbsp;</td>
<td class="table2"><font size=2>&nbsp;<% getInfo("modulename"); %></td>
</tr>

<tr>
<td class="ltable"><font size=2>F/W Version&nbsp;</td>
<td class="table2"><font size=2>&nbsp;<% getInfo("fwVersion"); %></td>
</tr>

<tr>
<td class="ltable" width="35%"><font size=2>Regulation domain :&nbsp;</td>
<td class="table2" width="65%"><font size=2><select name="regDomain">
<script>
var domainTbl = new Array("FCC 1-11(U.S.)", "DOC 1-11(Canada)", "ETST 1-13(Europe)", "SPAIN 10-11(Spain)", "FRANCE 10-13(France)", "MKK 1-14(Japan)");
	
	<% write("Domain = "+getIndex("regDomain"));%>
	
	for (i=1; i<=6; i++) {
		if ( i == Domain) {
			document.write('<option selected value="'+(i)+'">'+domainTbl[i-1]+'</option>');
		}
		else {
			document.write('<option value="'+(i)+'">'+domainTbl[i-1]+'</option>');
		}
	}
</script>
</tr>

<tr>
<td class="ltable"><font size=2>NIC0 address :&nbsp;</td>
<td class="table2"><font size=2><input type="text" name="nic0Addr" size="20" maxlength="12" value="<% getInfo("nic0mac"); %>"></td>
</tr>

<tr>
<td class="ltable"><font size=2>NIC1 address :&nbsp;</td>
<td class="table2"><font size=2><input type="text" name="nic1Addr" size="20" maxlength="12" value="<% getInfo("nic1mac"); %>"></td>
</tr>

<tr>
<td class="ltable"><font size=2>WLAN address :&nbsp;</td>
<td class="table2"><font size=2><input type="text" name="wlanAddr" size="20" maxlength="12" value="<% getInfo("wlmac"); %>"></td>
	</tr>



<tr>
<td class="ltable"><font size=2>WLAN SSID :&nbsp;</td>
<td class="table2"><font size=2>
<input type="text" name="ssid" size="20" maxlength="12" value="<% getInfo("ssid"); %>">
</td>
</tr>

<tr>
<td class="ltable"><font size=2>WLAN CHANNEL :</td>
<td class="table2"><font size=2>&nbsp;<script>
			<% write("defaultChan = "+getIndex("channel"));%>
			document.write( '<input type="text" name="tx2Gain" size="20" maxlength="12" value="'+defaultChan+'">');
</script></td>
</tr>

<tr>
<td class="ltable"><font size="2">TX1Gain:</font></td>
<td class="table2"><font size="2">

<input type="text" name="tx1Gain" size="45" maxlength="24" value="<% getInfo("tx1Gain"); %>">

</font></td>
</tr>
<tr>
<td class="ltable"><font size="2">TX2Gain:</font></td>
<td class="table2"><font size="2">
<input type="text" name="tx2Gain" size="45" maxlength="24" value="<% getInfo("tx2Gain");%>">
</font></td>
</tr>
<tr>
<td class="ltable"><font size="2">E2P[DEh]:</font></td>
<td class="table2"><font size="2">
<input type="text" name="e2pDE" size="20" maxlength="12" value="<% getInfo("e2pDE");%>">
</font></td>
</tr>
<tr>
<td class="ltable"><font size="2">E2P[E2h]:</font></td>
<td class="table2"><font size="2">
<input type="text" name="e2pE2" size="20" maxlength="12" value="<% getInfo("e2pE2");%>">
</font></td>
</tr>
<tr>
<td class="ltable"><font size="2">E2P[EBh]:</font></td>
<td class="table2"><font size="2">
<input type="text" name="e2pEB" size="20" maxlength="12" value="<% getInfo("e2pEB");%>">
</font></td>
</tr>
</table>
</blockquote>
</body>
</html>

