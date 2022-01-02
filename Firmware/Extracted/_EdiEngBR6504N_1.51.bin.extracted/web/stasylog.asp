<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Security Log</title>
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/statustool-n.var"></script>
<script>
function refreshLog() {
	document.location.replace("stasylog.asp");
}
</script>

</head>
<body class="background">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(statSystem)</script></font></b><br><br>
<div align="center">
	<table border="0" width="520" cellspacing="0" cellpadding="0" id="table1">
		<tr>
			<td><font class="textcolor"  size="2"><script>dw(statSystemDoc)</script></font></td>
		</tr>
	</table>
</div>
<form method="post" action="goform/formSysLog"  name="sysLog">
<table border="0" cellspacing="0" cellpadding="0" width="520" align="center">
<tr><td>
<TEXTAREA cols="83" name="logtext" readOnly rows="9" wrap="off" edit="off" style="color:000000"  style="font-size: 10pt; font-family: Arial; color:000000">
<% getInfo("syslog"); %>
</TEXTAREA>
</td></tr>
</table>
    <p align="center">
	<script>buffer='<input type ="submit" name ="send" value ="'+showText(save)+'" class="btnsize">';document.write(buffer);</script>
	<script>buffer='<input type ="submit" name ="reset" value ="'+showText(clear)+'" class="btnsize">';document.write(buffer);</script>
	<script>buffer='<input type ="button" name ="refresh" onclick ="refreshLog()" value ="'+showText(refresh)+'" class="btnsize">';document.write(buffer);</script>
	<input type="hidden" value="/stasylog.asp" name="submit-url">
    </p>
 </form>
 </blockquote>
</body>
</html>
