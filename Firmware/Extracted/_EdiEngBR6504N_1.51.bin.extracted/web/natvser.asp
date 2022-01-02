<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Virtual Server</title>
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/qosnat-n.var"></script>
<script language="JavaScript" src="file/function.js"></script>
<script>
function addClick()
{
	if (document.formPortFwAdd.ip.value=="" && document.formPortFwAdd.fromPort.value=="" &&
		document.formPortFwAdd.toPort.value=="" && document.formPortFwAdd.comment.value=="" )
		return true;

	if ( !ipRule( document.formPortFwAdd.ip, showText(ipAddress), "ip", 0))
		return false;

	if (!portRule(document.formPortFwAdd.fromPort, showText(natPortPri), 0, "", 1, 65535, 0))
		return false;

	if (!portRule(document.formPortFwAdd.toPort, showText(natPortPub), 0, "", 1, 65535, 0))
		return false;

   return true;
}

function disableDelButton()
{
	document.formPortFwDel.deleteSelPortFw.disabled = true;
	document.formPortFwDel.deleteAllPortFw.disabled = true;
}

function goToWeb() {
	document.formPortFwAdd.submit();
}

function goToApply() {
	document.formPortFwApply.submit();
}
</script>
</head>
<body class="background">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(natVrServer)</script></font></b></p>
<div align="center">
	<table border="0" width="520" cellspacing="0" cellpadding="0" id="table1">
		<tr>
			<td><font class="textcolor" size="2"><script>dw(natVrInfo)</script></font></td>
		</tr>
	</table>
</div><br>
<table border=1 width="520" cellspacing=0 cellpadding=0 align=center>
<form action=/goform/formVirtualSv method=POST name="formPortFwAdd">
<tr class="ltable"><td colspan=5><font size=2 class="textcolor">
   	<input type="checkbox" name="enabled" value="ON" <% if (getIndex("virtSVEnabled")) write("checked");%> onClick="goToWeb();">&nbsp;&nbsp;<script>dw(enNatVrServer)</script></b>
    </td>
</tr>

 <tr class="stable">
     <td width="30%"><font size=2><script>dw(natPortPriIP)</script></td>
     <td width="15%"><font size=2><script>dw(natPortPri)</script></td>
     <td width="15%"><font size=2><script>dw(type)</script></td>
     <td width="15%"><font size=2><script>dw(natPortPub)</script></td>
     <td width="25%"><font size=2><script>dw(comment)</script></td>
 </tr>
 <tr class="table2" align="center">			   
     <td><input type="text" name="ip" size="15" maxlength="15"></td>
     <td><input type="text" name="fromPort" size="5" maxlength="5"></td>
     <td><select name="protocol">
         <option selected value="0"><script>dw(botholitec)</script></option>
	 <option value="1">TCP</option>
	 <option value="2">UDP</option></select></td>
     <td><input type="text" name="toPort" size="5" maxlength="5"></td>
     <td><input type="text" name="comment" size="16" maxlength="16"></td>
</tr>

<br>
<tr class="rstable">
<td colspan=5>
     <input type="submit" value="" name="addPortFw" onClick="return addClick()" class="btnsize">
     <input type="reset" value="" name="reset" class="btnsize">
     <input type="hidden" value="/natvser.asp" name="submit-url">
<script language ="javascript">
document.formPortFwAdd.addPortFw.value =showText(add);
document.formPortFwAdd.reset.value =showText(reset);
</script>
</td></tr>
</form>
</table>
<br>
<form action=/goform/formVirtualSv method=POST name="formPortFwDel">
<input type="hidden" name="enabled" value="<% if (getIndex("virtSVEnabled")) write("ON");%>">
<table border=1 width=520 cellspacing=0 cellpadding=0 align=center>
  <tr><td colspan="7"><b><font size=2 class="textcolor"><script>dw(natVrTable)</script>:</font></b></td></tr>
 <tr class="stable">
	<td><font size=2>NO.</td>
	<td><font size=2><script>dw(natPortPriIP)</script></td>
	<td><font size=2><script>dw(natPortPri)</script></td>
	<td><font size=2><script>dw(type)</script></td>
	<td><font size=2><script>dw(natPortPub)</script></td>
	<td><font size=2><script>dw(comment)</script></td>
	<td><font size=2><script>dw(select)</script></td>
 </tr>
  <% virtualSvList(); %>
</table>
 <br><div align="center"><script>buffer='<input type="submit" value="'+showText(deleteSelected)+'" name="deleteSelPortFw" onClick="return deleteClick()" class="btnsize">';document.write(buffer);</script>
	<script>buffer='<input type="submit" value="'+showText(deleteAll)+'" name="deleteAllPortFw" onClick="return deleteAllClick()" class="btnsize">';document.write(buffer);</script>
	<script>buffer='<input type="reset" value="'+showText(reset)+'" name="reset" class="btnsize">';document.write(buffer);</script>
</div>
 <script>
   	<% entryNum = getIndex("vserNum");
   	  if ( entryNum == 0 ) {
      	  	write( "disableDelButton();" );
       	  } %>
 </script>
     <input type="hidden" value="/natvser.asp" name="submit-url">
</form>

<form action=/goform/formVirtualSv method=POST name="formPortFwApply">
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td align="right">
		<script>buffer='<input type=submit value="'+showText(apply1)+'" style ="width:100px" onclick="goToApply();">';document.write(buffer);</script>
		<input type="hidden" value="/natvser.asp" name="submit-url">
		<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="window.location.reload();">';document.write(buffer);</script>
	    <input type="hidden" value="1" name="isApply">
</td></tr>
</table>
</form>
</blockquote>
</body>
</html>

