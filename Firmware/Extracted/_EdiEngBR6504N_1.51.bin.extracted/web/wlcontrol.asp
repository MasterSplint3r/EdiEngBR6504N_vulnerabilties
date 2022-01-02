<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset =utf-8">
<title>MAC Filtering</title>
<script language ='javascript' src ='javascript.js'></script>
<script language ='javascript' src ='file/fwwl-n.var'></script>
<script language="JavaScript" src="file/function.js"></script>
<script>
function addClick() {
	if ( !macRule(document.formFilterAdd.mac,showText(wlMacAddress), 0))
		return false;
	return true;
}

function disableDelButton()
{
	document.formFilterDel.deleteSelFilterMac.disabled = true;
	document.formFilterDel.deleteAllFilterMac.disabled = true;
}

function goToWeb() {
	if (document.formFilterAdd.wlanAcEnabled.checked==true)
		document.formWlAcEnabled.wlanAcEnabled.value="ON";
	document.formWlAcEnabled.submit();
}

function goToApply() {
	document.formPortFwApply.submit();
}
</script>
</head>
<body class="background">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(wlMacAddrFiltering)</script></font></b></p>
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
<p align="left"><font class="textcolor" size="2"><script>dw(wlCtrlInfo)</script>
</font></p></td></tr></table><br>

<form action=/goform/formWlAc method=POST name="formWlAcEnabled">
  <input type="hidden" value="Add" name="addFilterMac">
  <input type="hidden" value="" name="wlanAcEnabled">
  <input type="hidden" value="/wlcontrol.asp" name="submit-url">
</form>
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
    <p class="subcolor">
    <font size=2><b><script>dw(wlCtrlTable)</script></b></font><br>
	<font size=2><script>dw(wlCtrlTableInfo)</script></font>
    </p>
</td></tr></table>
<form action=/goform/formWlAc method=POST name="formFilterDel">
  <table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="stable">
    <td width="10%"><font size=2><b>NO.</b></td>
    <td width="45%"><font size=2><b><script>dw(wlMacAddress)</script></b></td>
    <td width="35%"><font size=2><b><script>dw(comment)</script></b></td>
    <td width="15%"><font size=2><b><script>dw(select)</script></b></td>
</tr>
    <% wlAcList(); %>
  </table>
  <br><center>
    <script>buffer='<input type="submit" value="'+showText(deleteSelected)+'" name="deleteSelFilterMac" onClick="return deleteClick()" class="btnsize">';document.write(buffer);</script>&nbsp;&nbsp;
    <script>buffer='<input type="submit" value="'+showText(deleteAll)+'" name="deleteAllFilterMac" onClick="return deleteAllClick()" class="btnsize">';document.write(buffer);</script>&nbsp;&nbsp;&nbsp;
    <script>buffer='<input type="reset" value="'+showText(reset)+'" name="reset" class="btnsize">';document.write(buffer);</script>
 <input type="hidden" value="/wlcontrol.asp" name="submit-url">
 <script>
         <% entryNum = getIndex("wlanAcNum");
	        if ( entryNum == 0 ) {
			write( "disableDelButton();" );
		} %>
 </script>
 </form>
<br>

<form action=/goform/formWlAc method=POST name="formFilterAdd">
 
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr><td colspan="5"><font size=2 class="textcolor"><b>
   <input type="checkbox" name="wlanAcEnabled" value="ON" <% if (getIndex("wlanAcEnabled")) write("checked"); %> onclick="goToWeb()">&nbsp;&nbsp;<script>dw(wlCtrlAccEn)</script></b>
     </td></tr>
      
<tr class="table2">
<td width="5%" valign="middle" align="center"><font size="2"><script>dw(news)</script>
<input type="hidden" name="tiny_idx" value="0"></font></td>

<td width="42%" valign="middle" align="center"><font size="1"><script>dw(wlMacAddress)</script>:<br>
<input type="text" name="mac" size="15" maxlength="12"></font></td>

<td width="30%" valign="middle" align="center"><font size="1"><script>dw(comment)</script>:<br>
<input type="text" name="comment" size="16" maxlength="16"></font></td>
<td width="20%" valign="middle" align="center">
	<script>buffer='<input type="submit" value="'+showText(add)+'" name="addFilterMac" onClick="return addClick()" class="btnsize">';document.write(buffer);</script>
	<script>buffer='<input type="reset" value="'+showText(clear)+'" name="reset" class="btnsize">';document.write(buffer);</script>
<input type="hidden" value="/wlcontrol.asp" name="submit-url"></td>
</tr>
</table>
</form>

<form action=/goform/formWlAc method=POST name="formPortFwApply">
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td align="right">
			<script>buffer='<input type=submit value="'+showText(apply1)+'" onclick="goToApply();" style ="width:100px">';document.write(buffer);</script>
			<input type="hidden" value="/wlcontrol.asp" name="submit-url">
 			<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="window.location.reload()">';document.write(buffer);</script>
	    <input type="hidden" value="1" name="isApply">
</td></tr>
</table>
</form>
</blockquote>
</body>
</html>
