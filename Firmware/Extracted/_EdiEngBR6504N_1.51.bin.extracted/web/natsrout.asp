<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Static Routing Settings</title>
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/qosnat-n.var"></script>
<script language="JavaScript" src="file/function.js"></script>
<script>
function addClick()
{
	if ( !ipRule( document.formFilterAdd.sroutIp, showText(ipAddress), "ip", 0))
		return false;
	if(!maskRule(document.formFilterAdd.sroutMask, 0))
		return false;
	if ( !ipRule( document.formFilterAdd.sroutGateway, showText(gateway), "ip", 0))
		return false;
	if (!portRule(document.formFilterAdd.sroutCount, showText(natSrHop), 0, "", 0, 255, 0))
		return false;
	return true;
}

function disableDelButton()
{
	document.formFilterDel.delSelSRout.disabled=true;
	document.formFilterDel.delAllSRout.disabled=true;
}
function goToWeb() {
	if (document.formFilterAdd.enabled.checked==true)
		document.formFilterEnabled.enabled.value="ON";
	document.formFilterEnabled.submit();
}

function goToApply() {
	document.formPortFwApply.submit();
}
</script>
</head>
<body class="background">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(natSr)</script></font></b><br><br>
<div align="center">
	<table border="0" width="520" cellspacing="0" id="table1" cellpadding="0">
		<tr>
			<td><font class="textcolor"  size="2"><script>dw(natSrInfo)</script></font></td>
		</tr>
	</table>
</div>
       </font></p>
<form action=/goform/formFilter method=POST name="formFilterEnabled">
	<input type="hidden" value="Add" name="addSRout">
	<input type="hidden" value="" name="enabled">
	<input type="hidden" value="/natsrout.asp" name="submit-url">
</form>
<table border=1 width="520" cellspacing=0 cellpadding=0 align="center">
<form action=/goform/formFilter method=POST name="formFilterAdd">
<tr class="ltable"><td colspan="5"><font size=2 class="textcolor">
<input type="checkbox" name="enabled" value="ON" <% if (getIndex("sroutEnabled")) write("checked");   %> ONCLICK="goToWeb();">&nbsp;&nbsp;<script>dw(enNatSr)</script><br>
    </td>
</tr>
<tr class="stable">
	<td width="25%"><font size=1><script>dw(natSrIP)</script></td>
	<td width="25%"><font size=1><script>dw(natSrSM)</script></td>
	<td width="25%"><font size=1><script>dw(natSrGateway)</script></td>
	<td width="10%"><font size=1><script>dw(natSrHop)</script></td>
	<td width="15%"><font size=1><script>dw(face)</script></td>
</tr>
<tr class="table2" align="center">
<td><input type="text" name="sroutIp" size="15" maxlength="15"></td>
<td><input type="text" name="sroutMask" size="15" maxlength="15"></td>
<td><input type="text" name="sroutGateway" size="15" maxlength="15"></td>
<td><input type="text" name="sroutCount" size="3" maxlength="3"></td>
<td><select name="sroutFace">
<option selected value="0">LAN</option>
<option value="1">WAN</option></select></td>
</tr>
<tr class="rstable"><td colspan="5">
	<p><script>document.write('<input type="submit" value="'+showText(add)+'" name="addSRout" onClick="return addClick()" class="btnsize">')</script>
	<script>document.write('<input type="reset" value="'+showText(reset)+'" name="reset" class="btnsize">')</script>
	<input type="hidden" value="/natsrout.asp" name="submit-url">
	</p>
</td></tr>
</form>
</table>
<br>
<form action=/goform/formFilter method=POST name="formFilterDel">
	<table border=1 width="520" cellspacing=0 cellpadding=0 align="center">
	<tr><font size=2 class="textcolor"><script>dw(natSrTable)</script>:</font></tr>
<tr class="stable">
	<td><font size=1>NO.</td>
	<td><font size=1><script>dw(natSrIP)</script></td>
	<td><font size=1><script>dw(natSrSM)</script></td>
	<td><font size=1><script>dw(natSrGateway)</script></td>
	<td><font size=1><script>dw(natSrHop)</script></td>
	<td><font size=1><script>dw(face)</script></td>
	<td><font size=1><script>dw(select)</script></td>
</tr>
	<% StcRoutList(); %>
	</table>
	<br><div align="center">
  <script>buffer='<input type="submit" value="'+showText(deleteSelected)+'" name="delSelSRout" onClick="return deleteClick()" class="btnsize">';document.write(buffer);</script>
  <script>buffer='<input type="submit" value="'+showText(deleteAll)+'" name="delAllSRout" onClick="return deleteAllClick()" class="btnsize">';document.write(buffer);</script>
  <script>buffer='<input type="reset" value="'+showText(reset)+'" name="reset" class="btnsize">';document.write(buffer);</script>
	<input type="hidden" value="/natsrout.asp" name="submit-url"></div>
	<script>
	<% entryNum = getIndex("sroutNum");
		if ( entryNum == 0 ) {
		write( "disableDelButton();" );
	} %>
 </script>
</form>

<form action=/goform/formFilter method=POST name="formPortFwApply">
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td align="right">
		<script>buffer='<input type=submit value="'+showText(apply1)+'" style ="width:100px" onclick="goToApply();">';document.write(buffer);</script>
		<input type="hidden" value="/natsrout.asp" name="submit-url">
		<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="window.location.reload();">';document.write(buffer);</script>
	    <input type="hidden" value="1" name="isApply">
</td></tr>
</table>
</form>

</blockquote>
</body>
</html>
