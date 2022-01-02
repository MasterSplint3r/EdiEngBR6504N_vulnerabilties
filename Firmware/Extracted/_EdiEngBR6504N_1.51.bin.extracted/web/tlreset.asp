<html><head><title>Reset</title>
<link rel="stylesheet" href="set.css">
<meta http-equiv="content-type" content="text/html;charset=utf-8">
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/statustool-n.var"></script>
<script language="JavaScript">
function doConfirm(){
	if(confirm(showText(tlresetConfirm))) {
		alert(showText(tlresetAlert));
	    return true;
	}
	document.RebootForm.reset_flag.value=1;
	return false;
}

function logoutF()
{
	document.location.RebootForm.submit();
	return true;
}
</script></head>
<body class="background">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(reset)</script></font></b><br><br>
<div align="center">
	<table border="0" width="520" cellspacing="0" cellpadding="0" id="table1">
		<tr>
			<td><font class="textcolor" size="2"><script>dw(firmReset)</script></font></td>
		</tr>
	</table>
</div>

<form action=/goform/formReboot method=POST name="RebootForm" onsubmit="return doConfirm();">
<input type="hidden" name="reset_flag" value="0">
  <table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
  <tbody><tr><td></td></tr>
  <tr>
    <td height="14" align="right">
		<script>buffer='<input type=submit value="'+showText(apply1)+'" style ="width:100px">';document.write(buffer);</script>
		<input type=hidden value="/tlreset.asp" name="submit-url"> 
		<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="document.RebootForm.reset();">';document.write(buffer);</script>
    </td>
  </tr>
</tbody></table>
</form>
</blockquote>
</body></html>
