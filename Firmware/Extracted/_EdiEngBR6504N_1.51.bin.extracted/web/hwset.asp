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
<p align="center"><b><font class="titlecolor" size="4">Hardware settings</font></b></p>
<p align="center"><font class="textcolor" size="2">
The page can set hardware configuration.
These settings are only for more technically<br>advanced users. 
These settings should not be changed under general condition.
<br></font></p><br>
<form action=/goform/formHwSet method=POST name="hwset">
 <table border="1" cellspacing="0" width="540" align="center">
<tr>
<td class="table2" width="35%"><font size=2>Regulation domain :&nbsp;</td>
<td class="ltable" width="65%"><font size=2>&nbsp;<select name="regDomain">
<script>
var domainTbl = new Array("FCC 1-11(U.S.)", "DOC 1-11(Canada)", "ETST 1-13(Europe)", "SPAIN 10-11(Spain)", "FRANCE 10-13(France)", "MKK 1-14(Japan)");
	for (i=0; i<=5; i++)
		document.write('<option value="'+(i+1)+'">'+domainTbl[i]+'</option>');
</script>
</tr>

<tr>
<td class="table2"><font size=2>NIC0 address :&nbsp;</td>
<td class="ltable"><font size=2>&nbsp;<input type="text" name="nic0Addr" size="20" maxlength="12"></td>
</tr>

<tr>
<td class="table2"><font size=2>NIC1 address :&nbsp;</td>
<td class="ltable"><font size=2>&nbsp;<input type="text" name="nic1Addr" size="20" maxlength="12"></td>
</tr>

<tr>
<td class="table2"><font size=2>WLAN address :&nbsp;</td>
<td class="ltable"><font size=2>&nbsp;<input type="text" name="wlanAddr" size="20" maxlength="12"></td>
</tr>
</table>
<br>
<table width="540" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td align="right">
<input type=image src="file/apply1.gif" value="Save Changes" name="save" onClick="return saveChanges()" width="105" height="30" border="0">
<input type=hidden value="/hwset.asp" name="submit-url">
</td></tr>
</table>
</form>
<blockquote>
</body>
</html>


