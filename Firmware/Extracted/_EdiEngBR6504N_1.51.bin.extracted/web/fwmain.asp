<html><head><title></title>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script language ='javascript' src ='javascript.js'></script>
<script language ='javascript' src ='file/fwwl-n.var'></script>
<script language="JavaScript">
function evaltF()
{
	if (document.fwseting.FirewallEnable[0].checked==true){
		parent.lFrame.showMenu(6,"enFw");
	}
	else {
		parent.lFrame.showMenu(6,"disFw");
	}
	return true;
}
</script></head>
<body class="background">
<blockquote>
<form action=/goform/formFwEnable method=POST name="fwseting">
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr> 
<td valign="top"> 
<p align="center"><font size="4" class="titlecolor"><script>dw(fwSet);</script></font></p>
<p><font class="textcolor" size="2"><script>dw(fwSetInfo);</script>
<input type="radio" name="FirewallEnable" value="yes" <% if (getIndex("FirewallEnable")==1) write("checked"); %>><font class="textcolor" size="2"><script>dw(enable);</script></font>
<input type="radio" name="FirewallEnable" value="no" <% if (getIndex("FirewallEnable")==0) write("checked"); %>><font class="textcolor" size="2"><script>dw(disable);</script></font>
			</font></p>
		</td>
	</tr>
</tbody></table>
	<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
		<tbody><tr><td> 
			<div align="right">
<input type=hidden value="/fwmain.asp" name="wlan-url">
    		  <script>buffer='<input type=submit value="'+showText(apply1)+'" name="B1" style ="width:100px" onclick="return evaltF();">';document.write(buffer);</script>
			</div>
		</td></tr>
	</tbody></table>
</form>
</blockquote>
</body></html>
