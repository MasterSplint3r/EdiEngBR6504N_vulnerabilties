<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>NAT Port Forwarding</title>
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/qosnat-n.var"></script>
<script language="JavaScript" src="file/function.js"></script>
<script>
function disableDelButton()
{
	document.formPortFwDel.deleteSelPortFw.disabled = true;
	document.formPortFwDel.deleteAllPortFw.disabled = true;
}
			
function addClick()
{
strIp = document.formPortFwAdd.ip;
strFromPort = document.formPortFwAdd.fromPort;
strToPort = document.formPortFwAdd.toPort;
strComment = document.formPortFwAdd.comment;
	if (strIp.value=="" && strFromPort.value=="" &&	strToPort.value=="" && strComment.value=="" )
		return true;

	if ( !ipRule( strIp, showText(natpfwStrIp), "ip", 0))
		return false;

	if (!portRule(strFromPort, showText(natpfwStrPort), strToPort, showText(natpfwStrPort), 1, 65535, 0))
		return false;

	return true;
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
<p align="center"><b><font class="titlecolor" size="4"><script>dw(natPort)</script></font></b><br><br>
<div align="center">
	<table border="0" width="520" cellspacing="0" id="table1" cellpadding="0">
		<tr>
			<td>
			<p align="left"><font class="textcolor" size="2"><script>dw(natPortInfo)</script></font></td>
		</tr>
	</table>
</div>
<table border=1 width="520" cellspacing=0 cellpadding=0 align="center">
<form action=/goform/formPortFw method=POST name="formPortFwAdd">
<tr class="ltable"><td colspan="4"><font size=2 class="textcolor">
   	<input type="checkbox" name="enabled" value="ON" <% if (getIndex("portFwEnabled")) write("checked");%> onClick="goToWeb();">&nbsp;<script>dw(enNatPort);</script><br>
    </td>
</tr>
 <tr class="stable">
     <td><font size=2><b><script>dw(natPortPriIP)</script></b></td>
     <td><font size=2><b><script>dw(type)</script></b></td>
     <td><font size=2><b><script>dw(natPortRange)</script></b></td>
     <td><font size=2><b><script>dw(comment)</script></b></td>
 </tr>
 <tr class="table2" align="center">			   
     <td><input type="text" name="ip" size="15" maxlength="15"></td>
     <td><select name="protocol">
         <option selected value="0"><script>dw(botholitec)</script></option>
	 <option value="1">TCP</option>
	 <option value="2">UDP</option></select></td>
     <td><input type="text" name="fromPort" size="5" maxlength="5"><b>-</b>
         <input type="text" name="toPort" size="5" maxlength="5"></td>
     <td><input type="text" name="comment" size="16" maxlength="16"></td>
</tr>
<br>
<tr class="rstable">
<td colspan=4>
  <script>document.write('<input type="submit" value="'+showText(add)+'" name="addPortFw" onClick="return addClick()" class="btnsize">')</script>&nbsp;&nbsp;
  <script>document.write('<input type="reset" value="'+showText(reset)+'" name="reset" class="btnsize">')</script>
  <input type="hidden" value="/natpfw.asp" name="submit-url">
</td></tr>
</form>
</table>
<br>
<form action=/goform/formPortFw method=POST name="formPortFwDel">
<input type="hidden" name="enabled" value="<% if (getIndex("portFwEnabled")) write("ON");%>">
<table border=1 width=520 align="center" cellspacing=0 cellpadding=0>
  <tr><td colspan="6"><font size=2 class="textcolor"><b><script>dw(natPortTable)</script>:</b></font></td></tr>
 <tr class="stable">
	<td width="5%"><font size=2><b>NO.</b></td>
	<td width="30%"><font size=2><b><script>dw(natPortPriIP)</script></b></td>
	<td width="20%"><font size=2><b><script>dw(type)</script></b></td>
	<td width="20%"><font size=2><b><script>dw(natPortRange)</script></b></td>
	<td width="20%"><font size=2><b><script>dw(comment)</script></b></td>
	<td width="5%"><font size=2><b><script>dw(select)</script></b></td>
 </tr>
  <% portFwList(); %>
</table>

 <br><div align="center">
  <script>buffer='<input type="submit" value="'+showText(deleteSelected)+'" name="deleteSelPortFw" onClick="return deleteClick()" class="btnsize">';document.write(buffer);</script>&nbsp;&nbsp;
  <script>buffer='<input type="submit" value="'+showText(deleteAll)+'" name="deleteAllPortFw" onClick="return deleteAllClick()" class="btnsize">';document.write(buffer);</script>&nbsp;&nbsp;
  <script>buffer='<input type="reset" value="'+showText(reset)+'" name="reset" class="btnsize">';document.write(buffer);</script>
</div>
 <script>
   	<% entryNum = getIndex("portFwNum");
   	  if ( entryNum == 0 ) {
      	  	write( "disableDelButton();" );
       	  } %>
 </script>
     <input type="hidden" value="/natpfw.asp" name="submit-url">
</form>

<form action=/goform/formPortFw method=POST name="formPortFwApply">
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td align="right">
		<script>buffer='<input type=submit value="'+showText(apply1)+'" style ="width:100px" onclick="goToApply();">';document.write(buffer);</script>
        <input type="hidden" value="/natpfw.asp" name="submit-url">
		<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="window.location.reload();">';document.write(buffer);</script>
	    <input type="hidden" value="1" name="isApply">
</td></tr>
</table>
</form>
</blockquote>
</body>
</html>

