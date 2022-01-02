<html><head><title></title>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script language ='javascript' src ='javascript.js'></script>
<script language ='javascript' src ='file/fwwl-n.var'></script>
</head>
<body class="background">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(fwDos);</script></font></b><br><br>
<table border=0 width="520" cellspacing=0 cellpadding=0 align=center><tr><td>
<font class="textcolor" size="2"><script>dw(fwDosInfo);</script></font></td></tr></table>
<form action=/goform/formPreventionSetup method=POST name="Prevention">
<table border=1 width="520" cellspacing=0 cellpadding=0 align=center>
<tr class="stable"><td colspan="2"><font size="2"><script>dw(fwDosFeature);</script></font></td></tr>

<tr>
<td class="table2" width="80%"><font size="2"><script>dw(fwDosDeath);</script>:&nbsp;</font></td>
<td class="table2" width="20%" align="center">
<input type="checkbox" name="podEnable" value="ON" <% if (getIndex("podEnable")==1) write("checked"); %>></td>
</tr>

<tr>
<td class="table2"><font size="2"><script>dw(fwDosPing);</script>:&nbsp;</font></td>
<td class="table2" align="center">
<input type="checkbox" name="pingEnable" value="ON" <% if (getIndex("pingEnable")==1) write("checked"); %>></td>
</tr>

<tr>
<td class="table2"><font size="2"><script>dw(fwDosScan);</script>:&nbsp;</font></td>
<td class="table2" align="center">
<input type="checkbox" name="scanEnable" value="ON" <% if (getIndex("scanEnable")==1) write("checked"); %>></td>
</tr>

<tr>
<td class="table2"><font size="2"><script>dw(fwDosSync);</script>:&nbsp;</font></td>
<td class="table2" align="center">
<input type="checkbox" name="synEnable" value="ON" <% if (getIndex("synEnable")==1) write("checked"); %>></td>
</tr>
<tr class="rstable"><td colspan="2" align="right">
<script>
	document.write('<input type =\"button\" onclick =\"document.location.replace(\'fwadv.asp\')\" value ="'+showText(wlAdvSettings)+'" class="btnsize">');
</script>
</td></tr>
</table>
<br>
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td align="right">
    <script>buffer='<input type=submit value="'+showText(apply1)+'" name="B1" style ="width:100px">';document.write(buffer);</script>
<input type=hidden value="/fwdos.asp" name="submit-url">
<input type=hidden value="basic" name="basic">
    <script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="document.Prevention.reset();">';document.write(buffer);</script>
 </td>
  </tr>
  </table>
  </form>
  </blockquote>
</body></html>
