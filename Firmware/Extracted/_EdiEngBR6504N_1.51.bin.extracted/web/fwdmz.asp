<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>DMZ Settings</title>
<script language ='javascript' src ='javascript.js'></script>
<script language ='javascript' src ='file/fwwl-n.var'></script>
<script language="JavaScript" src="file/function.js"></script>
<script>
function addClick()
{
	if (document.formFilterAdd.dmzType[1].checked == true) {
		if ( !ipRule( document.formFilterAdd.pip, showText(pubIpAddress), "ip", 0))
			return false;
	}
	if ( !ipRule( document.formFilterAdd.cip, showText(clientIpAddress), "ip", 0))
		return false;

  return true;
}

function disableDelButton()
{
	document.formFilterDel.delSelDMZ.disabled = true;
	document.formFilterDel.delAllDMZ.disabled = true;
}
	
function goToWeb() {
	if (document.formFilterAdd.enabled.checked==true)
		document.formDMZEnabled.enabled.value="ON";
	document.formDMZEnabled.submit();
}

function goToApply() {
	document.formPortFwApply.submit();
}

function disType() {
	if (document.formFilterAdd.dmzType[0].checked == true ) {
		document.formFilterAdd.session.disabled = false;
		document.formFilterAdd.pip.disabled = true;
	}
	else{
		document.formFilterAdd.session.disabled = true;
		document.formFilterAdd.pip.disabled = false;
	}
}
</script>
</head>
<body class="background">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(fwDmz);</script></font></b><br><br>
	<table border="0" width="520" id="table1" cellspacing="0" cellpadding="0" align="center">
		<tr>
			<td><font class="textcolor" size="2"><script>dw(fwDmzInfo);</script></font></td>
		</tr>
	</table><br>
<table border=1 width="520" cellspacing=0 cellpadding=0 align="center">
<form action=/goform/formFilter method=POST name="formDMZEnabled">
  <input type="hidden" value="Add" name="addDMZ">
  <input type="hidden" value="" name="enabled">
  <input type="hidden" value="/fwdmz.asp" name="submit-url">
</form>
<form action=/goform/formFilter method=POST name="formFilterAdd">
<tr><td colspan="2" class="ltable"><font size=2 class="textcolor">
   	<input type="checkbox" name="enabled" value="ON" <% if (getIndex("dmzEnabled")) write("checked");%> onClick="goToWeb();" >&nbsp;&nbsp;<script>dw(enableDMZ);</script></b>
    </td>
</tr>
<tr class="stable">
    <td width="60%"><font size=2><b><script>dw(pubIpAddress);</script></b></td>
    <td width="40%"><font size=2><b><script>dw(clientPcIpAddress);</script></b></td>
</tr>
<tr class="table2" align="center">
<td>
<table>
<tr>
<td align="left"><font size="2">&nbsp;<input type="radio" name="dmzType" value="0" checked onClick="disType();"><script>dw(dynamicIp);</script></font></td>
<td><select name="session"><script>
for (i=1; i<=1; i++) {
	if (i == 1)
	    document.write('<option selected value="'+i+'">Session '+i+'</option>');
	else
	    document.write('<option value="'+i+'">Session '+i+'</option>');
}
</script>
</select></td></tr>
<tr class="table2" align="center">
	<td align="left"><font size="2">&nbsp;<input type="radio" name="dmzType" value="1" onClick="disType();"><script>dw(staticsIp);</script></font></td>
	<td><input type="text" name="pip" size="15" maxlength="15"></td>
</tr>
</table></td>
<td><input type="text" name="cip" size="15" maxlength="15"></td>
</tr>
<tr class="rstable"><td colspan="2">
	<script>buffer='<input type="submit" value="'+showText(add)+'" name="addDMZ" onClick="return addClick()" class="btnsize">';document.write(buffer);</script>
	<script>buffer='<input type="reset" value="'+showText(reset)+'" name="reset" class="btnsize">';document.write(buffer);</script>
        <input type="hidden" value="/fwdmz.asp" name="submit-url">
  </td><tr>
</form>
</table>

<br>
<form action=/goform/formFilter method=POST name="formFilterDel">
  <table border="1" width=520 cellspacing=0 cellpadding=0 align="center">
  <tr><td colspan="4"><b><font size=2 class="textcolor"><script>dw(fwDmzTable);</script> :</font></b></td></tr>
<tr class="stable">
	<td width="10%"><font size=2><b>NO.</b></td>
    <td width="50%"><font size=2><b><script>dw(pubIpAddress);</script></b></td>
    <td width="30%"><font size=2><b><script>dw(clientPcIpAddress);</script></b></td>
    <td width="10%"><font size=2><b><script>dw(select);</script></b></td>
</tr>
  <% DMZList(); %>
  </table>
  <br><center>
  <script>buffer='<input type="submit" value="'+showText(deleteSelected)+'" name="delSelDMZ" onClick="return deleteClick()" class="btnsize">';document.write(buffer);</script>
  <script>buffer='<input type="submit" value="'+showText(deleteAll)+'" name="delAllDMZ" onClick="return deleteAllClick()" class="btnsize">';document.write(buffer);</script>
  <script>buffer='<input type="reset" value="'+showText(reset)+'" name="reset" class="btnsize">';document.write(buffer);</script>
  <input type="hidden" value="/fwdmz.asp" name="submit-url"></center>
 <script>
	disType();
   	<% entryNum = getIndex("dmzNum");
   	  if ( entryNum == 0 ) {
      	  	write( "disableDelButton();" );
       	  } %>
 </script>
</form>

<form action=/goform/formFilter method=POST name="formPortFwApply">
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td align="right">
    <script>buffer='<input type=submit value="'+showText(apply1)+'" style ="width:100px" onClick="goToApply();">';document.write(buffer);</script>
	<input type="hidden" value="/fwdmz.asp" name="submit-url">
    <script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="document.formDMZEnabled.reset();">';document.write(buffer);</script>
	    <input type="hidden" value="1" name="isApply">
</td></tr>
</table>
</form>

</blockquote>
</body>
</html>
