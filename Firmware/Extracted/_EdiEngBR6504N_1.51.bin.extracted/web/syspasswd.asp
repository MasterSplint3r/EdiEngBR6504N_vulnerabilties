<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>System Password configuration</title>
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/netsys-n.var"></script>
<% language=javascript %>
<SCRIPT>
function includeSpace(str)
{
  for (var i=0; i<str.length; i++) {
  	if ( str.charAt(i) == ' ' ) {
	  return true;
	}
  }
  return false;
}

function saveChanges()
{

   if ( document.password.newpass.value != document.password.confpass.value) {
	alert(showText(syspasswdAlert));
	document.password.newpass.focus();
	return false;
  }
  if ( includeSpace(document.password.newpass.value)) {
	alert(showText(syspasswdAlert2));
	document.password.newpass.focus();
	return false;
  }
	if(document.password.newpass.value == "" ){
	alert(showText(syspasswdAlert2));
	document.password.newpass.focus();
	return false;
	}
  return true;
}
</SCRIPT>
</head>
<BODY class="background">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(passSet)</script></font></b><br><br>
<div align="center">
	<table border="0" width="520" cellspacing="0" cellpadding="0" id="table1">
		<tr>
			<td><font class="textcolor" size="2"><script>dw(passSettingContent)</script></font></td>
		</tr>
	</table>
</div>
<form action=/goform/formPasswordSetup method=POST name="password">
 <table border="1" cellspacing="0" cellpadding="0" width="520" align="center">

<tr>
      <td class="table2" width="35%"><font size=2><script>dw(currentPass)</script>:&nbsp;</td>
      <td class="ltable" width="65%"><font size=2><input type="password" name="oldpass" size="20" maxlength="30" value=""></td>
</tr>

<tr>
      <td class="table2"><font size=2><script>dw(newPass)</script>:&nbsp;</td>
      <td class="ltable"><font size=2><input type="password" name="newpass" size="20" maxlength="30"></td>
</tr>

<tr>
      <td class="table2"><font size=2><script>dw(confirmPass)</script>:&nbsp;</td>
      <td class="ltable"><font size=2><input type="password" name="confpass" size="20" maxlength="30"></td>
    </tr>
  </table>
<br>
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td align="right">
	<script>buffer='<input type=submit value="'+showText(apply1)+'" name="save" style ="width:100px" onClick="return saveChanges()">';document.write(buffer);</script>
	<input type=hidden value="/syspasswd.asp" name="submit-url">
	<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="document.password.reset();">';document.write(buffer);</script>
</td>
</tr>
</table>
</form>
</blockquote>
</body>
</html>


