<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>MAC Filtering</title>
<script language ='javascript' src ='javascript.js'></script>
<script language ='javascript' src ='file/fwwl-n.var'></script>
<script language="JavaScript" src="file/function.js"></script>
<script>
function addClick() {
	if (document.formFilterAdd.mac.value=="" && document.formFilterAdd.comment.value=="" )
		return true;

	var str = document.formFilterAdd.mac.value;
	if ( str.length < 12) {
		alert(showText(fwControlAlertNot));
		document.formFilterAdd.mac.focus();
		return false;
	}

	for (var i=0; i<str.length; i++) {
		if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') || (str.charAt(i) >= 'a' && str.charAt(i) <= 'f') || (str.charAt(i) >= 'A' && str.charAt(i) <= 'F') )
			continue;

		alert(showText(fwControlAlertInv));
		document.formFilterAdd.mac.focus();
		return false;
	}
	return true;
}

function disableDelACPCButton() {
	document.formACPCDel.deleteSelACPC.disabled = true;
	document.formACPCDel.deleteAllACPC.disabled = true;
}

function disableDelButton() {
	document.formFilterDel.deleteSelFilterMac.disabled = true;
	document.formFilterDel.deleteAllFilterMac.disabled = true;
}

function Change() {
document.location.replace("fwaddpc.asp");
}
	
function goToWeb() {
	if (document.formFilterAdd.enabled.checked==true) {
		document.formFilterEnabled.enabled.value="ON";
		if (macEntryNum == 0)
			alert(showText(fwControlAlertMac));
	}
	document.formFilterEnabled.submit();
}

function goToIpWeb() {
	if (document.formACPCDel.enabled.checked==true) {
		document.formIpFilterEnabled.enabled.value="ON";
		if (ipEntryNum == 0)
			alert(showText(fwControlAlertIp));
	}
	document.formIpFilterEnabled.submit();
}

function goToApply() {
	document.formPortFwApply.submit();
}
</script>
</head>
<body class="background">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(fwCtrl);</script></font></b><br><br>
<table border=0 width="520" cellspacing=0 cellpadding=0 align="center"><tr><td>
<p><font class="textcolor" size="2"><script>dw(fwCtrlInfo);</script></font></p></td></tr></table><br>
<form action=/goform/formFilter method=POST name="formFilterEnabled">
  <input type="hidden" value="Add" name="addFilterMac">
  <input type="hidden" value="" name="enabled">
  <input type="hidden" value="/fwcontrol.asp" name="submit-url">
</form>

<form action=/goform/formFilter method=POST name="formIpFilterEnabled">
  <input type="hidden" value="Add" name="addACPC">
  <input type="hidden" value="" name="enabled">
  <input type="hidden" value="/fwcontrol.asp" name="submit-url">
</form>

<table border=1 width="520" cellspacing=0 cellpadding=0 align="center">
<form action=/goform/formFilter method=POST name="formFilterAdd">
<tr class="ltable"><td colspan="2"><font size=2 class="textcolor">
	<input type="checkbox" name="enabled" value="ON" <% if (getIndex("macFilterEnabled")) write("checked");%> onClick="goToWeb();">&nbsp;&nbsp;<script>dw(fwMacEn);</script>

<input type="radio" name="macDenyEnabled" value="yes" <% if (getIndex("macDenyEnabled")==1) write("checked"); %> onClick="document.formFilterAdd.submit();"><font class="textcolor" size="2"><script>dw(deny);</script></font>&nbsp;&nbsp;
<input type="radio" name="macDenyEnabled" value="no" <% if (getIndex("macDenyEnabled")==0) write("checked"); %> onClick="document.formFilterAdd.submit();"><font class="textcolor" size="2"><script>dw(allow);</script></font>
</td>
</tr>
<tr class="stable">
<td><font size=2><script>dw(fwClientMac);</script></font></td>
<td><font size=2><script>dw(comment);</script></font></td>
</tr>
<tr class="table2" align="center">
<td><input type="text" name="mac" size="15" maxlength="12"></td>
<td><input type="text" name="comment" size="16" maxlength="16"></td>
</tr>
<tr class="rstable"><td colspan="2">
        <script>document.write('<input type="submit" class="btnsize" value="'+showText(add)+'" name="addFilterMac" onClick="return addClick()">');</script>&nbsp;&nbsp;
        <script>document.write('<input type="reset" class="btnsize" value="'+showText(reset)+'" name="reset">');</script>
        <input type="hidden" value="/fwcontrol.asp" name="submit-url">
  </td><tr>
</form>
</table>

<br>
<form action=/goform/formFilter method=POST name="formFilterDel">
<input type="hidden" name="enabled" value="<% if (getIndex("macFilterEnabled")) write("ON");%>">
  <table border="1" cellspacing=0 cellpadding=0 width=520 align="center">
  <tr><td colspan="4"><font size=2 class="textcolor"><b><script>dw(fwMacTable);</script></b></font></td></tr>
<tr class="stable">
<td width="10%"><font size=2>NO.</td>
<td width="50%"><font size=2><script>dw(fwClientMac);</script></font></td>
<td width="30%"><font size=2><script>dw(comment);</script></font></td>
<td width="10%"><font size=2><script>dw(select);</script></font></td>
</tr>
  <% macFilterList(); %>
  </table>
  <br><center>
    <script>document.write('<input type="submit" value="'+showText(deleteSelected)+'" name="deleteSelFilterMac" onClick="return deleteClick()" class="btnsize">');</script>
    <script>document.write('<input type="submit" value="'+showText(deleteAll)+'" name="deleteAllFilterMac" onClick="return deleteAllClick()" class="btnsize">');</script>
    <script>document.write('<input type="reset" value="'+showText(reset)+'" name="reset" class="btnsize">');</script>
  <input type="hidden" value="/fwcontrol.asp" name="submit-url">
 </center>
 <script>
	<%	write("macEntryNum = "+getIndex("macFilterNum")+";");%>
	if (macEntryNum == 0)
		disableDelButton();
 </script>
</form>

<form action=/goform/formFilter method=POST name="formACPCDel">
<table border="1" cellspacing=0 cellpadding=0 width=520 align=center>
<tr class="ltable"><td colspan="7"><font size=2 class="textcolor">
	<input type="checkbox" name="enabled" value="ON" <% if (getIndex("ACPCEnabled")) write("checked");%> onClick="goToIpWeb();">&nbsp;&nbsp;<script>dw(fwIPEn);</script>
	<input type="radio" name="ipDenyEnabled" value="yes" <% if (getIndex("ipDenyEnabled")==1) write("checked"); %> onClick="document.formACPCDel.submit();"><font class="textcolor" size="2"><script>dw(deny);</script></font>&nbsp;&nbsp;
	<input type="radio" name="ipDenyEnabled" value="no" <% if (getIndex("ipDenyEnabled")==0) write("checked"); %> onClick="document.formACPCDel.submit();"><font class="textcolor" size="2"><script>dw(allow);</script></font>
</td>
</tr>

<tr class="stable">
<td><font size=2>NO.</td>
<td><font size=2><script>dw(fwClient);</script></font></td>
<td><font size=2><script>dw(fwClientIP);</script></font></td>
<td><font size=2><script>dw(fwCS);</script></font></td>
<td><font size=2><script>dw(protocol);</script></font></td>
<td><font size=2><script>dw(portRange);</script></font></td>
<td><font size=2><script>dw(select);</script></font></td>
</tr>
  <% ACPCList(); %>
  <tr class="stable"><td colspan="7">
  <script>document.write('<input type="button" value="'+showText(addPc)+'" name ="addPc" onClick="Change();" class="btnsize">');</script>
  <script>document.write('<input type="submit" value="'+showText(deleteSelected)+'" name="deleteSelACPC" onClick="return deleteClick()" class="btnsize">');</script>
  <script>document.write('<input type="submit" value="'+showText(deleteAll)+'" name="deleteAllACPC" onClick="return deleteAllClick()" class="btnsize">');</script>
  <input type="hidden" value="/fwcontrol.asp" name="submit-url"></td>
  </tr>
 <script>
	<%	write("ipEntryNum = "+getIndex("ACPCNum")+";");%>
	if ( ipEntryNum == 0 )
		disableDelACPCButton();
 </script>
</table>
</form>

<form action=/goform/formFilter method=POST name="formPortFwApply">
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td align="right">
	<script>document.write('<input type=submit value="'+showText(apply1)+'" style ="width:100px" onClick="goToApply();">');</script>
	<input type="hidden" value="/fwcontrol.asp" name="submit-url">
	<script>document.write('<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="document.formFilterEnabled.reset();">');</script>
	    <input type="hidden" value="1" name="isApply">
</td></tr>
</table>
</form>
</blockquote>
</body>
</html>
