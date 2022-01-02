<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>System Remote Management</title>
<script language="JavaScript" src="file/function.js"></script>
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/netsys-n.var"></script>
<link rel="stylesheet" href="set.css">
<script language="JavaScript">
function saveChanges()
{
	if(document.tF.reMangEnable.checked==false)
		return true;

	if ( !ipRule( document.tF.reManHostAddr, showText(IPAddr), "ip", 1))
		return false;
	if (!portRule(document.tF.reManPort, showText(portNum), 0, "", 1, 65535, 1))		 
		return false;

   return true;
}

	
function Enable()
{
  if(document.tF.reMangEnable.checked==true) {
          document.tF.reManHostAddr.disabled = false;
          document.tF.reManPort.disabled = false;
	}
  else {
          document.tF.reManHostAddr.disabled = true;
          document.tF.reManPort.disabled = true;
	}
}
</script></head>
<body class="background">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(RemoteM)</script></font></b><br><br>
<div align="center">
	<table border="0" width="520" cellspacing="0" cellpadding="0" id="table1">
		<tr>
			<td><font class="textcolor"  size="2"><script>dw(sysrmContent)</script></font></td>
		</tr>
	</table>
</div>
<form name="tF" method="post" action=/goform/formReManagementSetup>
<table width="520" border="1" cellspacing=0 cellpadding=0 align="center">
<tr>
<td class="stable"><font size="2"><script>dw(hostAddr)</script></font></td>
<td class="stable"><font size="2"><script>dw(port)</script></font></td>
<td class="stable"><font size="2"><script>dw(enabled)</script></font></td>
</tr>
<tr>
<td class="table2" align="center">
<input type="text" name="reManHostAddr" size="15" maxlength="15" value=<% getInfo("reManHostAddr"); %>></td>
<td class="table2" align="center">
<input type="text" name="reManPort" size="5" maxlength="5" value=<% getInfo("reManPort"); %>></td>
<td class="table2" align="center"><input type="checkbox" name="reMangEnable" value="ON" <% if (getIndex("reMangEnable")==1) write("checked"); %> onClick="Enable()"></td>
</tr>
<script language="JavaScript">
	Enable();
</script>
</table>
<br>
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td align="right">
	<script>buffer='<input type=submit value="'+showText(apply1)+'" style ="width:100px" onClick="return saveChanges();">';document.write(buffer);</script>
	<input type=hidden value="/sysrm.asp" name="submit-url">
	<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="document.tF.reset();">';document.write(buffer);</script>
</td>
</tr>
</table>
</form>
</blockquote>
</body></html>
