<html><head><title></title>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/qosnat-n.var"></script>
<script language="JavaScript">
function evaltF()
{
	if (document.natseting.natEnable[0].checked==true){
		parent.lFrame.showMenu(5,"enNat");
	}
	else {
		parent.lFrame.showMenu(5,"disNat");
	}
	return true;
}
</script></head>
<body class="background">
<blockquote>
<form action=/goform/formNatEnable method=POST name="natseting">
<table width="90%" border="0" cellspacing="0" cellpadding="10" height="180">
<tbody>
<tr> 
<td valign="top"> 
<p align="center"><font size="4" class="titlecolor"><script>dw(natSet)</script></font></p>
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
<p><font class="textcolor" size="2"><script>dw(natSetInfo)</script>
<p><font size="2"><script>dw(natED)</script></font>
<input type="radio" name="natEnable" value="yes" <% if (getIndex("natEnable")==1) write("checked"); %>><font class="textcolor" size="2"><script>dw(enable)</script></font>
<input type="radio" name="natEnable" value="no" <% if (getIndex("natEnable")==0) write("checked"); %>><font class="textcolor" size="2"><script>dw(disable)</script></font> </p>
<p>
<script>dw(fastNatED)</script>
          <input type="radio" name="fastNatEnable" value="yes" <% if (getIndex("fastNatEnable")==1) write("checked"); %>>
          <font class="textcolor" size="2"><script>dw(enable)</script></font>
          <input type="radio" name="fastNatEnable" value="no"
            <% if (getIndex("fastNatEnable")==0) write("checked"); %>>
          <font class="textcolor" size="2"><script>dw(disable)</script></font>
</p>
			</font></p></td></tr></table>
		</td>
	</tr>
</tbody></table>
	<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
		<tbody><tr><td> 
			<div align="right">
<input type=hidden value="/natmain.asp" name="wlan-url">
<script>buffer='<input type=submit value="'+showText(apply1)+'" name="B1" style ="width:100px" onclick="return evaltF();">';document.write(buffer);</script>
		</td></tr>
	</tbody></table>
</form>
</blockquote>
</body></html>