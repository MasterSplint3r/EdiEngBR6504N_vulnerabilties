<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Hardware Setting</title>
<script language="JavaScript" src="file/function.js"></script>
<script>
function saveChanges() {
	if (document.hwset.nic0Addr.value != "") {
		if (!macRule(document.hwset.nic0Addr, "NIC0 address", 1))
			return false;
	}
	if (document.hwset.nic1Addr.value != "") {
		if (!macRule(document.hwset.nic1Addr, "NIC1 address", 1))
			return false;
	}
	if (document.hwset.wlanAddr.value != "") {
		if (!macRule(document.hwset.wlanAddr, "WLAN address", 1))
			return false;
	}
  return true;
}
</script>
</head>
<body class="background">
<blockquote>
<form action=/goform/formHwSet method=POST name="hwset">
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
<td class="table2" width="65%"><font size=2>&nbsp;<select name="regDomain">
<script>
var domainTbl = new Array("FCC 1-11(U.S.)", "DOC 1-11(Canada)", "ETST 1-13(Europe)", "SPAIN 10-11(Spain)", "FRANCE 10-13(France)", "MKK 1-14(Japan)");
	for (i=0; i<=5; i++)
		document.write('<option value="'+(i+1)+'">'+domainTbl[i]+'</option>');
</script>
</tr>

<tr>
<td class="ltable"><font size=2>NIC0 address :&nbsp;</td>
<td class="table2"><font size=2>&nbsp;<input type="text" name="nic0Addr" size="20" maxlength="12"></td>
</tr>

<tr>
<td class="ltable"><font size=2>NIC1 address :&nbsp;</td>
<td class="table2"><font size=2>&nbsp;<input type="text" name="nic1Addr" size="20" maxlength="12"></td>
</tr>

<tr>
<td class="ltable"><font size=2>WLAN address :&nbsp;</td>
<td class="table2"><font size=2>&nbsp;<input type="text" name="wlanAddr" size="20" maxlength="12"></td>
</tr>

<tr>
<td class="ltable"><font size=2>WAN IP Address :&nbsp;</td>
<td class="table2"><font size=2>&nbsp;<input type="text" name="wanAddr" size="20" maxlength="15"></td>
</tr>

<tr>
<td class="ltable"><font size=2>WLAN SSID :&nbsp;</td>
<td class="table2"><font size=2>&nbsp;<input type="text" name="wlanSSID" size="20" maxlength="30"></td>
</tr>

<tr>
<td class="ltable"><font size=2>WLAN CHANNEL :&nbsp;</td>
<td class="table2"><font size=2>&nbsp;<input type="text" name="wlanChan" size="20" maxlength="30"></td>
</tr>

</table>
<br>
<table width="540" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td align="right">
<input type="submit" value="Save Changes" name="save" onClick="return saveChanges()" width="105">
<input type=hidden value="/flash.asp" name="submit-url">
<input type=hidden value="no" name="isReboot">
</td></tr>
</table>
</form>
</blockquote>
</body>
</html>


