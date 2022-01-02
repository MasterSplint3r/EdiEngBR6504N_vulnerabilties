<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FireWall URL Blocking</title>
<script language ='javascript' src ='javascript.js'></script>
<script language ='javascript' src ='file/fwwl-n.var'></script>
<script>
<% write("entryNum = "+getIndex("URLBNum")+";"); %>

function disableDelButton()
{
	document.formUrlbDel.deleteSelURLB.disabled = true;
	document.formUrlbDel.deleteAllURLB.disabled = true;
}

function addClick() {
	if (entryNum < 20) {
		if (document.formUrlbAdd.URLB.value==""){
			alert(showText(fwurlbAlertInv));
			document.formUrlbAdd.URLB.focus();
			return false;
		}
	}
	else {
		alert(showText(fwurlbAlertCannot));
		return false;
	}
	return true;
}

function updateState()
{
	if (document.formUrlbAdd.enabled.checked)
		document.formUrlbAdd.URLB.disabled=false;
	else 
		document.formUrlbAdd.URLB.disabled=true;
}

function goToWeb() {
	if (document.formUrlbAdd.enabled2.checked==true)
		document.formURLBEnabled.enabled.value="ON";
	document.formURLBEnabled.submit();
}

function goToApply() {
	document.formPortFwApply.submit();
}
</script>
</head>
<body class="background">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(fwUrl);</script></font></b></p>
<table border=0 width="520" cellspacing=0 cellpadding=0 align="center"><tr><td>
<font class="textcolor"  size="2"><script>dw(fwUrlInfo);</script></font>
</td></tr></table><br>
<table border=1 width="520" cellspacing=0 cellpadding=0 align="center">
<form action=/goform/formUrlb method=POST name="formURLBEnabled">
	<input type="hidden" value="ON" name="isEnabled">
	<input type="hidden" value="" name="enabled">
	<input type="hidden" value="/fwurlb.asp" name="submit-url">
</form>
<form action=/goform/formUrlb method=POST name="formUrlbAdd">
<tr class="ltable">
	<td colspan="2"><font size=2 class="textcolor"><b>
		<input type="checkbox" name="enabled2" value="ON" <% if (getIndex("URLBEnabled")) write("checked");%> onClick="goToWeb();">&nbsp;&nbsp;<script>dw(enfwUrl);</script></b><br>
	</td>
</tr>
<tr>
	<td width="30%" class="table3" align="right"><font size=2><b><script>dw(fwUrlKey);</script></center></b></td>
	<td width="70%" class="table3" align="left">&nbsp;
		<input type="text" name="URLB" size="32" maxlength="32">
	</td>
</tr>
<tr class="rstable">
	<td colspan="2">
        <script>buffer='<input type="submit" value="'+showText(add)+'" name="addURLB" onClick="return addClick()" class="btnsize">';document.write(buffer);</script>
        <script>buffer='<input type="reset"  value="'+showText(reset)+'" name="reset" class="btnsize">';document.write(buffer);</script>
		<input type="hidden" value="/fwurlb.asp" name="submit-url">
	</td>
</tr>
</form>
</table>
<br>
<form action=/goform/formUrlb method=POST name="formUrlbDel">
<table border="1" width=520 cellspacing=0 cellpadding=0 align="center">
<tr><td colspan="3">
	<b><font size=2 class="textcolor"><script>dw(fwUrlTable);</script>:</font></b>
</td></tr>
<tr class="stable">
	<td width="10%"><font size=2>NO.</td>
	<td width="70%"><font size=2><script>dw(fwUrlKey);</script></font></td>
	<td width="20%"><font size=2><script>dw(select);</script></font></td>
</tr>
<% URLBList(); %>
</table>
<br><center>
<script>buffer='<input type="submit" value="'+showText(deleteSelected)+'" name="deleteSelURLB" class="btnsize">';document.write(buffer);</script>
<script>buffer='<input type="submit" value="'+showText(deleteAll)+'" name="deleteAllURLB" class="btnsize">';document.write(buffer);</script>
<script>buffer='<input type="reset"  value="'+showText(reset)+'" name="reset" class="btnsize">';document.write(buffer);</script>
<script>
	<% entryNum = getIndex("URLBNum");
	if ( entryNum == 0 ) {
		write( "disableDelButton();" );
	} %>
 </script>
 
<input type="hidden" value="/fwurlb.asp" name="submit-url">
</form>

<form action=/goform/formUrlb method=POST name="formPortFwApply">
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td align="right">
		<script>buffer='<input type=submit value="'+showText(apply1)+'" name="B1" style ="width:100px" onclick="goToApply();">';document.write(buffer);</script>
		<input type="hidden" value="/fwurlb.asp" name="submit-url">
		<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="window.location.reload()">';document.write(buffer);</script>
		<input type="hidden" value="1" name="isApply">
	</td>
</tr>
</table>
</form>
</blockquote>
</body>
</html>
